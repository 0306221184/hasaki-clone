import { NextFunction, Request, Response } from "express";
import AuthService from "../services/auth.service";
import StatusCode from "http-status-codes";
import { NotLoggedInException } from "../utils/auth.exception";
import { FRONTEND_URL } from "../config/env.config";
import TokenUtilities from "../utils/token.util";
import { User } from "../types/user.type";

export default class AuthController {
  private readonly authServices: AuthService;

  constructor(authService: AuthService = new AuthService()) {
    this.authServices = authService;
  }
  public register = async (req: Request, res: Response, next: NextFunction) => {
    try {
      const { email, password, fullName, birthDate, gender } = req.body;
      const registerUser = await this.authServices.register(
        email,
        password,
        fullName,
        birthDate,
        gender
      );
      TokenUtilities.getInstance().sendRefreshTokenToCookie(
        res,
        registerUser?.refresh_token
      );
      const { refresh_token, ...rest } = registerUser;
      res.status(StatusCode.OK).json({
        status: "OK",
        message: "Register successfully!",
        data: rest,
      });
    } catch (error) {
      next(error);
    }
  };
  public login = async (req, res: Response, next: NextFunction) => {
    try {
      TokenUtilities.getInstance().sendRefreshTokenToCookie(
        res,
        req.user?.refresh_token
      );
      const { refresh_token, ...rest } = req.user as User;
      res.status(StatusCode.OK).json({
        status: "OK",
        message: "Login successfully!",
        data: rest,
      });
    } catch (error) {
      next(error);
    }
  };
  public firebaseLogin = async (
    req: Request,
    res: Response,
    next: NextFunction
  ) => {
    try {
      res.status(StatusCode.OK).json({
        status: "OK",
        message: "Login by firebase successfully!",
      });
    } catch (error) {
      next(error);
    }
  };
//   public googleLogin = async (
//     req: Request,
//     res: Response,
//     next: NextFunction
//   ) => {
//     try {
//       TokenUtilities.getInstance().sendRefreshTokenToCookie(
//         res,
//         req?.user?.refresh_token
//       );
//       res.redirect(`${FRONTEND_URL}?userId=${req?.user?.id}`);
//     } catch (error) {
//       next(error);
//     }
//   };
  public logout = async (req, res: Response, next: NextFunction) => {
    try {
      if (!req.user) {
        throw new NotLoggedInException();
      }
      const isLogout = await this.authServices.logout(req?.user?.id);
      if (isLogout) {
        res.clearCookie("refreshToken", {
          httpOnly: true,
          secure: false,
          sameSite: "strict",
        });
        res.status(StatusCode.OK).json({
          status: "OK",
          message: "Logout successfully!",
        });
      }
    } catch (error) {
      next(error);
    }
  };
  public requestResetPassword = async (
    req: Request,
    res: Response,
    next: NextFunction
  ) => {
    try {
      const { email } = req.body;
      const resetPasswordResult = await this.authServices.requestResetPassword(
        email
      );
      if (resetPasswordResult) {
        res.status(StatusCode.OK).json({
          status: "OK",
          message: "OTP sent to your email.",
        });
      }
    } catch (error) {
      next(error);
    }
  };
  public resetPassword = async (
    req: Request,
    res: Response,
    next: NextFunction
  ) => {
    try {
      const { email, otp, newPassword } = req.body;
      const resetPasswordResult = await this.authServices.resetPassword(
        email,
        otp,
        newPassword
      );
      if (resetPasswordResult) {
        res.status(StatusCode.OK).json({
          status: "OK",
          message: "Password reset successful",
        });
      }
    } catch (error) {
      next(error);
    }
  };
  //verify email
  public requestVerifyEmail = async (
    req: Request,
    res: Response,
    next: NextFunction
  ) => {
    try {
      const { email } = req.body;
      const verifyEmailResult = await this.authServices.requestVerifyEmail(
        email
      );
      if (verifyEmailResult) {
        res.status(StatusCode.OK).json({
          status: "OK",
          message: "Verify send to your email.",
        });
      }
    } catch (error) {
      next(error);
    }
  };
  public verifyEmail = async (
    req: Request,
    res: Response,
    next: NextFunction
  ) => {
    try {
      const { email, code } = req.query;
      const verifyEmailResult = await this.authServices.verifyEmail(
        email,
        code
      );
      if (verifyEmailResult) {
        res.status(StatusCode.OK).send(`<h1>Email verify successfully!!</h1>`);
      }
    } catch (error) {
      next(error);
    }
  };
  public getAllUsers = async (
    req: Request,
    res: Response,
    next: NextFunction
  ) => {
    try {
      const users = await this.authServices.getAllUsers();
      res.status(StatusCode.OK).json({
        status: "OK",
        data: users,
      });
    } catch (error) {
      next(error);
    }
  };
  public getUserById = async (
    req: Request,
    res: Response,
    next: NextFunction
  ) => {
    try {
      const userId = parseInt(req.params.id);
      const user = await this.authServices.getUserById(userId);
      res.status(StatusCode.OK).json({
        status: "OK",
        data: user,
      });
    } catch (error) {
      next(error);
    }
  };
}
