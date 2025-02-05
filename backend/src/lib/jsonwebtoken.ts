import jwt, { JwtPayload, SignOptions } from "jsonwebtoken";
import { MissingJwtSecretException } from "../utils/token.exception";

class JwtService {
  private secretKey: string;
  private defaultExpiration: string;

  constructor(secretKey: string, defaultExpiration: string = "1h") {
    if (!secretKey) {
      throw new MissingJwtSecretException();
    }
    this.secretKey = secretKey;
    this.defaultExpiration = defaultExpiration;
  }

  // Generate a new token
  sign(payload: object, expiresIn?: string): string {
    const options: SignOptions = {
      expiresIn: expiresIn || this.defaultExpiration,
    };
    return jwt.sign(payload, this.secretKey, options);
  }

  // Verify an existing token
  verify(token: string): JwtPayload | string {
    try {
      return jwt.verify(token, this.secretKey);
    } catch (error) {
      throw error;
    }
  }

  // Decode a token without verifying
  decode(token: string): JwtPayload | null {
    return jwt.decode(token) as JwtPayload | null;
  }
}

export default JwtService;
