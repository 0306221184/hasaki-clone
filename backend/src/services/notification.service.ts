import NotificationRepository from "../repositories/notification.repository";

export default class NotificationService {
  private readonly repository: NotificationRepository;

  constructor(
    repository: NotificationRepository = new NotificationRepository()
  ) {
    this.repository = repository;
  }

  public createNotification = async ({
    user_id,
    message,
    type,
    is_read,
    image_url,
  }) => {
    try {
      const notification = await this.repository.createNotification({
        user_id,
        message,
        type,
        is_read,
        image_url,
      });
      return notification;
    } catch (error) {
      throw error;
    }
  };

  public getNotifications = async () => {
    try {
      const notifications = await this.repository.getNotifications();
      return notifications;
    } catch (error) {
      throw error;
    }
  };
}
