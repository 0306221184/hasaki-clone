class UpdateBuilder {
  private static instance: UpdateBuilder;
  private tableName: string;
  private setColumns: string[] = [];
  private whereConditions: string[] = [];

  private constructor(tableName: string) {
    this.tableName = tableName;
  }

  public static getInstance(tableName: string): UpdateBuilder {
    if (!UpdateBuilder.instance) {
      UpdateBuilder.instance = new UpdateBuilder(tableName);
    }
    return UpdateBuilder.instance;
  }

  set(column: string, value: any): this {
    this.setColumns.push(`${column} = ${this.formatValue(value)}`);
    return this;
  }

  where(condition: string): this {
    this.whereConditions.push(condition);
    return this;
  }

  build(): string {
    const setClause = this.setColumns.join(", ");
    const whereClause =
      this.whereConditions.length > 0
        ? `WHERE ${this.whereConditions.join(" AND ")}`
        : "";
    return `UPDATE ${this.tableName} SET ${setClause} ${whereClause};`;
  }

  private formatValue(value: any): string {
    if (typeof value === "string") {
      return `'${value.replace(/'/g, "''")}'`;
    } else if (typeof value === "number" || value === null) {
      return value.toString();
    } else {
      throw new Error("Unsupported value type");
    }
  }
}

// Usage example:
const builder = UpdateBuilder.getInstance("users")
  .set("name", "John Doe")
  .set("email", "john.doe@example.com")
  .where("id = 1");

const updateSql = builder.build();
console.log(updateSql); // Output: UPDATE users SET name = 'John Doe', email = 'john.doe@example.com' WHERE id = 1;
