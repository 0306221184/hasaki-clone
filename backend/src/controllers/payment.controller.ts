import { NextFunction, Request, Response } from "express";
import PaymentService from "../services/payment.service";
import { StatusCodes } from "http-status-codes";

export default class PaymentController {
  private readonly paymentServices: PaymentService;

  constructor() {
    this.paymentServices = new PaymentService();
  }
  public placeOrder = async (
    req: Request,
    res: Response,
    next: NextFunction
  ) => {
    try {
      const { user_id, currency, note } = req.body;
      const result = await this.paymentServices.createOrder(
        user_id,
        currency,
        note
      );
      if (result) {
        res.status(StatusCodes.OK).json({
          status: "OK",
          message: "Order placed successfully!",
        });
      }
    } catch (error) {
      next(error);
    }
  };
  public processPayment = async (
    req: Request,
    res: Response,
    next: NextFunction
  ) => {
    const { order_id, payment_method } = req.body;
    const result = await this.paymentServices.processPayment(
      order_id,
      payment_method
    );
    if (result.url) {
      res.send(result.url);
    }
  };
  public paymentSuccess = async (
    req: Request,
    res: Response,
    next: NextFunction
  ) => {
    try {
      const { session_id } = req.query;
      const result = await this.paymentServices.paymentSuccess(
        session_id as string
      );
      if (result) {
        res.status(StatusCodes.OK).json({
          status: "OK",
          message: "Payment successful!",
        });
      } else {
        res.status(StatusCodes.BAD_REQUEST).json({
          status: "ERROR",
          message: "Payment failed!",
        });
      }
    } catch (error) {
      next(error);
    }
  };
  public paymentCancel = async (
    req: Request,
    res: Response,
    next: NextFunction
  ) => {
    try {
      const { session_id } = req.query;
      const result = await this.paymentServices.paymentCancel(
        session_id as string
      );
      if (result) {
        res.status(StatusCodes.OK).json({
          status: "OK",
          message: "Payment cancelled!",
        });
      } else {
        res.status(StatusCodes.BAD_REQUEST).json({
          status: "ERROR",
          message: "Payment failed!",
        });
      }
    } catch (error) {
      next(error);
    }
  };
  public cancelOrder = async (
    req: Request,
    res: Response,
    next: NextFunction
  ) => {
    try {
      const { order_id } = req.params;
      const result = await this.paymentServices.cancelOrder(parseInt(order_id));
      if (result) {
        res.status(StatusCodes.OK).json({
          status: "OK",
          message: "Order cancelled successfully!",
        });
      }
    } catch (error) {
      next(error);
    }
  };
}
