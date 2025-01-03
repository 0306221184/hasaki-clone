import { Strategy as LocalStrategy } from "passport-local";
import { Strategy as GoogleStrategy } from "passport-google-oauth20";
import { Database } from "../lib/database/database";
import Bcrypt from "../lib/bycrypt";
import passport from "passport";
import TokenUtilities from "../utils/token.util";
import { GOOGLE_CLIENT_ID, GOOGLE_CLIENT_SECRET, PORT } from "./env.config";
import {
  IncorrectEmailException,
  IncorrectPasswordException,
} from "../utils/auth.exception";
passport.use(
  new LocalStrategy(
    { usernameField: "email", passwordField: "password" },
    async function (email, password, done) {
      try {
        const user = await Database.mssql().query(
          "SELECT * FROM [Users] WHERE email=@email AND provider IS NULL",
          { email }
        );
        if (!user) {
          return done(new IncorrectEmailException());
        }

        const isMatch = await Bcrypt.getInstance().verifyPassword(
          password,
          user.password
        );

        if (!isMatch) {
          return done(new IncorrectPasswordException());
        }
        const { accessToken, refreshToken } =
          TokenUtilities.getInstance().getLoginToken({
            id: user.id,
            roleId: user.role_id,
            email: user.email,
          });
        const updatedUser = await Database.mssql().execProc("[UpdateUser]", {
          user_id: user.id,
          access_token: accessToken,
          refresh_token: refreshToken,
          last_login: true,
        });
        return done(null, updatedUser);
      } catch (err) {
        done(err);
      }
    }
  )
);
passport.use(
  new GoogleStrategy(
    {
      clientID: GOOGLE_CLIENT_ID as string,
      clientSecret: GOOGLE_CLIENT_SECRET as string,
      callbackURL: `http://localhost:${PORT}/api/v1/auth/google/login/callback`,
    },
    async function (accessToken, refreshToken, profile, cb) {
      try {
        const checkUser = await Database.mssql().query(
          "SELECT * FROM [Users] WHERE email=@email AND provider_id IS NOT NULL",
          { email: profile?.emails?.[0]?.value }
        );
        if (!checkUser) {
          const user = await Database.mssql().execProc("CreateUser", {
            username: profile.displayName,
            email: profile?.emails?.[0]?.value,
            avatar: profile?.photos?.[0]?.value,
            provider: profile.provider,
            provider_id: profile.id,
            is_email_verified: profile?.emails?.[0]?.verified,
          });
          const { accessToken, refreshToken } =
            TokenUtilities.getInstance().getLoginToken({
              id: user.id,
              roleId: user.role_id,
              email: user.email,
            });
          const loginUser = await Database.mssql().execProc("UpdateUser", {
            user_id: user.id,
            access_token: accessToken,
            refresh_token: refreshToken,
            last_login: true,
          });
          return cb(null, loginUser);
        } else {
          const { accessToken, refreshToken } =
            TokenUtilities.getInstance().getLoginToken({
              id: checkUser.id,
              roleId: checkUser.role_id,
              email: checkUser.email,
            });
          const loginUser = await Database.mssql().execProc("UpdateUser", {
            user_id: checkUser.id,
            username: profile.displayName,
            avatar: profile?.photos?.[0]?.value,
            provider: profile.provider,
            provider_id: profile.id,
            is_email_verified: profile?.emails?.[0]?.verified,
            access_token: accessToken,
            refresh_token: refreshToken,
          });

          return cb(null, loginUser);
        }
      } catch (error) {
        cb(error);
      }
    }
  )
);
export default passport;
