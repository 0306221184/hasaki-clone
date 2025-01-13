import { NextFunction, Request, Response } from "express";
import ReviewService from "../services/review.service";
import { StatusCodes } from "http-status-codes";

export default class ReviewController {
  private readonly reviewService: ReviewService;

  constructor(service: ReviewService = new ReviewService()) {
    this.reviewService = service;
  }

  public createReview = async (
    req: Request,
    res: Response,
    next: NextFunction
  ) => {
    try {
      const { product_id, user_id, rating, review_text } = req.body;
      const review = await this.reviewService.createReview({
        product_id,
        user_id,
        rating,
        review_text,
      });
      res.status(StatusCodes.OK).json({
        status: "OK",
        message: "Review created successfully!",
        data: review,
      });
    } catch (error) {
      next(error);
    }
  };

  public getReviews = async (
    req: Request,
    res: Response,
    next: NextFunction
  ) => {
    try {
      const reviews = await this.reviewService.getReviews();
      res.status(StatusCodes.OK).json({
        status: "OK",
        message: "Reviews retrieved successfully!",
        data: reviews,
      });
    } catch (error) {
      next(error);
    }
  };
}
