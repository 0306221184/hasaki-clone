import { Router } from "express";
import SampleController from "../controllers/sample.controller";
import { IRoute } from "../interfaces/route.interface";
import StripeService from "../lib/stripe";
import { FRONTEND_URL } from "../config/env.config";
import { session } from "passport";

class SampleRoute implements IRoute {
  public router: Router = Router();
  public controller: SampleController = new SampleController();

  constructor() {
    this.initializeRoutes();
  }

  private initializeRoutes() {
    this.router.get("/sample", this.controller.getHello);
    this.router.get("/test-db", this.controller.testDb);
    this.router.get("/create-checkout-session", async (req, res, next) => {
      try {
        const session = await StripeService.getInstance().createCheckoutSession(
          {
            productName: "T shirt",
            productDescription: "Description",
            quantity: 3,
            unitAmount: 2000,
            successUrl: `${FRONTEND_URL}?session_id={CHECKOUT_SESSION_ID}&success=true`,
            cancelUrl: `${FRONTEND_URL}?session_id={CHECKOUT_SESSION_ID}&success=false`,
          }
        );
        res.redirect(session.url as string);
      } catch (error) {
        next(error);
      }
    });
  }
}

export default new SampleRoute();
