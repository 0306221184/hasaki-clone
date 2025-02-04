import Bcrypt from "../lib/bycrypt";
import { userJwtPayload } from "../types/user.jwtPayload.type";
import { UserAlreadyExistException } from "../utils/auth.exception";
import TokenUtilities from "../utils/token.util";
import AuthRepository from "../repositories/auth.repository";
import RedisClient from "../lib/redis";
import ResendService from "../lib/resend.provider";
import CartRepository from "../repositories/cart.repository";
import { PORT } from "../config/env.config";

export default class AuthService {
  private readonly repository: AuthRepository;
  private readonly cartRepository: CartRepository;

  constructor(repository: AuthRepository = new AuthRepository()) {
    this.repository = repository;
    this.cartRepository = new CartRepository();
  }

  async register(email, password, fullName, birthDate, gender) {
    try {
      const [hashPassword, isExistUser] = await Promise.all([
        Bcrypt.getInstance().hashPassword(password),
        this.repository.checkExistUserByEmail(email),
      ]);
      if (isExistUser) {
        const newUser = await this.repository.createUser({
          email: email,
          password: hashPassword,
          fullName: fullName,
          birthDate: birthDate,
          gender: gender,
        });
        await this.cartRepository.createCart(newUser?.id);
        const payload: userJwtPayload = {
          id: newUser?.id,
          email: email,
          roleId: newUser?.role_id,
        };
        const { accessToken, refreshToken } =
          TokenUtilities.getInstance().getLoginToken(payload);
              console.log(accessToken);
              console.log(refreshToken);
        const loginUser = await this.repository.updateUserById(newUser?.id, {
          accessToken: accessToken,
          refreshToken: refreshToken,
          lastLogin: true,
        });
        return loginUser;
      } else throw new UserAlreadyExistException();
    } catch (error) {
      throw error;
    }
  }
  async logout(id: number): Promise<boolean> {
    try {
      const loggedOut = await this.repository.updateUserById(id, {
        setAccessTokenToNull: true,
        setRefreshTokenToNull: true,
      });
      if (loggedOut) return true;
      return false;
    } catch (error) {
      throw error;
    }
  }
  public requestResetPassword = async (email) => {
    try {
      const user = await this.repository.checkExistUserByEmail(email);
      if (user) {
        throw new Error(`User ${email} does not exist`);
      }
      const otp = Math.floor(1000 + Math.random() * 9000).toString();
      const redisKey = `reset-password:otp:${email}`;
      await RedisClient.getInstance().setEx(redisKey, 600, otp);
      await ResendService.getInstance().sendMail(
        email,
        `Your OTP for password reset is: ${otp}`,
        "Password Reset OTP"
      );
      return true;
    } catch (error) {
      throw error;
    }
  };
  public resetPassword = async (email, otp, newPassword) => {
    try {
      const redisKey = `reset-password:otp:${email}`;
      const [savedOtp, hashedPassword] = await Promise.all([
        RedisClient.getInstance().get(redisKey),
        Bcrypt.getInstance().hashPassword(newPassword, 10),
      ]);

      if (!savedOtp || savedOtp != otp) {
        throw new Error("Invalid or expired OTP.");
      }

      const user = await this.repository.getUserByEmail(email);
      await this.repository.updateUserById(Number(user?.id), {
        password: hashedPassword,
      });
      await RedisClient.getInstance().delete(redisKey);
      return true;
    } catch (error) {
      throw error;
    }
  };
  //verify email service
  public requestVerifyEmail = async (email) => {
    try {
      const user = await this.repository.getUserByEmail(email);
      if (!user) {
        throw new Error(`User ${email} does not exist`);
      }
      if (user && user?.is_email_verified) {
        throw new Error(`User ${email} already verified`);
      }
      const verificationCode = Math.floor(
        1000 + Math.random() * 9000
      ).toString();
      const redisKey = `verify:email:${email}`;
      await RedisClient.getInstance().setEx(redisKey, 600, verificationCode);
      const verificationLink = `http://localhost:${PORT}/api/v1/auth/verify-email?email=${encodeURIComponent(
        email
      )}&code=${verificationCode}`;
      await ResendService.getInstance().sendMail(
        email,
        `Verify your email by clicking the link: ${verificationLink}`,
        "Verify email"
      );
      return true;
    } catch (error) {
      throw error;
    }
  };
  public verifyEmail = async (email, code) => {
    try {
      const redisKey = `verify:email:${email}`;
      const storedCode = await RedisClient.getInstance().get(redisKey);

      if (!storedCode || storedCode != code) {
        throw new Error("Invalid or expired verification code.");
      }
      const user = await this.repository.getUserByEmail(email);
      await this.repository.updateUserById(Number(user?.id), {
        isEmailVerified: true,
      });
      await RedisClient.getInstance().delete(redisKey);
      return true;
    } catch (error) {
      throw error;
    }
  };
  public getAllUsers = async () => {
    try {
      return await this.repository.getAllUsers();
    } catch (error) {
      throw error;
    }
  };
  public getUserById = async (id: number) => {
    try {
      return await this.repository.getUserById(id);
    } catch (error) {
      throw error;
    }
  };
}
