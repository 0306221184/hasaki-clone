import { NextFunction, Request, Response } from "express";
import CartService from "../services/cart.service";
import { StatusCodes } from "http-status-codes";

export default class CartController {
  private readonly cartService: CartService;

  constructor(service: CartService = new CartService()) {
    this.cartService = service;
  }

  public createCartItem = async (
    req: Request,
    res: Response,
    next: NextFunction
  ) => {
    try {
      const { cart_id, product_id, quantity, price } = req.body;
      const cartItem = await this.cartService.createCartItem({
        cart_id,
        product_id,
        quantity,
        price,
      });
      if (cartItem) {
        res.status(StatusCodes.CREATED).json({
          status: "OK",
          message: "Cart item created successfully!",
        });
      }
    } catch (error) {
      next(error);
    }
  };

  public getCartItems = async (
    req: Request,
    res: Response,
    next: NextFunction
  ) => {
    try {
      const cartItems = await this.cartService.getCartItems();
      res.status(StatusCodes.OK).json({
        status: "OK",
        message: "Cart items retrieved successfully!",
        data: cartItems,
      });
    } catch (error) {
      next(error);
    }
  };

  public getCartItem = async (
    req: Request,
    res: Response,
    next: NextFunction
  ) => {
    try {
      const { cartItemId } = req.params;
      const cartItem = await this.cartService.getCartItem(Number(cartItemId));
      res.status(StatusCodes.OK).json({
        status: "OK",
        message: "Cart item retrieved successfully!",
        data: cartItem,
      });
    } catch (error) {
      next(error);
    }
  };

  public updateCartItem = async (
    req: Request,
    res: Response,
    next: NextFunction
  ) => {
    try {
      const { cartItemId } = req.params;
      const { quantity, price, product_id } = req.body;
      const cartItem = await this.cartService.updateCartItem(
        Number(cartItemId),
        { quantity, price, product_id }
      );
      res.status(StatusCodes.OK).json({
        status: "OK",
        message: "Cart item updated successfully!",
        data: cartItem,
      });
    } catch (error) {
      next(error);
    }
  };

  public deleteCartItem = async (
    req: Request,
    res: Response,
    next: NextFunction
  ) => {
    try {
      const { cartItemId } = req.params;
      await this.cartService.deleteCartItem(Number(cartItemId));
      res.status(StatusCodes.OK).json({
        status: "OK",
        message: "Cart item deleted successfully!",
      });
    } catch (error) {
      next(error);
    }
  };
}
