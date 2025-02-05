import { Router } from "express";
import { IRoute } from "../interfaces/route.interface";
import CategoryController from "../controllers/category.controller";

class CategoryRoute implements IRoute {
  public router: Router = Router();
  public controller: CategoryController = new CategoryController();

  constructor() {
    this.initializeRoutes();
  }

  private initializeRoutes() {
    //POST product
    this.router.post("/category", this.controller.createCategory);
    //GET all Categories
    this.router.get("/category", this.controller.getManyCategories);
    //GET one Category
    this.router.get("/category/:categoryId", this.controller.getOneCategory);
    //GET sub of one Category
    this.router.get(
      "/category/sub/:categoryId",
      this.controller.getSubCategory
    );
    //DELETE many Categorys
    // this.router.delete("/category", this.controller.deleteManyCategorys); //pending
    //DELETE one Category
    this.router.delete(
      "/category/:categoryId",
      this.controller.deleteOneCategory
    );
    //PUT many Categorys
    // this.router.put("/category", this.controller.updateManyCategorys); //pending
    //PUT one Category
    this.router.put("/category/:categoryId", this.controller.updateOneCategory);
    //Toggle status one Category
    this.router.patch(
      "/category/:categoryId/toggle-status",
      this.controller.toggleStatusCategory
    );
  }
}

export default new CategoryRoute();
