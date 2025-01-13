import { NextFunction, Request, Response } from "express";
import PromotionService from "../services/promotion.service";
import { StatusCodes } from "http-status-codes";

export default class PromotionController {
  private readonly promotionService: PromotionService;

  constructor(service: PromotionService = new PromotionService()) {
    this.promotionService = service;
  }

  public createPromotion = async (
    req: Request,
    res: Response,
    next: NextFunction
  ) => {
    try {
      const { discount_percentage, start_date, end_date } = req.body;
      const seconds = new Date().getSeconds();
      const code = `${Math.floor(Math.random() * 100)}${String.fromCharCode(
        65 + Math.floor(Math.random() * 26)
      ).toUpperCase()}${Math.floor(Math.random() * 100)}${String.fromCharCode(
        65 + Math.floor(Math.random() * 26)
      ).toUpperCase()}${Math.floor(Math.random() * 100)}${seconds}`;
      const promotion = await this.promotionService.createPromotion({
        code,
        discount_percentage,
        start_date,
        end_date,
      });
      res.status(StatusCodes.CREATED).json({
        status: "OK",
        message: "Promotion created successfully!",
        data: promotion,
      });
    } catch (error) {
      next(error);
    }
  };

  // Thêm các phương thức khác như getPromotions, getPromotionById, updatePromotion, deletePromotion
}
