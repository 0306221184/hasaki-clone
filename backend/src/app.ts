import cors from "cors";
import "express-async-errors";
import express, { Application, Request } from "express";
import cookieParser from "cookie-parser";
import { FRONTEND_URL, PORT } from "./config/env.config";
import { IRoute } from "./interfaces/route.interface";
import ErrorMiddleWare from "./middlewares/error.middleware";
import expressListRoutes from "express-list-routes";
import passport from "./config/passport.config";
export default class App {
  public app: Application;
  public port: string | number;

  constructor(routes: IRoute[]) {
    this.app = express();
    this.port = PORT || 8000;
    this.initializeMiddlewares();
    this.initializeRoutes(routes);
    this.initializeErrorHandling();
    this.listRoutes();
  }

  public listen(): void {
    this.app.listen(this.port, () => {
      console.info(
        `📡 [server]: Server is running on http://localhost:${this.port}`
      );
    });
  }

  private initializeMiddlewares(): void {
    this.app.get(FRONTEND_URL as string, (req, res) => {
      res.json({
        message: "this is test frontend route",
        userId: req.query.userId,
      });
    });

    this.app.use(cors());
    this.app.use(express.json());
    this.app.use(cors<Request>());
    this.app.use(express.urlencoded({ extended: true }));
    this.app.use(passport.initialize());
    this.app.use(cookieParser());
  }

  private initializeRoutes(routes: IRoute[]): void {
    routes.forEach((route) => {
      this.app.use("/api/v1", route.router);
    });
  }

  private initializeErrorHandling() {
    this.app.use(ErrorMiddleWare.handleErrors);
  }

  private listRoutes() {
    expressListRoutes(this.app, {
      logger: (method, space, path) =>
        console.info(`🚏 [Routes]: ${method}  http://localhost:${PORT}${path}`),
    });
  }
}
