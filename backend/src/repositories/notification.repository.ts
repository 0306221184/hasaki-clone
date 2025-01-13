import { Database } from "../lib/database/database";

export default class NotificationRepository {
  public createNotification = async ({
    user_id,
    message,
    type,
    is_read,
    image_url,
  }) => {
    try {
      const result = await Database.mssql().query(
        `
        INSERT INTO notifications (user_id, message, type, is_read, image_url)
        VALUES (@user_id, @message, @type, @is_read, @image_url);
        SELECT SCOPE_IDENTITY() as id;
        `,
        { user_id, message, type, is_read, image_url }
      );
      return result;
    } catch (error) {
      throw error;
    }
  };

  public getNotifications = async () => {
    try {
      const result = await Database.mssql().query(
        `SELECT * FROM notifications`
      );
      return result;
    } catch (error) {
      throw error;
    }
  };
}
