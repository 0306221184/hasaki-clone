import { Database } from "../lib/database/database";
import InsertBuilder from "../helper/builder/sql_builder/insert_builder.helper";
import SelectBuilder from "../helper/builder/sql_builder/select_builder.helper";

export default class ProductRepository {
  private getSubImagesProduct = async (productId: number) => {
    const selectSubImagesProductSql = SelectBuilder.getInstance()
      .select(["image_url"])
      .from("product_images")
      .where(`product_id=${productId}`)
      .buildSqlServerQuery();

    const subProductImages = await Database.mssql().query(
      selectSubImagesProductSql
    );
    return subProductImages.map((item) => item?.image_url);
  };

  private parseProductVariants = (product: any) => {
    return {
      ...product,
      variants: JSON.parse(product.variants),
    };
  };

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

        await Database.mssql().query(insertToProductSubImagesSql);

        const subImagesProducts = await this.getSubImagesProduct(
          productCreated.id
        );

        return {
          ...productCreated,
          sub_images_products: subImagesProducts,
        };
      }
      return null;
    } catch (error) {
      throw error;
    }
  };

  public getOneProduct = async (id?: number) => {
    try {
      const product = await Database.mssql().execProc("FindUniqueProduct", {
        id: id,
      });

      const subImagesProducts = await this.getSubImagesProduct(product.id);

      return {
        ...this.parseProductVariants(product),
        sub_images_products: subImagesProducts,
      };
    } catch (error) {
      throw error;
    }
  };

  public getManyProducts = async () => {
    try {
      let products = await Database.mssql().execProc("FindManyProducts", {});

      if (products && products.length > 0) {
        products = products.map(this.parseProductVariants);
      }

      if (products && !Array.isArray(products)) {
        return this.parseProductVariants(products);
      }

      return products;
    } catch (error) {
      throw error;
    }
  };

  public searchProducts = async ({ name, minPrice, maxPrice }) => {
    try {
      const searchProducts = await Database.mssql().execProc(
        "FindManyProducts",
        {
          name,
          min_price: minPrice,
          max_price: maxPrice,
        }
      );
      return searchProducts;
    } catch (error) {
      throw error;
    }
  };

  public deleteOneProduct = async (id: number) => {
    try {
      const productDeleted = await Database.mssql().execProc("DeleteProduct", {
        product_id: id,
      });
      return productDeleted;
    } catch (error) {
      throw error;
    }
  };

  public deleteManyProducts = async () => {
    try {
      const products = await Database.mssql().execProc("FindUniqueProduct");
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

      const subImagesProducts = await this.getSubImagesProduct(
        productUpdated.id
      );

      return {
        ...this.parseProductVariants(productUpdated),
        sub_images_products: subImagesProducts,
      };
    } catch (error) {
      throw error;
    }
  };

  public updateManyProducts = async () => {
    try {
      const products = await Database.mssql().execProc("FindUniqueProduct");
      return products;
    } catch (error) {
      throw error;
    }
  };

  public toggleStatusProduct = async (id: number) => {
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
