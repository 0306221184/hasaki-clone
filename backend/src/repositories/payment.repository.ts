import Stripe from "stripe";
import { Database } from "../lib/database/database";
import StripeService from "../lib/stripe";
import { BACKEND_URL } from "../config/env.config";
import InsertBuilder from "../helper/builder/sql_builder/insert_builder.helper";
export default class PaymentRepository {
  public createOrder = async (
    user_id: number,
    currency: string = "usd",
    note: string = "",
    promotion_code?: string,
    phone_number?: string,
    address?: {
      street: string;
      city: string;
    }
  ) => {
    await Database.mssql().beginTransaction();
    try {
      const cartItems = await Database.mssql().query(
        "SELECT product_id, quantity, price, total_price FROM carts INNER JOIN cart_items ON carts.id = cart_items.cart_id WHERE carts.user_id = @user_id",
        {
          user_id,
        }
      );
      const promotion = await Database.mssql().query(
        "SELECT id FROM promotions WHERE code = @promotion_code",
        {
          promotion_code,
        }
      );
      if (cartItems == null) {
        throw new Error("Cart is empty");
      }

      const total = Array.isArray(cartItems)
        ? cartItems.reduce((acc, item) => acc + item.total_price, 0)
        : cartItems.total_price;

      const insertAddressSql =
        "INSERT INTO addresses (user_id, street_address, city) VALUES (@user_id, @street_address, @city) SELECT SCOPE_IDENTITY() AS id;";
      const addressCreated = await Database.mssql().query(insertAddressSql, {
        user_id,
        street_address: address?.street,
        city: address?.city,
      });

      const insertShippingSql =
        "INSERT INTO shipping (address_id, phone_number) VALUES (@address_id, @phone_number) SELECT SCOPE_IDENTITY() AS id;";
      const shippingCreated = await Database.mssql().query(insertShippingSql, {
        address_id: addressCreated?.id,
        phone_number: phone_number,
      });

      const insertOrderSql =
        "INSERT INTO orders (user_id, note, total_amount, currency, order_status, shipping_id, promotion_id) VALUES (@user_id, @note, @total_amount, @currency, @order_status, @shipping_id, @promotion_id) SELECT SCOPE_IDENTITY() AS id;";
      const orderCreated = await Database.mssql().query(insertOrderSql, {
        user_id,
        note,
        total_amount: total,
        currency,
        order_status: "pending",
        shipping_id: shippingCreated?.id,
        promotion_id: promotion?.id,
      });

      const orderDetailsPromises = cartItems.map(async (item) => {
        const insertOrderDetailsSql = InsertBuilder.getInstance()
          .into("order_details")
          .column(["order_id", "product_id", "quantity"])
          .values([[orderCreated.id, item.product_id, item.quantity]])
          .buildSqlServerInsert();

        return Database.mssql().query(insertOrderDetailsSql);
      });

      await Promise.all(orderDetailsPromises);
      await Database.mssql().commitTransaction();
      return orderCreated;
    } catch (error) {
      await Database.mssql().rollbackTransaction();
      throw error;
    }
  };
  public processPayment = async (order_id: number, payment_method: string) => {
    try {
      const order = await Database.mssql().query(
        "SELECT orders.id AS order_id, orders.total_amount AS total_amount, orders.currency AS currency, products.name AS product_name,products.image_url AS product_image,products.description AS product_description, order_details.quantity AS quantity, products.price AS price FROM orders INNER JOIN order_details ON orders.id = order_details.order_id INNER JOIN products ON order_details.product_id = products.id WHERE orders.id = @order_id AND orders.order_status = 'pending'",
        {
          order_id,
        }
      );

      if (!order) {
        throw new Error("Order not found or order already handled!!");
      }
      if (Array.isArray(order)) {
        const lineItems: Stripe.Checkout.SessionCreateParams.LineItem[] =
          order.map((item) => {
            return {
              price_data: {
                currency: item.currency,
                product_data: {
                  name: item.product_name,
                  description: item.product_description,
                  images: [item.product_image],
                },
                unit_amount: item.price,
              },
              quantity: item.quantity,
            };
          });
        const stripeCheckoutSession =
          await StripeService.getInstance().createCheckoutSession({
            lineItems,
            mode: "payment",
            successUrl: `${BACKEND_URL}/payment/success`,
            cancelUrl: `${BACKEND_URL}/payment/cancel`,
          });

        await Database.mssql().query(
          "INSERT INTO payments (order_id, stripe_checkout_session_id, payment_method) VALUES (@order_id, @stripe_checkout_session_id, @payment_method)",
          {
            order_id,
            stripe_checkout_session_id: stripeCheckoutSession.id,
            payment_method,
          }
        );

        return stripeCheckoutSession;
      } else {
        const lineItems: Stripe.Checkout.SessionCreateParams.LineItem[] = [
          order,
        ].map((item) => ({
          price_data: {
            currency: item.currency,
            product_data: {
              name: item.product_name,
              description: item.product_description,
              images: [item.product_image],
            },
            unit_amount: item.price,
          },
          quantity: item.quantity,
        }));
        const stripeCheckoutSession =
          await StripeService.getInstance().createCheckoutSession({
            lineItems,
            mode: "payment",
            successUrl: `${BACKEND_URL}/api/v1/payment/success?session_id={CHECKOUT_SESSION_ID}`,
            cancelUrl: `${BACKEND_URL}/api/v1/payment/cancel?session_id={CHECKOUT_SESSION_ID}`,
          });

        await Database.mssql().query(
          "INSERT INTO payments (order_id, stripe_checkout_session_id, payment_method) VALUES (@order_id, @stripe_checkout_session_id, @payment_method)",
          {
            order_id,
            stripe_checkout_session_id: stripeCheckoutSession.id,
            payment_method,
          }
        );

        return stripeCheckoutSession;
      }
    } catch (error) {
      throw error;
    }
  };
  public paymentSuccess = async (session_id: string | undefined) => {
    try {
      const order = await Database.mssql().query(
        "SELECT order_id FROM payments WHERE stripe_checkout_session_id = @session_id",
        { session_id }
      );

      if (order) {
        await Database.mssql().query(
          "UPDATE payments SET payment_status = 'success' WHERE stripe_checkout_session_id = @session_id",
          { session_id }
        );

        await Database.mssql().query(
          "UPDATE orders SET order_status = 'done' WHERE id = @order_id",
          { order_id: order.order_id }
        );
        return true;
      }
      return false;
    } catch (error) {
      throw error;
    }
  };
  public paymentCancel = async (session_id: string | undefined) => {
    try {
      await Database.mssql().query(
        "UPDATE payments SET payment_status = 'failed' WHERE stripe_checkout_session_id = @session_id",
        { session_id }
      );
      return true;
    } catch (error) {
      throw error;
    }
  };
  public cancelOrder = async (order_id: number) => {
    try {
      const order = await Database.mssql().query(
        "SELECT id, order_status FROM orders WHERE id = @order_id",
        { order_id }
      );

      if (!order) {
        throw new Error("Order not found");
      }
      if (order.order_status == "done") {
        throw new Error("Order already done");
      }
      if (order.order_status == "canceled") {
        throw new Error("Order already canceled");
      }
      await Database.mssql().query(
        "UPDATE orders SET order_status = 'canceled' WHERE id = @order_id",
        { order_id }
      );
      return true;
    } catch (error) {
      throw error;
    }
  };
  public getOrderById = async (order_id: number) => {
    try {
      const order = await Database.mssql().query(
        "SELECT * FROM orders WHERE id = @order_id",
        { order_id }
      );
      return order;
    } catch (error) {
      throw error;
    }
  };
}
