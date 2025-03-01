import { ConnectionPool } from "mssql";
import { IDatabase, IMssql } from "../../interfaces/database.interface";
import { MssqlProvider } from "./mssql.provider";
import { DatabaseProviderNotSupportedException } from "../../utils/database.exception";

export class Database implements IDatabase {
  private static instance: Database | null = null;
  private provider: IDatabase;
  private constructor(provider: IDatabase) {
    this.provider = provider;
  }
  public static mssql(): IMssql {
    if (this.instance == null) {
      this.instance = new Database(MssqlProvider.getInstance());
    }
    return this.instance;
  }
  connect(): Promise<ConnectionPool> {
    return this.provider.connect();
  }
  execProc(procedureName: string, params: any = {}): Promise<any> {
    if (this.provider instanceof MssqlProvider) {
      return this.provider.execProc(procedureName, params);
    }
    throw new DatabaseProviderNotSupportedException();
  }
  query(queryString: string, params: any = {}): Promise<any> {
    if (this.provider instanceof MssqlProvider) {
      return this.provider.query(queryString, params);
    }
    throw new DatabaseProviderNotSupportedException();
  }
  beginTransaction(): Promise<void> {
    if (this.provider instanceof MssqlProvider) {
      return this.provider.beginTransaction();
    }
    throw new DatabaseProviderNotSupportedException();
  }
  commitTransaction(): Promise<void> {
    if (this.provider instanceof MssqlProvider) {
      return this.provider.commitTransaction();
    }
    throw new DatabaseProviderNotSupportedException();
  }
  rollbackTransaction(): Promise<void> {
    if (this.provider instanceof MssqlProvider) {
      return this.provider.rollbackTransaction();
    }
    throw new DatabaseProviderNotSupportedException();
  }
}
