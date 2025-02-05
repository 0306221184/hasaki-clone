class DeleteBuilder {
  //+
  private tableName: string; //+
  private conditions: string[] = []; //+
  //+
  constructor(tableName: string) {
    //+
    this.tableName = tableName; //+
  } //+
  //+
  where(condition: string): this {
    //+
    this.conditions.push(condition); //+
    return this; //+
  } //+
  //+
  build(): string {
    //+
    let sql = `DELETE FROM ${this.tableName}`; //+
    //+
    if (this.conditions.length > 0) {
      //+
      sql += ` WHERE ${this.conditions.join(" AND ")}`; //+
    } //+
    //+
    return sql; //+
  } //+
} //+
//+
// Usage example://+
// const deleteBuilder = new DeleteBuilder("users"); //+
// deleteBuilder.where("id = 1"); //+
// const deleteQuery = deleteBuilder.build(); //+
// console.log(deleteQuery); // Output: DELETE FROM users WHERE id = 1//+
