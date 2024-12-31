import Bcrypt from "../lib/bycrypt";
import { userJwtPayload } from "../types/user.jwtPayload.type";
import { UserAlreadyExistException } from "../utils/auth.exception";
import TokenUtilities from "../utils/token.util";
import AuthRepository from "../repositories/auth.repository";

export default class AuthService {
  private readonly repository: AuthRepository;
  constructor(repository: AuthRepository = new AuthRepository()) {
    this.repository = repository;
  }
  async register(email, password) {
    try {
      const hashPassword = await Bcrypt.getInstance().hashPassword(password);
      const isExistUser = await this.repository.checkExistUserByEmail(email);

      if (isExistUser) {
        const newUser = await this.repository.createUser({
          email: email,
          password: hashPassword,
        });
        const payload: userJwtPayload = {
          id: newUser?.id,
          email: email,
          roleId: newUser?.role_id,
        };

        const { accessToken, refreshToken } =
          TokenUtilities.getInstance().getLoginToken(payload);
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
  async logout(id: number): Promise<Boolean> {
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
}
