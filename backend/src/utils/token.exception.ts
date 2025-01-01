class TokenNotFoundException extends Error {
  public status: Number;
  public message: string;

  constructor(message: string = "Token not found!!", status: Number = 401) {
    super(message);
    this.message = message;
    this.status = status;
  }
}
class MissingJwtSecretException extends Error {
  public status: Number;
  public message: string;

  constructor(message: string = "Missing jwt secret!!", status: Number = 401) {
    super(message);
    this.message = message;
    this.status = status;
  }
}
export { MissingJwtSecretException, TokenNotFoundException };
