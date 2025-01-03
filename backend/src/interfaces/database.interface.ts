import sql from "mssql/msnodesqlv8";
interface IDatabase {
  connect(): Promise<sql.ConnectionPool>;
}
interface IMssql extends IDatabase {
  execProc(procedureName: string, params?: any): Promise<any>;
  query(queryString: string, params?: any): Promise<any>;
}
export { IDatabase, IMssql };
