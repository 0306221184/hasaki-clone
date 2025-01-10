import PaymentRepository from "../repositories/payment.repository";
export default class PaymentService {
  private readonly repository: PaymentRepository;
  constructor(repository: PaymentRepository = new PaymentRepository()) {
    this.repository = repository;
  }
  public createOrder = async (
    user_id: number,
    currency: string = "usd",
    note: string = ""
  ) => {
    try {
      const result = await this.repository.createOrder(user_id, currency, note);
      return result;
    } catch (error) {
      throw error;
    }
  };
  public processPayment = async (order_id: number, payment_method: string) => {
    try {
      const result = await this.repository.processPayment(
        order_id,
        payment_method
      );
      return result;
    } catch (error) {
      throw error;
    }
  };
  public paymentSuccess = async (session_id: string | undefined) => {
    const result = await this.repository.paymentSuccess(session_id);
    return result;
  };
  public paymentCancel = async (session_id: string | undefined) => {
    const result = await this.repository.paymentCancel(session_id);
    return result;
  };
  public cancelOrder = async (order_id: number) => {
    try {
      const result = await this.repository.cancelOrder(order_id);
      return result;
    } catch (error) {
      throw error;
    }
  };
}
