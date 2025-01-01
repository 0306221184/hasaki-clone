import { Resend } from "resend";
import { RESEND_API_KEY } from "../config/env.config";
export default class ResendService {
  private static instance: ResendService | null = null;
  private resend: Resend;
  private constructor() {
    this.resend = new Resend(RESEND_API_KEY);
  }
  public static getInstance(): ResendService {
    if (this.instance == null) {
      this.instance = new ResendService();
    }
    return this.instance;
  }
  public sendMail = async (email: string, content: string, subject: string) => {
    try {
      const { data, error } = await this.resend.emails.send({
        from: "Acme <onboarding@resend.dev>",
        to: email,
        subject: subject,
        html: `<h1>${content}</h1>`,
      });
      if (error) {
        throw error;
      }
      return data;
    } catch (error) {
      throw error;
    }
  };
}
