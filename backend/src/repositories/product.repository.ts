import { Database } from "../lib/database/database";
import { Product } from "../types/product.type";
import InsertBuilder from "../helper/builder/sql_builder/insert_builder.helper";
import SelectBuilder from "../helper/builder/sql_builder/select_builder.helper";
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
      const productCreated = await Database.mssql().execProc("CreateProduct", {
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
      if (productCreated && sub_images_url) {
        const valuesInsert = sub_images_url?.map((url) => {
          return [productCreated?.id, url];
        });

        const insertToProductSubImagesSql = InsertBuilder.getInstance()
          .into("product_images")
          .column(["product_id", "image_url"])
          .values(valuesInsert)
          .buildSqlServerInsert();
        const addSubImagesToProduct = await Database.mssql().query(
          insertToProductSubImagesSql
        );
        const selectSubImagesProductSql = SelectBuilder.getInstance()
          .select(["image_url"])
          .from("product_images")
          .where(`product_id=${productCreated?.id}`)
          .buildSqlServerQuery();

        const subProductImages = await Database.mssql().query(
          selectSubImagesProductSql
        );
        const result = {
          ...productCreated,
          sub_images_products: subProductImages.map((item) => item?.image_url),
        };
        return result;
      }
      return null;
    } catch (error) {
      throw error;
    }
  };
  public getOneProduct = async (id?: Number) => {
    try {
      const product = await Database.mssql().execProc("FindUniqueProduct", {
        id: id,
      });
      const selectSubImagesProductSql = SelectBuilder.getInstance()
        .select(["image_url"])
        .from("product_images")
        .where(`product_id=${product?.id}`)
        .buildSqlServerQuery();

      const subProductImages = await Database.mssql().query(
        selectSubImagesProductSql
      );
      return {
        ...product,
        variants: JSON.parse(product.variants),
        sub_images_products: subProductImages.map((item) => item?.image_url),
      };
    } catch (error) {
      throw error;
    }
  };
  public getManyProducts = async () => {
    try {
      let products = await Database.mssql().execProc("FindManyProducts", {});

      if (products && products.length > 0) {
        products = products.map((product) => {
          return {
            ...product,
            variants: JSON.parse(product.variants),
          };
        });
      }
      if (products && !Array.isArray(products)) {
        return {
          ...products,
          variants: JSON.parse(products.variants),
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
        variants,
        tags,
      });
      const selectSubImagesProductSql = SelectBuilder.getInstance()
        .select(["image_url"])
        .from("product_images")
        .where(`product_id=${productUpdated?.id}`)
        .buildSqlServerQuery();

      const subProductImages = await Database.mssql().query(
        selectSubImagesProductSql
      );
      return {
        ...productUpdated,
        variants: JSON.parse(productUpdated.variants),
        sub_images_products: subProductImages.map((item) => item?.image_url),
      };
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
