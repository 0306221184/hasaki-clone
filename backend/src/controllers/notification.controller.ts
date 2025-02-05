import { NextFunction, Request, Response } from "express";
import NotificationService from "../services/notification.service";
import { StatusCodes } from "http-status-codes";

export default class NotificationController {
  private readonly notificationService: NotificationService;

  constructor(service: NotificationService = new NotificationService()) {
    this.notificationService = service;
  }

  public createNotification = async (
    req: Request,
    res: Response,
    next: NextFunction
  ) => {
    try {
      const { user_id, message, type, is_read, image_url } = req.body;
      const notification = await this.notificationService.createNotification({
        user_id,
        message,
        type,
        is_read,
        image_url,
      });
      res.status(StatusCodes.CREATED).json({
        status: "OK",
        message: "Notification created successfully!",
        data: notification,
      });
    } catch (error) {
      next(error);
    }
  };

  public getNotifications = async (
    req: Request,
    res: Response,
    next: NextFunction
  ) => {
    try {
      const notifications = await this.notificationService.getNotifications();
      res.status(StatusCodes.OK).json({
        status: "OK",
        message: "Notifications retrieved successfully!",
        data: notifications,
      });
    } catch (error) {
      next(error);
    }
  };
}
