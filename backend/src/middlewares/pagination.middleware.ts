import { Request, Response, NextFunction } from "express";

/**
 * PaginationMiddleware class provides pagination functionalities for the application.
 */
export default class PaginationMiddleware {
  private static instance: PaginationMiddleware | null = null;

  private constructor() {}

  /**
   * Returns the singleton instance of PaginationMiddleware.
   * @returns {PaginationMiddleware} - The singleton instance of PaginationMiddleware.
   */
  public static getInstance(): PaginationMiddleware {
    if (this.instance == null) {
      this.instance = new PaginationMiddleware();
    }
    return this.instance;
  }

  /**
   * Middleware function for pagination.
   * Validates and sets pagination parameters in the request object.
   * @param {Request} req - The Express request object.
   * @param {Response} res - The Express response object.
   * @param {NextFunction} next - The Express next middleware function.
   */
  public paginate(req, res: Response, next: NextFunction) {
    const page = parseInt(req.query.page as string) || 1; // Default to page 1
    const limit = parseInt(req.query.limit as string) || 10; // Default to limit 10
    req.pagination = {
      page,
      limit,
      skip: (page - 1) * limit,
    };

    next();
  }
}
