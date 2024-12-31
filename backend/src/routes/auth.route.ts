import { Router } from "express";
import AuthController from "../controllers/auth.controller";
import { IRoute } from "../interfaces/route.interface";
import passport from "passport";
import AuthMiddleware from "../middlewares/auth.middleware";

class AuthRoute implements IRoute {
  public router: Router = Router();
  public controller: AuthController = new AuthController();

  constructor() {
    this.initializeRoutes();
  }

  private initializeRoutes() {
    //Register
    this.router.post("/auth/register", this.controller.register);
    //google login
    this.router.get(
      "/auth/google/login",
      passport.authenticate("google", {
        session: false,
        scope: ["profile", "email"],
      })
    );
    //google login callback
    this.router.get(
      "/auth/google/login/callback",
      passport.authenticate("google", { session: false }),
      this.controller.googleLogin
    );
    //local login
    this.router.post(
      "/auth/local/login",
      passport.authenticate("local", { session: false }),
      this.controller.login
    );
    //firebase login
    this.router.post("/auth/firebase/login", this.controller.firebaseLogin);
    //logout
    this.router.post(
      "/auth/logout",
      AuthMiddleware.getInstance().authentication,
      this.controller.logout
    );
  }
}

export default new AuthRoute();
