import ProductRepository from "../repositories/product.repository";
import { Product } from "../types/product.type";

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
    color_variants,
    size_variants,
    tags,
  }: {
    name: string;
    description?: string;
    price: number;
    discount_price?: number;
    quantity_in_stock?: number;
    category_name: string;
    rating?: number;
    image_url?: string;
    color_variants?: string;
    size_variants?: string;
    tags?: string;
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
        color_variants,
        size_variants,
        tags,
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
  public getOneProduct = async (id?: Number) => {
    try {
      const product = await this.repository.getOneProduct(id);
      return product;
    } catch (error) {
      throw error;
    }
  };
  public deleteOneProduct = async (id: Number) => {
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
    id: Number,
    {
      name,
      description,
      price,
      discount_price,
      quantity_in_stock,
      category_name,
      rating,
      image_url,
      color_variants,
      size_variants,
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
      color_variants?: string;
      size_variants?: string;
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
        color_variants,
        size_variants,
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
  public toggleStatusProduct = async (id: Number) => {
    try {
      const product = await this.repository.toggleStatusProduct(id);
      return product;
    } catch (error) {
      throw error;
    }
  };
}
