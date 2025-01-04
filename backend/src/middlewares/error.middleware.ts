import { NextFunction, Request, Response } from "express";
import Interceptor from "./interceptor.middleware";
import HttpException from "../utils/exception.util";

export default class ErrorMiddleWare extends Interceptor {
  constructor(req: Request, res: Response, next: NextFunction) {
    super(req, res, next);
  }

  static async handleErrors(
    error: HttpException,
    req: Request,
    res: Response,
    next: NextFunction
  ): Promise<void> {
    const status: number = error.status || 500;
    const message: string = error.message || "Something went wrong";

    console.error(
      `[Error Handler]: Path: ${req.path}, Method: ${req.method}, Status: ${status}, ${message}`
    );

    res.status(status).json({ status, message });
  }
}
