import { NextFunction, Request, Response } from "express";
import ProductService from "../services/product.service";
import { StatusCodes } from "http-status-codes";

export default class ProductController {
  private readonly productService: ProductService;
  constructor(productService: ProductService = new ProductService()) {
    this.productService = productService;
  }
  //POST
  public createProduct = async (
    req: Request,
    res: Response,
    next: NextFunction
  ) => {
    try {
      const {
        name,
        description,
        price,
        discount_price,
        quantity_in_stock,
        category_name,
        rating,
        image_url,
        tags,
        color_variants,
        size_variants,
      } = req.body;

      const productCreated = await this.productService.createProduct({
        name,
        description,
        price,
        discount_price,
        quantity_in_stock,
        category_name,
        rating,
        image_url,
        tags,
        color_variants: color_variants
          ? JSON.stringify(color_variants)
          : color_variants,
        size_variants: size_variants
          ? JSON.stringify(size_variants)
          : size_variants,
      });
      res.status(StatusCodes.OK).json({
        status: "OK",
        message: "Create product successfully!!",
        data: productCreated,
      });
    } catch (error) {
      next(error);
    }
  };
  //GET
  public getManyProducts = async (
    req: Request,
    res: Response,
    next: NextFunction
  ) => {
    try {
      const products = await this.productService.getManyProducts();
      res.status(StatusCodes.OK).json({
        status: "OK",
        message: "Get all products successfully!!",
        data: products,
      });
    } catch (error) {
      next(error);
    }
  };
  public getOneProduct = async (
    req: Request,
    res: Response,
    next: NextFunction
  ) => {
    try {
      const { productId } = req?.params;
      const id = Number(productId);
      const product = await this.productService.getOneProduct(id);
      res.status(StatusCodes.OK).json({
        status: "OK",
        message: "Get one product successfully!!",
        data: product,
      });
    } catch (error) {
      next(error);
    }
  };
  //DELETE
  public deleteOneProduct = async (
    req: Request,
    res: Response,
    next: NextFunction
  ) => {
    try {
      const { productId } = req?.params;
      const id = Number(productId);
      const product = await this.productService.deleteOneProduct(id);
      res.status(StatusCodes.OK).json({
        status: "OK",
        message: "Delete one product successfully!!",
        data: product,
      });
    } catch (error) {
      next(error);
    }
  };
  public deleteManyProducts = async (
    req: Request,
    res: Response,
    next: NextFunction
  ) => {
    try {
      const products = await this.productService.deleteManyProducts();
      res.status(StatusCodes.OK).json({
        status: "OK",
        message: "Delete many products successfully!!",
        data: products,
      });
    } catch (error) {
      next(error);
    }
  };
  //UPDATE
  public updateOneProduct = async (
    req: Request,
    res: Response,
    next: NextFunction
  ) => {
    try {
      const { productId } = req?.params;
      const id = Number(productId);
      const {
        name,
        description,
        price,
        discount_price,
        quantity_in_stock,
        category_name,
        rating,
        image_url,
        color_variants,
        size_variants,
        tags,
      } = req.body;
      const product = await this.productService.updateOneProduct(id, {
        name,
        description,
        price,
        discount_price,
        quantity_in_stock,
        category_name,
        rating,
        image_url,
        color_variants: JSON.stringify(color_variants),
        size_variants: JSON.stringify(size_variants),
        tags,
      });
      res.status(StatusCodes.OK).json({
        status: "OK",
        message: "Update one product successfully!!",
        data: product,
      });
    } catch (error) {
      next(error);
    }
  };
  public updateManyProducts = async (
    req: Request,
    res: Response,
    next: NextFunction
  ) => {
    try {
      const products = await this.productService.deleteManyProducts();
      res.status(StatusCodes.OK).json({
        status: "OK",
        message: "Delete many products successfully!!",
        data: products,
      });
    } catch (error) {
      next(error);
    }
  };
  public toggleStatusProduct = async (
    req: Request,
    res: Response,
    next: NextFunction
  ) => {
    try {
      const { productId } = req?.params;
      const id = Number(productId);
      const product = await this.productService.toggleStatusProduct(id);
      res.status(StatusCodes.OK).json({
        status: "OK",
        message: "Toggle status one product successfully!!",
        data: product,
      });
    } catch (error) {
      next(error);
    }
  };
}
