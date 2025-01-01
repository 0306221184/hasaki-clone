import jwt from "jsonwebtoken";
import {
  JWT_ACCESS_TOKEN_EXPIRATION_TIME,
  JWT_ACCESS_TOKEN_SECRET_KEY,
  JWT_REFRESH_TOKEN_EXPIRATION_TIME,
  JWT_REFRESH_TOKEN_SECRET_KEY,
} from "../config/env.config";
import { userJwtPayload } from "../types/user.jwtPayload.type";
export default class TokenUtilities {
  private static instance: TokenUtilities | null = null;
  private constructor() {}
  public static getInstance(): TokenUtilities {
    if (this.instance == null) {
      this.instance = new TokenUtilities();
    }
    return this.instance;
  }
  private generateAccessToken(payload: userJwtPayload): string {
    const secret: string = JWT_ACCESS_TOKEN_SECRET_KEY as string;
    const token = jwt.sign(payload, secret, {
      expiresIn: (JWT_ACCESS_TOKEN_EXPIRATION_TIME as string) || "10s",
    });
    return token;
  }
  private generateRefreshToken(payload: userJwtPayload): string {
    const secret: string = JWT_REFRESH_TOKEN_SECRET_KEY as string;
    const token = jwt.sign(payload, secret, {
      expiresIn: (JWT_REFRESH_TOKEN_EXPIRATION_TIME as string) || "1d",
    });
    return token;
  }
  public getLoginToken(payload: userJwtPayload): {
    accessToken: string;
    refreshToken: string;
  } {
    const accessToken = this.generateAccessToken(payload);
    const refreshToken = this.generateRefreshToken(payload);
    return { accessToken, refreshToken };
  }
  public sendRefreshTokenToCookie(res, refreshToken): void {
    res.cookie("refreshToken", refreshToken, {
      httpOnly: true,
      secure: false, // Use true in production (HTTPS only)
      sameSite: "strict",
    });
  }
}
