import { NextFunction, Request, Response } from "express";
import { StatusCodes } from "http-status-codes";
import CategoryService from "../services/category.service";

export default class CategoryController {
  private readonly categoryService: CategoryService;

  constructor(service: CategoryService = new CategoryService()) {
    this.categoryService = service;
  }
  public createCategory = async (
    req: Request,
    res: Response,
    next: NextFunction
  ) => {
    try {
      const { name, description, parent_id, icon_url } = req.body;
      const categoryCreated = await this.categoryService.createCategory({
        name,
        description,
        parent_id,
        icon_url,
      });
      if (categoryCreated) {
        res.status(StatusCodes.OK).json({
          status: "OK",
          message: "Create category successfully!!",
        });
      }
    } catch (error) {
      next(error);
    }
  };
  public getManyCategories = async (
    req: Request,
    res: Response,
    next: NextFunction
  ) => {
    try {
      const categories = await this.categoryService.getManyCategories();
      res.status(StatusCodes.OK).json({
        status: "OK",
        message: "Get categories successfully!!",
        data: categories,
      });
    } catch (error) {
      next(error);
    }
  };
  public getOneCategory = async (
    req: Request,
    res: Response,
    next: NextFunction
  ) => {
    const { categoryId } = req.params;
    const category = await this.categoryService.getOneCategory(categoryId);
    res.status(StatusCodes.OK).json({
      status: "OK",
      message: "Get category successfully!!",
      data: category,
    });
    try {
    } catch (error) {
      next(error);
    }
  };
  public deleteManyCategorys = async (
    req: Request,
    res: Response,
    next: NextFunction
  ) => {
    try {
    } catch (error) {
      next(error);
    }
  };
  public deleteOneCategory = async (
    req: Request,
    res: Response,
    next: NextFunction
  ) => {
    try {
      const { categoryId } = req.params;
      const category = await this.categoryService.deleteOneCategory(categoryId);
      if (category)
        res.status(StatusCodes.OK).json({
          status: "OK",
          message: "Delete category successfully!!",
        });
    } catch (error) {
      next(error);
    }
  };
  public updateManyCategorys = async (
    req: Request,
    res: Response,
    next: NextFunction
  ) => {
    try {
    } catch (error) {
      next(error);
    }
  };
  public updateOneCategory = async (
    req: Request,
    res: Response,
    next: NextFunction
  ) => {
    try {
      const { categoryId } = req.params;
      const { name, description, parent_id, icon_url } = req.body;
      const category = await this.categoryService.updateOneCategory(
        categoryId,
        {
          name,
          description,
          parent_id,
          icon_url,
        }
      );
      if (category)
        res.status(StatusCodes.OK).json({
          status: "OK",
          message: "Update category successfully!!",
        });
    } catch (error) {
      next(error);
    }
  };
  public toggleStatusCategory = async (
    req: Request,
    res: Response,
    next: NextFunction
  ) => {
    try {
      const { categoryId } = req.params;
      const category = await this.categoryService.toggleStatusCategory(
        categoryId
      );
      if (category)
        res.status(StatusCodes.OK).json({
          status: "OK",
          message: "Toggle status category successfully!!",
        });
    } catch (error) {
      next(error);
    }
  };
}
