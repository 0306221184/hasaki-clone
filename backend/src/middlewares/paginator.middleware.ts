import { NextFunction, Response, Request } from "express";
import { Database } from "../lib/database/database";
class PaginatorMiddleware {
  paginate = async (req, res: Response, next: NextFunction) => {
    const page = parseInt(req?.query.page as string) || 1;
    const limit = parseInt(req?.query.limit as string) || 10;
    const offset = (page - 1) * limit;
    const paginateDql = `SELECT * FROM products ORDER BY created_at ASC OFFSET ${offset} ROWS FETCH NEXT ${limit} ROWS ONLY
                            SELECT COUNT(id) AS total FROM products`;
    const paginateProducts = await Database.mssql().query(paginateDql);
    req.paginate = paginateProducts;
    return next();
  };
}
export default new PaginatorMiddleware();
