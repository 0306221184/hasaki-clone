import { Router } from "express";
import PaymentController from "../controllers/payment.controller";
import { IRoute } from "../interfaces/route.interface";

class PaymentRoute implements IRoute {
  public router: Router = Router();
  public controller: PaymentController = new PaymentController();

  constructor() {
    this.initializeRoutes();
  }

  private initializeRoutes() {
    // Tạo đơn hàng mới
    this.router.post("/place-order", this.controller.placeOrder);
    // Xử lý thanh toán
    this.router.post(
      "/create-checkout-session",
      this.controller.processPayment
    );
    // Xử lý thanh toán thành công
    this.router.get("/payment/success", this.controller.paymentSuccess);
    // Xử lý thanh toán thất bại
    this.router.get("/payment/cancel", this.controller.paymentCancel);
    // Hủy đơn hàng
    this.router.post("/cancel-order/:order_id", this.controller.cancelOrder);
  }
}

export default new PaymentRoute();
