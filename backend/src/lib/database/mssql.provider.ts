import sql from "mssql/msnodesqlv8";
import mssqlConfig from "../../config/mssql.config";
import { IMssql } from "../../interfaces/database.interface";

export class MssqlProvider implements IMssql {
  private static instance: MssqlProvider | null = null;
  private config: sql.config;
  private pool: sql.ConnectionPool | null = null;

  private constructor(config: sql.config) {
    this.config = config;
  }

  // Singleton instance getter
  public static getInstance(): MssqlProvider {
    if (this.instance == null) {
      this.instance = new MssqlProvider(mssqlConfig);
    }
    return this.instance;
  }

  // Set a new configuration (if needed)
  public setConfig(config: sql.config): MssqlProvider {
    this.config = config;
    return this;
  }

  // Connect to the database, if not already connected
  public async connect(): Promise<sql.ConnectionPool> {
    try {
      if (this.pool) {
        return this.pool; // Return the existing pool if it's already connected
      }

      // If there's no pool, create and connect a new one
      this.pool = await sql.connect(this.config);
      console.log("Connected to MSSQL server");
      return this.pool;
    } catch (err) {
      throw new Error("Database connection failed: " + err);
    }
  }

  // Execute a stored procedure with parameters
  async execProc(procedureName: string, params: any = {}): Promise<any> {
    try {
      const pool = await this.connect();
      const request = pool.request();

      // Add parameters to the request
      for (const [paramName, paramValue] of Object.entries(params)) {
        request.input(paramName, paramValue);
      }

      // Execute the stored procedure
      const result: sql.IProcedureResult<any> = await request.execute(
        procedureName
      );

      // Return the result
      if (result.recordset?.length === 0 || !result.recordset) {
        return null;
      }
      if (result.recordset?.length === 1) {
        return result.recordset[0];
      }
      return result.recordset;
    } catch (err) {
      throw err;
    }
  }

  // Execute a SQL query with parameters
  async query(queryString: string, params: any = {}): Promise<any> {
    try {
      const pool = await this.connect();
      const request = pool.request();

      // Add parameters to the request
      for (const [paramName, paramValue] of Object.entries(params)) {
        request.input(paramName, paramValue);
      }

      // Execute the SQL query
      const result: sql.IResult<any> = await request.query(queryString);

      // Return the result
      if (result.recordset?.length === 0 || !result.recordset) {
        return null;
      }
      if (result.recordset?.length === 1) {
        return result.recordset[0];
      }
      return result.recordset;
    } catch (err) {
      throw err;
    }
  }

  // Close the connection pool (optional, use when you need to close the application or service)
  public async close(): Promise<void> {
    try {
      if (this.pool) {
        await this.pool.close();
        console.log("MSSQL connection pool closed.");
      }
    } catch (err) {
      console.error("Error closing MSSQL connection pool:", err);
    }
  }
}
