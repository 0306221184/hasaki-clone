import CartRepository from "../repositories/cart.repository";

export default class CartService {
  private readonly repository: CartRepository;

  constructor(repository: CartRepository = new CartRepository()) {
    this.repository = repository;
  }

  public createCartItem = async ({ cart_id, product_id, quantity, price }) => {
    try {
      const cartItem = await this.repository.createCartItem({
        cart_id,
        product_id,
        quantity,
        price,
      });
      return cartItem;
    } catch (error) {
      throw error;
    }
  };

  public getCartItems = async () => {
    try {
      const cartItems = await this.repository.getCartItems();
      return cartItems;
    } catch (error) {
      throw error;
    }
  };

  public getCartItem = async (id: number) => {
    try {
      const cartItem = await this.repository.getCartItem(id);
      return cartItem;
    } catch (error) {
      throw error;
    }
  };

  public updateCartItem = async (
    id: number,
    { quantity, price, product_id }
  ) => {
    try {
      const cartItem = await this.repository.updateCartItem(id, {
        quantity,
        price,
        product_id,
      });
      return cartItem;
    } catch (error) {
      throw error;
    }
  };

  public deleteCartItem = async (id: number) => {
    try {
      await this.repository.deleteCartItem(id);
    } catch (error) {
      throw error;
    }
  };
}
