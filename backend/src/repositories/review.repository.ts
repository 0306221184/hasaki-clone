import { Database } from "../lib/database/database";

export default class ReviewRepository {
  public createReview = async ({
    product_id,
    user_id,
    rating,
    review_text,
  }) => {
    try {
      const result = await Database.mssql().query(
        `
        INSERT INTO reviews (product_id, user_id, rating, review_text)
        VALUES (@product_id, @user_id, @rating, @review_text);
        SELECT SCOPE_IDENTITY() as id;
        `,
        { product_id, user_id, rating, review_text }
      );
      return result;
    } catch (error) {
      throw error;
    }
  };

  public getReviews = async () => {
    try {
      const result = await Database.mssql().query(`SELECT * FROM reviews`);
      return result;
    } catch (error) {
      throw error;
    }
  };
}
