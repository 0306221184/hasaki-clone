import { Database } from "../lib/database/database";

export default class CartRepository {
  async createCart(userId: number): Promise<any> {
    try {
      const newCart = await Database.mssql().query(
        `
        INSERT INTO carts (user_id)
        VALUES (@user_id)
        SELECT SCOPE_IDENTITY() as id;
      `,
        {
          user_id: userId,
        }
      );
      return newCart;
    } catch (error) {
      throw error;
    }
  }
  public createCartItem = async ({
    cart_id,
    product_id,
    quantity = 1,
    price,
  }) => {
    try {
      // Bắt đầu transaction
      await Database.mssql().beginTransaction();

      // Sử dụng MERGE để thực hiện cả INSERT và UPDATE trong một câu lệnh
      const result = await Database.mssql().query(
        `
            MERGE INTO cart_items AS target
            USING (SELECT @cart_id AS cart_id, @product_id AS product_id) AS source
            ON (target.cart_id = source.cart_id AND target.product_id = source.product_id)
            WHEN MATCHED THEN
              UPDATE SET quantity = target.quantity + @quantity
            WHEN NOT MATCHED THEN
              INSERT (cart_id, product_id, quantity, price)
              VALUES (@cart_id, @product_id, @quantity, @price);
            `,
        { cart_id, product_id, quantity, price }
      );

      // Commit transaction
      await Database.mssql().commitTransaction();

      return result;
    } catch (error) {
      // Rollback transaction nếu có lỗi
      await Database.mssql().rollbackTransaction();
      throw error;
    }
  };

  public getCartItems = async () => {
    try {
      const result = await Database.mssql().query(`
        SELECT 
          id,
          cart_id,
          product_id, 
          quantity,
          price
        FROM cart_items 
      `);
      return result;
    } catch (error) {
      throw error;
    }
  };

  public getCartItem = async (id: number) => {
    try {
      const result = await Database.mssql().query(
        `
        SELECT 
          id,
          cart_id,
          product_id,
          quantity, 
          price
        FROM cart_items
        WHERE id = @id
      `,
        { id }
      );
      return result;
    } catch (error) {
      throw error;
    }
  };

  public updateCartItem = async (
    id: number,
    { quantity, price, product_id }
  ) => {
    try {
      const result = await Database.mssql().query(
        `
        UPDATE cart_items
        SET ${quantity !== undefined ? "quantity = @quantity," : ""} 
            ${price !== undefined ? "price = @price" : ""}
        ${
          quantity === undefined && price === undefined
            ? "quantity = quantity"
            : ""
        }  
        WHERE id = @id AND product_id = @product_id
      `,
        { id, quantity, price, product_id }
      );
      return result;
    } catch (error) {
      throw error;
    }
  };

  public deleteCartItem = async (id: number) => {
    try {
      const result = await Database.mssql().query(
        `
        DELETE FROM cart_items
        WHERE id = @id
      `,
        { id }
      );
      return result;
    } catch (error) {
      throw error;
    }
  };
}
