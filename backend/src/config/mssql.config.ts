import sql from "mssql/msnodesqlv8";
import {
  DB_DATABASE_NAME as database,
  DB_SERVER as server,
} from "./env.config";
const config: sql.config = {
  server: server || "TINWANA",
  database,
  options: {
    trustedConnection: true,
    trustServerCertificate: true,
  },
  driver: "msnodesqlv8",
};
export default config;
