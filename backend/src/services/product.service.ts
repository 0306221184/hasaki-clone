import ProductRepository from "../repositories/product.repository";

export default class ProductService {
  private readonly repository: ProductRepository;
  constructor() {
    this.repository = new ProductRepository();
  }
  public createProduct = async ({
    name,
    description,
    price,
    discount_price,
    quantity_in_stock,
    category_name,
    rating,
    image_url,
    variants,
    tags,
    sub_images_url,
  }: {
    name: string;
    description?: string;
    price: number;
    discount_price?: number;
    quantity_in_stock?: number;
    category_name: string;
    rating?: number;
    image_url?: string;
    variants?: string;
    tags?: string;
    sub_images_url?: string[];
  }) => {
    try {
      const productCreated = await this.repository.createProduct({
        name,
        description,
        price,
        discount_price,
        quantity_in_stock,
        category_name,
        rating,
        image_url,
        variants,
        tags,
        sub_images_url,
      });
      return productCreated;
    } catch (error) {
      throw error;
    }
  };
  public getManyProducts = async () => {
    try {
      const products = await this.repository.getManyProducts();
      return products;
    } catch (error) {
      throw error;
    }
  };
  public getOneProduct = async (id?: number) => {
    try {
      const product = await this.repository.getOneProduct(id);
      return product;
    } catch (error) {
      throw error;
    }
  };
  public searchProducts = async ({ name, minPrice, maxPrice }) => {
    try {
      const searchProducts = await this.repository.searchProducts({
        name,
        minPrice,
        maxPrice,
      });
      return searchProducts;
    } catch (error) {
      throw error;
    }
  };
  public deleteOneProduct = async (id: number) => {
    try {
      const product = await this.repository.deleteOneProduct(id);
      return product;
    } catch (error) {
      throw error;
    }
  };
  public deleteManyProducts = async () => {
    try {
      const products = await this.repository.deleteManyProducts();
      return products;
    } catch (error) {
      throw error;
    }
  };
  public updateOneProduct = async (
    id: number,
    {
      name,
      description,
      price,
      discount_price,
      quantity_in_stock,
      category_name,
      rating,
      image_url,
      variants,
      tags,
    }: {
      name?: string;
      description?: string;
      price?: string;
      discount_price?: number;
      quantity_in_stock?: number;
      category_name?: string;
      rating?: number;
      image_url?: string;
      variants?: string;
      tags?: string;
    }
  ) => {
    try {
      const product = await this.repository.updateOneProduct(id, {
        name,
        description,
        price,
        discount_price,
        quantity_in_stock,
        category_name,
        rating,
        image_url,
        variants,
        tags,
      });
      return product;
    } catch (error) {
      throw error;
    }
  };
  public updateManyProducts = async () => {
    try {
      const products = await this.repository.updateManyProducts();
      return products;
    } catch (error) {
      throw error;
    }
  };
  public toggleStatusProduct = async (id: number) => {
    try {
      const product = await this.repository.toggleStatusProduct(id);
      return product;
    } catch (error) {
      throw error;
    }
  };
  public getProductByCategory = async (categoryId: number) => {
    try {
      const products = await this.repository.getProductByCategory(categoryId);
      return products;
    } catch (error) {
      throw error;
    }
  };
}
