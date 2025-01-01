import { NextFunction, Request, Response } from "express";
import SampleService from "../services/sample.service";
import { StatusCodes } from "http-status-codes";
import { Database } from "../lib/database/database";

export default class SampleController {
  private readonly sampleServices: SampleService;

  constructor() {
    this.sampleServices = new SampleService();
  }

  public async testDb(
    request: Request,
    response: Response,
    next: NextFunction
  ) {
    try {
      const result = await (await Database.mssql()).query("SELECT * FROM TEST");

      response.status(StatusCodes.OK).send(result);
    } catch (error) {
      next(error);
    }
  }
  public getHello = (
    request: Request,
    response: Response,
    next: NextFunction
  ) => {
    response.status(StatusCodes.OK).send(this.sampleServices.sayHello("Dave"));
  };
}
