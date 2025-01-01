import { Database } from "../lib/database/database";
export default class AuthRepository {
  async checkExistUserByEmail(email: String): Promise<Boolean> {
    try {
      const userCount = await Database.mssql().query(
        "SELECT COUNT(id) as count FROM [Users] WHERE email=@email",
        { email }
      );
      if (userCount.count !== 0) return false;
      return true;
    } catch (error) {
      throw error;
    }
  }

  async getUserByEmail(email: string) {
    try {
      const user = await Database.mssql().execProc("FindUniqueUser", {
        email: email,
      });
      return user;
    } catch (error) {
      throw error;
    }
  }
  async getUserById(id: Number) {
    try {
      const user = await Database.mssql().execProc("FindUniqueUser", {
        id: id,
      });
      return user;
    } catch (error) {
      throw error;
    }
  }
  async getAllUsers() {
    try {
      const users = await Database.mssql().execProc("FindManyUsers");
      return users;
    } catch (error) {
      throw error;
    }
  }
  async updateUserById(
    id: Number,
    {
      username = null,
      password = null,
      accessToken = null,
      refreshToken = null,
      roleName = null,
      avatar = null,
      fullName = null,
      phoneNumber = null,
      address = null,
      provider = null,
      providerId = null,
      lastLogin = false,
      isEmailVerified = false,
      setAccessTokenToNull = false,
      setRefreshTokenToNull = false,
    }: {
      username?: String | null;
      password?: String | null;
      accessToken?: String | null;
      refreshToken?: String | null;
      roleName?: String | null;
      avatar?: String | null;
      fullName?: String | null;
      phoneNumber?: String | null;
      address?: String | null;
      provider?: String | null;
      providerId?: String | null;
      lastLogin?: Boolean;
      isEmailVerified?: Boolean;
      setAccessTokenToNull?: Boolean;
      setRefreshTokenToNull?: Boolean;
    }
  ): Promise<any> {
    try {
      const updatedUser = await Database.mssql().execProc("UpdateUser", {
        user_id: id,
        username: username,
        password: password,
        access_token: accessToken,
        refresh_token: refreshToken,
        role_name: roleName,
        avatar: avatar,
        full_name: fullName,
        phone_number: phoneNumber,
        address: address,
        provider: provider,
        provider_id: providerId,
        last_login: lastLogin,
        is_email_verified: isEmailVerified,
        set_access_token_to_null: setAccessTokenToNull,
        set_refresh_token_to_null: setRefreshTokenToNull,
      });
      return updatedUser;
    } catch (error) {
      throw error;
    }
  }
  async createUser({
    email = null,
    username = null,
    password = null,
    accessToken = null,
    refreshToken = null,
    roleName = "USER",
    avatar = null,
    fullName = null,
    phoneNumber = null,
    address = null,
    provider = null,
    providerId = null,
    lastLogin = false,
    isEmailVerified = false,
  }: {
    email?: String | null;
    username?: String | null;
    password?: String | null;
    accessToken?: String | null;
    refreshToken?: String | null;
    roleName?: String | null;
    avatar?: String | null;
    fullName?: String | null;
    phoneNumber?: String | null;
    address?: String | null;
    provider?: String | null;
    providerId?: String | null;
    lastLogin?: Boolean;
    isEmailVerified?: Boolean;
  }): Promise<any> {
    try {
      const createdUser = await Database.mssql().execProc("CreateUser", {
        email: email,
        username: username,
        password: password,
        access_token: accessToken,
        refresh_token: refreshToken,
        role_name: roleName,
        avatar: avatar,
        full_name: fullName,
        phone_number: phoneNumber,
        address: address,
        provider: provider,
        provider_id: providerId,
        is_email_verified: isEmailVerified,
      });
      return createdUser;
    } catch (error) {
      throw error;
    }
  }
  async toggleStatusUser(id: number) {
    try {
      const user = await Database.mssql().execProc("UpdateUser", {
        user_id: id,
        toggle_disabled: true,
      });
      return user;
    } catch (error) {
      throw error;
    }
  }
}
