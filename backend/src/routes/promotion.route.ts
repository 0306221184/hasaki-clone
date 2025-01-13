import { Router } from "express";
import PromotionController from "../controllers/promotion.controller";
import { IRoute } from "../interfaces/route.interface";

class PromotionRoute implements IRoute {
  public router: Router = Router();
  public controller: PromotionController = new PromotionController();

  constructor() {
    this.initializeRoutes();
  }

  private initializeRoutes() {
    // Tạo một khuyến mãi mới
    this.router.post("/promotions", this.controller.createPromotion);
    // Lấy tất cả khuyến mãi
    //     this.router.get("/promotions", this.controller.getPromotions);
    //     // Lấy khuyến mãi theo ID
    //     this.router.get(
    //       "/promotions/:promotionId",
    //       this.controller.getPromotionById
    //     );
    //     // Cập nhật khuyến mãi theo ID
    //     this.router.put(
    //       "/promotions/:promotionId",
    //       this.controller.updatePromotion
    //     );
    //     // Xóa khuyến mãi theo ID
    //     this.router.delete(
    //       "/promotions/:promotionId",
    //       this.controller.deletePromotion
    //     );
    //   }
  }
}

export default new PromotionRoute();
