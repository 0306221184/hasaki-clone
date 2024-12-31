import { Database } from "../lib/database/database";
import { Product } from "../types/product.type";
export default class ProductRepository {
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
      const productCreated = await Database.mssql().execProc("CreateProduct", {
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
  public getOneProduct = async (id?: Number) => {
    try {
      const product = await Database.mssql().execProc("FindUniqueProduct", {
        id: id,
      });
      return {
        ...product,
        color_variants: JSON.parse(product.color_variants),
        size_variants: JSON.parse(product.size_variants),
      };
    } catch (error) {
      throw error;
    }
  };
  public getManyProducts = async () => {
    try {
      let products = await Database.mssql().execProc("FindManyProducts");
      if (products && products.length > 0) {
        products = products.map((product) => {
          return {
            ...product,
            color_variants: JSON.parse(product.color_variants),
            size_variants: JSON.parse(product.size_variants),
          };
        });
      }
      if (products && !Array.isArray(products)) {
        return {
          ...products,
          color_variants: JSON.parse(products.color_variants),
          size_variants: JSON.parse(products.size_variants),
        };
      }
      return products;
    } catch (error) {
      throw error;
    }
  };
  public deleteOneProduct = async (id: Number) => {
    try {
      const productDeleted = await Database.mssql().execProc("DeleteProduct", {
        product_id: id,
      });
      return productDeleted;
    } catch (error) {
      throw error;
    }
  };
  //pending
  public deleteManyProducts = async () => {
    try {
      const products = await Database.mssql().execProc("FindUniqueProduct");
      return products;
    } catch (error) {
      throw error;
    }
  };
  //pending
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
      const productUpdated = await Database.mssql().execProc("UpdateProduct", {
        product_id: id,
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
      return productUpdated;
    } catch (error) {
      throw error;
    }
  };
  //pending
  public updateManyProducts = async () => {
    try {
      const products = await Database.mssql().execProc("FindUniqueProduct");
      return products;
    } catch (error) {
      throw error;
    }
  };
  //pending
  public toggleStatusProduct = async (id: Number) => {
    try {
      const product = await Database.mssql().execProc("UpdateProduct", {
        product_id: id,
        toggle_active: true,
      });
      return product;
    } catch (error) {
      throw error;
    }
  };
}
