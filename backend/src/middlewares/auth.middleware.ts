import { Request, Response, NextFunction } from "express";
import jwt from "jsonwebtoken";
import {
  JWT_ACCESS_TOKEN_SECRET_KEY,
  JWT_REFRESH_TOKEN_SECRET_KEY,
} from "../config/env.config";
import { Database } from "../lib/database/database";
import {
  AlreadyLogoutAuthException,
  AuthorizationException,
} from "../utils/auth.exception";
import { TokenNotFoundException } from "../utils/token.exception";
import TokenUtilities from "../utils/token.util";

export default class AuthMiddleware {
  private static instance: AuthMiddleware | null = null;
  private constructor() {}

  public static getInstance(): AuthMiddleware {
    if (this.instance == null) {
      this.instance = new AuthMiddleware();
    }
    return this.instance;
  }
  public async authentication(req: Request, res: Response, next: NextFunction) {
    try {
      const token = req?.headers?.authorization?.split(" ")[1];
      const refreshTokenInCookie = req?.cookies?.refreshToken;

      if (!refreshTokenInCookie) {
        return next(
          new AlreadyLogoutAuthException("Refresh token not found in cookie!!")
        );
      }

      if (token) {
        // Verify Access Token
        jwt.verify(
          token,
          JWT_ACCESS_TOKEN_SECRET_KEY as string,
          async (err, user: any) => {
            if (err) {
              // If access token is invalid/expired, verify refresh token
              jwt.verify(
                refreshTokenInCookie,
                JWT_REFRESH_TOKEN_SECRET_KEY as string,
                async (rErr, rUser: any) => {
                  if (rErr) {
                    return next(
                      new AlreadyLogoutAuthException("Invalid refresh token.")
                    );
                  }
                  // Generate new tokens
                  const { iat, exp, ...payload } = rUser;
                  const { accessToken, refreshToken } =
                    TokenUtilities.getInstance().getLoginToken(payload);

                  // Update tokens in the database
                  await Database.mssql().execProc("UpdateUser", {
                    user_id: rUser?.id,
                    access_token: accessToken,
                    refresh_token: refreshToken,
                  });

                  // Attach new tokens to user object
                  rUser.refresh_token = refreshToken;
                  req.user = rUser;

                  // Proceed to next middleware
                  return next();
                }
              );
            } else {
              // Access token is valid, check refresh token in the database
              const dbResult = await Database.mssql().query(
                "SELECT refresh_token FROM [users] WHERE id=@userId",
                { userId: user?.id }
              );

              if (
                !dbResult?.refresh_token ||
                dbResult.refresh_token !== refreshTokenInCookie
              ) {
                return next(new AlreadyLogoutAuthException());
              }

              user.refresh_token = dbResult.refresh_token;
              req.user = user;

              // Proceed to next middleware
              return next();
            }
          }
        );
      } else {
        // No access token provided
        return next(new TokenNotFoundException());
      }
    } catch (error) {
      return next(error);
    }
  }
  public hasPermissions(
    permissions: String[],
    ownershipCheck?: (req: Request) => boolean
  ) {
    return async (req, res, next) => {
      try {
        // Fetch the user's permissions from the database
        const userPermissions = await Database.mssql().execProc(
          "FindManyPermissionsByRoleId",
          {
            role_id: req?.user?.roleId,
          }
        );

        let arrayPermissions: String[] = [];
        if (Array.isArray(userPermissions)) {
          arrayPermissions = userPermissions.map((per) => per.name);
        } else {
          arrayPermissions.push(userPermissions.name);
        }

        // Check if the user has all required permissions
        const hasAllPermissions = permissions.every((permission) =>
          arrayPermissions.includes(permission)
        );

        // Perform ownership check if required
        if (ownershipCheck && !ownershipCheck(req)) {
          return next(
            new AuthorizationException("Ownership check failed", 403)
          );
        }

        // Deny access if the required permissions are not met
        if (!hasAllPermissions) {
          return next(new AuthorizationException());
        }

        return next();
      } catch (error) {
        return next(error);
      }
    };
  }
}
