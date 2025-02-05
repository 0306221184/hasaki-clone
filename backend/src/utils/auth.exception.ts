import StatusCode from "http-status-codes";
class AlreadyLogoutAuthException extends Error {
  public status: Number;
  public message: string;

  constructor(
    message: string = "You already logged out!!",
    status: Number = 401
  ) {
    super(message);
    this.message = message;
    this.status = status;
  }
}
class IncorrectEmailException extends Error {
  public status: Number;
  public message: string;

  constructor(message: string = "Incorrect email!!", status: Number = 401) {
    super(message);
    this.message = message;
    this.status = status;
  }
}
class IncorrectPasswordException extends Error {
  public status: Number;
  public message: string;

  constructor(message: string = "Incorrect password!!", status: Number = 401) {
    super(message);
    this.message = message;
    this.status = status;
  }
}
class NotLoggedInException extends Error {
  public status: Number;
  public message: string;

  constructor(
    message: string = "You must be logged in!!",
    status: Number = 401
  ) {
    super(message);
    this.message = message;
    this.status = status;
  }
}
class UserAlreadyExistException extends Error {
  public status: Number;
  public message: string;

  constructor(message: string = "User already exist!!", status: Number = 401) {
    super(message);
    this.message = message;
    this.status = status;
  }
}
class AuthorizationException extends Error {
  public status: number;
  public message: string;

  constructor(
    message: string = "Forbidden: Permission denied!!",
    status: number = 403
  ) {
    super(message);
    this.message = message;
    this.status = status;
  }
}

export {
  AlreadyLogoutAuthException,
  IncorrectEmailException,
  IncorrectPasswordException,
  NotLoggedInException,
  UserAlreadyExistException,
  AuthorizationException,
};
