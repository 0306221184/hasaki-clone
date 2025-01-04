import Redis from "ioredis";

class RedisClient {
  private client: Redis;
  private static instance: RedisClient | null = null;

  private constructor(client: Redis = new Redis()) {
    this.client = client; // Default connection to localhost:6379
    // Add error handling for connection issues
    this.client.on("error", (err) => {
      console.error("Redis connection error:", err);
    });

    this.client.on("connect", () => {
      console.log("Connected to Redis successfully.");
    });

    this.client.on("ready", () => {
      console.log("Redis is ready to accept commands.");
    });
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
  public async setEx(
    key: string,
    ex: string | number,
    value: string
  ): Promise<string> {
    try {
      return await this.client.setex(key, ex, value);
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
  async publish(channel: string, message: string): Promise<void> {
    try {
      await this.client.publish(channel, message);
    } catch (error) {
      throw error;
    }
  }

  async subscribe(
    channel: string,
    callback: (message: string) => void
  ): Promise<void> {
    try {
      // Subscribe to the channel
      await this.client.subscribe(channel);

      // Listen for messages
      this.client.on("message", (receivedChannel, message) => {
        if (receivedChannel === channel) {
          callback(message); // Pass the message to the callback
        }
      });
    } catch (error) {
      throw error;
    }
  }

  public disconnect(): void {
    this.client.disconnect();
  }
}

export default RedisClient;
