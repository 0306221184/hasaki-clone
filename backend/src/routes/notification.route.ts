import { Router } from "express";
import NotificationController from "../controllers/notification.controller";
import { IRoute } from "../interfaces/route.interface";

class NotificationRoute implements IRoute {
  public router: Router = Router();
  public controller: NotificationController = new NotificationController();

  constructor() {
    this.initializeRoutes();
  }

  private initializeRoutes() {
    // Create a new notification
    this.router.post("/notifications", this.controller.createNotification);
    // Get all notifications
    this.router.get("/notifications", this.controller.getNotifications);
  }
}

export default new NotificationRoute();
