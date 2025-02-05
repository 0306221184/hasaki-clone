import App from "./src/app";
import AuthRoute from "./src/routes/auth.route";
import ProductRoute from "./src/routes/product.route";
import CategoryRoute from "./src/routes/category.route";
import CartRoute from "./src/routes/cart.route";
import PaymentRoute from "./src/routes/payment.route";

const app = new App([
  PaymentRoute,
  CartRoute,
  ProductRoute,
  CategoryRoute,
  AuthRoute,
]);

app.listen();
