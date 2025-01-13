import PromotionRepository from "../repositories/promotion.repository";

export default class PromotionService {
  private readonly repository: PromotionRepository;

  constructor(repository: PromotionRepository = new PromotionRepository()) {
    this.repository = repository;
  }

  public createPromotion = async ({
    code,
    discount_percentage,
    start_date,
    end_date,
  }) => {
    try {
      const promotion = await this.repository.createPromotion({
        code,
        discount_percentage,
        start_date,
        end_date,
      });
      return promotion;
    } catch (error) {
      throw error;
    }
  };

  // Thêm các phương thức khác như getPromotions, getPromotionById, updatePromotion, deletePromotion
}
