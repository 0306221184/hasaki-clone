import Redis from "ioredis";

class RedisClient {
  private client: Redis;
  private static instance: RedisClient | null = null;

  private constructor(client: Redis = new Redis()) {
    this.client = client; // Default connection to localhost:6379
  }
  public static getInstance(): RedisClient {
    if (this.instance == null) {
      this.instance = new RedisClient();
    }
    return this.instance;
  }
  public async set(key: string, value: string): Promise<string> {
    try {
      return await this.client.set(key, value);
    } catch (error) {
      throw error;
    }
  }

  public async get(key: string): Promise<string | null> {
    try {
      return await this.client.get(key);
    } catch (error) {
      throw error;
    }
  }

  public async delete(key: string): Promise<number> {
    try {
      return await this.client.del(key);
    } catch (error) {
      throw error;
    }
  }

  public disconnect(): void {
    this.client.disconnect();
  }
}

export default RedisClient;
