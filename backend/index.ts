import App from "./src/app";
import SampleRoute from "./src/routes/sample.route";
import AuthRoute from "./src/routes/auth.route";
import ProductRoute from "./src/routes/product.route";
import CategoryRoute from "./src/routes/category.route";

const app = new App([CategoryRoute]);

app.listen();
