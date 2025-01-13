import { Router } from "express";
import ReviewController from "../controllers/review.controller";
import { IRoute } from "../interfaces/route.interface";

class ReviewRoute implements IRoute {
  public router: Router = Router();
  public controller: ReviewController = new ReviewController();

  constructor() {
    this.initializeRoutes();
  }

  private initializeRoutes() {
    // Create a new review
    this.router.post("/reviews", this.controller.createReview);
    // Get all reviews
    this.router.get("/reviews", this.controller.getReviews);
  }
}

export default new ReviewRoute();
