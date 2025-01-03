import SMTPTransport from "nodemailer/lib/smtp-transport";

export const nodemailerConfig: SMTPTransport | SMTPTransport.Options | string =
  {
    host: "smtp.ethereal.email",
    port: 587,
    auth: {
      user: "kraig.gerlach16@ethereal.email",
      pass: "R8F6JyWVDnfQbpg47U",
    },
  };
