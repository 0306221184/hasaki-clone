import Stripe from "stripe";
import { FRONTEND_URL, STRIPE_SECRET_KEY } from "../config/env.config";

class StripeService {
  private stripe: Stripe;
  private static instance: StripeService | null = null;
  private constructor(secretKey: string) {
    this.stripe = new Stripe(secretKey, {});
  }
  public static getInstance(): StripeService {
    if (this.instance == null) {
      this.instance = new StripeService(STRIPE_SECRET_KEY as string);
    }
    return this.instance;
  }
  // Create a new customer
  public async createCustomer(
    email: string,
    name?: string
  ): Promise<Stripe.Customer> {
    try {
      const customer = await this.stripe.customers.create({
        email,
        name,
      });
      return customer;
    } catch (error) {
      throw error;
    }
  }

  // Retrieve a customer by ID
  public async getCustomer(
    customerId: string
  ): Promise<Stripe.Response<Stripe.Customer | Stripe.DeletedCustomer> | null> {
    try {
      return await this.stripe.customers.retrieve(customerId);
    } catch (error) {
      throw error;
    }
  }

  // Process a one-time payment
  public async processPayment(
    amount: number,
    currency: string,
    paymentMethodId: string,
    customerId?: string
  ): Promise<Stripe.PaymentIntent> {
    try {
      const paymentIntent = await this.stripe.paymentIntents.create({
        amount,
        currency,
        payment_method: paymentMethodId,
        confirm: true,
        customer: customerId,
      });
      return paymentIntent;
    } catch (error) {
      throw error;
    }
  }

  // Create a payment intent
  public async createPaymentIntent(
    amount: number,
    currency: string
  ): Promise<Stripe.PaymentIntent> {
    try {
      const paymentIntent = await this.stripe.paymentIntents.create({
        amount,
        currency,
        confirm: false,
      });
      return paymentIntent;
    } catch (error) {
      throw error;
    }
  }

  public createCheckoutSession = async ({
    paymentMethodsType = ["card"],
    lineItems,
    mode = "payment",
    successUrl,
    cancelUrl,
  }: {
    paymentMethodsType?:
      | Stripe.Checkout.SessionCreateParams.PaymentMethodType[]
      | undefined;
    lineItems: Stripe.Checkout.SessionCreateParams.LineItem[];
    mode?: Stripe.Checkout.SessionCreateParams.Mode | undefined;
    successUrl?: string;
    cancelUrl?: string;
  }): Promise<Stripe.Response<Stripe.Checkout.Session>> => {
    try {
      const session = await this.stripe.checkout.sessions.create({
        payment_method_types: paymentMethodsType,
        line_items: lineItems,
        mode: mode, // For one-time payments, use 'payment' mode
        success_url: successUrl, // Redirect on success
        cancel_url: cancelUrl, // Redirect on cancel
      });
      return session;
    } catch (error) {
      throw error;
    }
  };
}

export default StripeService;
