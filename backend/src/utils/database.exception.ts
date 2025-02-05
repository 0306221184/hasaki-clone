class DatabaseProviderNotSupportedException extends Error {
  public status: Number;
  public message: string;

  constructor(
    message: string = "Database provider not supported!!",
    status: Number = 500
  ) {
    super(message);
    this.message = message;
    this.status = status;
  }
}
export { DatabaseProviderNotSupportedException };
