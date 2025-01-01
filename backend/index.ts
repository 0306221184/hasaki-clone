import App from "./src/app";
import SampleRoute from "./src/routes/sample.route";
import AuthRoute from "./src/routes/auth.route";
import ProductRoute from "./src/routes/product.route";
const app = new App([SampleRoute, AuthRoute, ProductRoute]);

app.listen();
