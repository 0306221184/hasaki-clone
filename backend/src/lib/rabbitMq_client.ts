import amqp, { Connection, Channel } from "amqplib";
import { RABBIT_MQ_URL } from "../config/rabbitMQ.config";

export default class RabbitMQClient {
  private static instance: RabbitMQClient;
  private connection: Connection | null = null;
  private channel: Channel | null = null;

  private constructor() {}

  public static getInstance(): RabbitMQClient {
    if (!RabbitMQClient.instance) {
      RabbitMQClient.instance = new RabbitMQClient();
    }
    return RabbitMQClient.instance;
  }

  public async connect(url: string = RABBIT_MQ_URL): Promise<void> {
    if (!this.connection) {
      this.connection = await amqp.connect(url);
      this.channel = await this.connection.createChannel();
      console.log("Connected to RabbitMQ");
    }
  }

  public getChannel(): Channel {
    if (!this.channel) {
      throw new Error("Channel is not initialized. Call connect() first.");
    }
    return this.channel;
  }
  public async sendToQueue(queue: string, message: string): Promise<void> {
    const channel = this.getChannel();
    await channel.assertQueue(queue, { durable: true, exclusive: true });
    channel.sendToQueue(queue, Buffer.from(message), {
      expiration: "100",
      persistent: true,
    });
    console.log(`Message sent to queue "${queue}": ${message}`);
  }
  public async publishToExchange(
    exchange: string,
    routingKey: string,
    message: string
  ) {
    if (!this.channel) throw new Error("Channel not connected");

    // Assert that the exchange exists and is of type 'direct'
    await this.channel.assertExchange(exchange, "direct", { durable: true });

    // Publish the message to the exchange with the routing key
    this.channel.publish(exchange, routingKey, Buffer.from(message));
    console.log(
      `Message published to exchange: ${exchange}, routingKey: ${routingKey}`
    );
  }
  public async consumeQueue(
    queue: string,
    onMessage: (message: string) => void
  ): Promise<void> {
    try {
      const channel = this.getChannel();
      await channel.assertQueue(queue, {
        durable: true,
        exclusive: true,
        expires: 100,
      });

      channel.consume(
        queue,
        (msg) => {
          if (msg) {
            const message = msg.content.toString();
            onMessage(message);
            channel.ack(msg);
          }
        },
        { exclusive: true }
      );
    } catch (error) {
      throw error;
    }
  }
  public async close(): Promise<void> {
    await this.channel?.close();
    await this.connection?.close();
    this.connection = null;
    this.channel = null;
    console.log("RabbitMQ connection closed");
  }
}
