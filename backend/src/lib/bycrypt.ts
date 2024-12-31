import bcrypt from "bcrypt";

class Bcrypt {
  private static instance: Bcrypt | null = null;

  private constructor() {}
  public static getInstance(): Bcrypt {
    if (this.instance == null) {
      this.instance = new Bcrypt();
    }
    return this.instance;
  }

  // Method to hash a password
  public async hashPassword(
    password: string,
    saltNum: number = 10
  ): Promise<string> {
    try {
      const salt = await bcrypt.genSalt(saltNum);
      return await bcrypt.hash(password, salt);
    } catch (err) {
      throw err;
    }
  }

  // Method to verify a password
  public async verifyPassword(
    password: string,
    hash: string
  ): Promise<boolean> {
    try {
      return await bcrypt.compare(password, hash);
    } catch (err) {
      throw err;
    }
  }
}
export default Bcrypt;
