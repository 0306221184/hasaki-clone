import nodemailer from "nodemailer";
import SMTPTransport from "nodemailer/lib/smtp-transport";
import { nodemailerConfig } from "../config/nodemailer.config";
export default class NodemailerService {
  private static instance: NodemailerService | null = null;
  private transporter: nodemailer.Transporter<
    SMTPTransport.SentMessageInfo,
    SMTPTransport.Options
  >;
  private constructor() {
    this.transporter = this.createTransport();
  }
  private createTransport = (): nodemailer.Transporter<
    SMTPTransport.SentMessageInfo,
    SMTPTransport.Options
  > => {
    return nodemailer.createTransport(nodemailerConfig);
  };
  public static getInstance(): NodemailerService {
    if (this.instance == null) {
      this.instance = new NodemailerService();
    }
    return this.instance;
  }
  public sendMail = async (email: string, content: string) => {
    try {
      await this.transporter.sendMail({
        from: '"Test Sender" <maddison53@ethereal.email>',
        to: email,
        subject: "Password Reset OTP",
        text: content,
      });
    } catch (error) {
      throw error;
    }
  };
}
