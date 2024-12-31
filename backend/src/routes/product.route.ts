import { Router } from "express";
import ProductController from "../controllers/product.controller";
import { IRoute } from "../interfaces/route.interface";
import AuthMiddleware from "../middlewares/auth.middleware";

class ProductRoute implements IRoute {
  public router: Router = Router();
  public controller: ProductController = new ProductController();

  constructor() {
    this.initializeRoutes();
  }

  private initializeRoutes() {
    //POST product
    this.router.post("/product", this.controller.createProduct);
    //GET all products
    this.router.get("/product", this.controller.getManyProducts);
    //GET one product
    this.router.get("/product/:productId", this.controller.getOneProduct);
    //DELETE many products
    // this.router.delete("/product", this.controller.deleteManyProducts); //pending
    //DELETE one product
    this.router.delete("/product/:productId", this.controller.deleteOneProduct);
    //PUT many products
    // this.router.put("/product", this.controller.updateManyProducts); //pending
    //PUT one product
    this.router.put("/product/:productId", this.controller.updateOneProduct);
    //Toggle status one product
    this.router.patch(
      "/product/:productId/toggle-status",
      this.controller.toggleStatusProduct
    );
  }
}

export default new ProductRoute();
