import { Database } from "../lib/database/database";

export default class PromotionRepository {
  public createPromotion = async ({
    code,
    discount_percentage,
    start_date,
    end_date,
  }) => {
    try {
      const result = await Database.mssql().query(
        `
        INSERT INTO promotions (code, discount_percentage, start_date, end_date)
        VALUES (@code, @discount_percentage, @start_date, @end_date);
        SELECT SCOPE_IDENTITY() as id;
        `,
        { code, discount_percentage, start_date, end_date }
      );
      return result;
    } catch (error) {
      throw error;
    }
  };

  // Thêm các phương thức khác như getPromotions, getPromotionById, updatePromotion, deletePromotion
}
