export default class InsertBuilder {
  private static instance: InsertBuilder;
  private tableName: string = "";
  private columns: string[] = [];
  private valuesList: (string | number | null)[][] = [];

  // Private constructor to prevent direct instantiation
  private constructor() {}

  /**
   * Get the singleton instance of InsertBuilder
   */
  public static getInstance(): InsertBuilder {
    if (!InsertBuilder.instance) {
      InsertBuilder.instance = new InsertBuilder();
    }
    return InsertBuilder.instance;
  }

  /**
   * Reset the builder (useful for starting a new query)
   */
  public reset(): this {
    this.tableName = "";
    this.columns = [];
    this.valuesList = [];
    return this;
  }

  /**
   * Set the table name for the insert statement
   */
  public into(tableName: string): this {
    this.tableName = tableName;
    return this;
  }

  /**
   * Set the column names for the insert statement
   */
  public column(columns: string[]): this {
    this.columns = columns;
    return this;
  }

  /**
   * Add a single or multiple rows of values for the insert statement
   */
  public values(...rows: (string | number | null)[][]): this {
    rows.forEach((row) => {
      if (row.length !== this.columns.length) {
        throw new Error(
          `Values count (${row.length}) must match columns count (${this.columns.length}).`
        );
      }
      this.valuesList.push(row);
    });
    return this;
  }

  /**
   * Build the SQL insert statement
   */
  public buildSqlServerInsert(): string {
    if (!this.tableName) {
      throw new Error("Table name is not specified.");
    }

    if (!this.columns.length) {
      throw new Error("Columns are not specified.");
    }

    if (!this.valuesList.length) {
      throw new Error("No values provided for the insert statement.");
    }

    const columnsPart = this.columns.join(", ");
    const valuesPart = this.valuesList
      .map(
        (values) =>
          "(" +
          values
            .map((value) =>
              value === null
                ? "NULL"
                : typeof value === "string"
                ? `'${value}'`
                : value
            )
            .join(", ") +
          ")"
      )
      .join(", ");

    // Reset the builder state after building the query
    const query = `INSERT INTO ${this.tableName} (${columnsPart}) VALUES ${valuesPart};`;
    this.reset();
    return query;
  }
}
