import { Router } from "express";
import CartController from "../controllers/cart.controller";
import { IRoute } from "../interfaces/route.interface";

class CartRoute implements IRoute {
  public router: Router = Router();
  public controller: CartController = new CartController();

  constructor() {
    this.initializeRoutes();
  }

  private initializeRoutes() {
    // Create a new cart item
    this.router.post("/cart", this.controller.createCartItem);
    // Get all cart items
    this.router.get("/cart", this.controller.getCartItems);
    // Get a single cart item by ID
    this.router.get("/cart/:cartItemId", this.controller.getCartItem);
    // Update a cart item by ID
    this.router.put("/cart/:cartItemId", this.controller.updateCartItem);
    // Delete a cart item by ID
    this.router.delete("/cart/:cartItemId", this.controller.deleteCartItem);
  }
}

export default new CartRoute();
