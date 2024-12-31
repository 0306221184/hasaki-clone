type QueryParts = {
  select?: string[];
  from?: string;
  where?: string;
  groupBy?: string[];
  having?: string;
  orderBy?: { fields: string[]; by: string };
  limit?: number;
};

export default class QueryBuilder {
  private static instance: QueryBuilder;
  private parts: QueryParts = {};
  private executed: boolean = false;

  // Private constructor to prevent direct instantiation
  private constructor() {}

  /**
   * Get the singleton instance of QueryBuilder
   */
  public static getInstance(): QueryBuilder {
    if (!QueryBuilder.instance) {
      QueryBuilder.instance = new QueryBuilder();
    }
    return QueryBuilder.instance;
  }

  /**
   * Reset the query parts and execution state
   */
  public reset(): this {
    this.parts = {};
    this.executed = false;
    return this;
  }

  select(fields: string[]): Omit<QueryBuilder, "select"> {
    if (this.parts.select || this.parts.from || this.executed) {
      throw new Error("'select()' must be called first, and only once.");
    }
    this.parts.select = fields;
    return this;
  }

  from(table: string): Omit<QueryBuilder, "from"> {
    if (!this.parts.select) {
      throw new Error("'select()' must be called before 'from()'.");
    }
    if (this.parts.from || this.executed) {
      throw new Error("'from()' must be called only once.");
    }
    this.parts.from = table;
    return this;
  }

  where(condition: string): this {
    if (this.executed) {
      throw new Error("'where()' cannot be called after query execution.");
    }
    this.parts.where = condition;
    return this;
  }

  groupBy(fields: string[]): this {
    if (this.executed) {
      throw new Error("'groupBy()' cannot be called after query execution.");
    }
    this.parts.groupBy = fields;
    return this;
  }

  having(condition: string): this {
    if (this.executed) {
      throw new Error("'having()' cannot be called after query execution.");
    }
    this.parts.having = condition;
    return this;
  }

  orderBy(fields: string[], by: "ASC" | "DESC"): this {
    if (this.executed) {
      throw new Error("'orderBy()' cannot be called after query execution.");
    }
    this.parts.orderBy = { fields, by };
    return this;
  }

  limit(rows: number): this {
    if (this.executed) {
      throw new Error("'limit()' cannot be called after query execution.");
    }
    this.parts.limit = rows;
    return this;
  }

  buildSqlServerQuery(): string {
    if (!this.parts.select || !this.parts.from) {
      throw new Error(
        "'select()' and 'from()' must be called before building the query."
      );
    }

    let query = `SELECT ${this.parts.select.join(", ")} FROM ${
      this.parts.from
    }`;

    if (this.parts.where) {
      query += ` WHERE ${this.parts.where}`;
    }

    if (this.parts.groupBy) {
      query += ` GROUP BY ${this.parts.groupBy.join(", ")}`;
    }

    if (this.parts.having) {
      query += ` HAVING ${this.parts.having}`;
    }

    if (this.parts.orderBy) {
      query += ` ORDER BY ${this.parts.orderBy.fields.join(", ")} ${
        this.parts.orderBy.by
      }`;
    }

    if (this.parts.limit !== undefined) {
      query += ` OFFSET 0 ROWS FETCH NEXT ${this.parts.limit} ROWS ONLY`;
    }

    this.executed = true;
    return query;
  }

  buildPostgreSQLQuery(): string {
    if (!this.parts.select || !this.parts.from) {
      throw new Error(
        "'select()' and 'from()' must be called before building the query."
      );
    }

    let query = `SELECT ${this.parts.select.join(", ")} FROM ${
      this.parts.from
    }`;

    if (this.parts.where) {
      query += ` WHERE ${this.parts.where}`;
    }

    if (this.parts.groupBy) {
      query += ` GROUP BY ${this.parts.groupBy.join(", ")}`;
    }

    if (this.parts.having) {
      query += ` HAVING ${this.parts.having}`;
    }

    if (this.parts.orderBy) {
      query += ` ORDER BY ${this.parts.orderBy.fields.join(", ")} ${
        this.parts.orderBy.by
      }`;
    }

    if (this.parts.limit !== undefined) {
      query += ` LIMIT ${this.parts.limit}`;
    }

    this.executed = true;
    return query;
  }
}
