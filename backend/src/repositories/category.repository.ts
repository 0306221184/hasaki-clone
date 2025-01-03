import { Database } from "../lib/database/database";
import SelectBuilder from "../helper/builder/sql_builder/select_builder.helper";
import InsertBuilder from "../helper/builder/sql_builder/insert_builder.helper";
export default class CategoryRepository {
  public createCategory = async ({
    name,
    description,
    parent_id,
    icon_url,
  }: {
    name: string;
    description?: string;
    parent_id?: number;
    icon_url?: string;
  }) => {
    try {
      const isExistCategoryQuery = SelectBuilder.getInstance()
        .select(["name"])
        .from("categories")
        .where(`name='${name}'`)
        .buildSqlServerQuery();
      const isExistCategory = await Database.mssql().query(
        isExistCategoryQuery
      );
      if (isExistCategory) {
        throw new Error("Category is already exist");
      }

      const createCategoryQuery = InsertBuilder.getInstance()
        .into("categories")
        .column(["name", "description", "parent_id", "icon_url"])
        .values([[name, description, parent_id, icon_url]])
        .buildSqlServerInsert();
      await Database.mssql().query(createCategoryQuery);
      return true;
    } catch (error) {
      throw error;
    }
  };
  public getManyCategories = async (): Promise<any[]> => {
    try {
      const categoriesQuery = SelectBuilder.getInstance()
        .select(["id", "name", "description", "parent_id", "icon_url"])
        .from("categories")
        .buildSqlServerQuery();
      console.log(categoriesQuery);

      const categories = await Database.mssql().query(categoriesQuery);
      return categories;
    } catch (error) {
      throw error;
    }
  };
  public getOneCategory = async (id: number): Promise<any> => {
    try {
      const categoryQuery = SelectBuilder.getInstance()
        .select(["id", "name", "description", "parent_id", "icon_url"])
        .from("categories")
        .where(`id=${id}`)
        .buildSqlServerQuery();
      const category = await Database.mssql().query(categoryQuery);
      return category;
    } catch (error) {
      throw error;
    }
  };
  public deleteOneCategory = async (id: number): Promise<boolean> => {
    try {
      const deleteCategoryQuery = `DELETE FROM categories WHERE id=${id}`;
      await Database.mssql().query(deleteCategoryQuery);
      return true;
    } catch (error) {
      throw error;
    }
  };
  public updateOneCategory = async (
    id,
    { name, description, parent_id, icon_url }
  ) => {
    try {
      const updateCategoryQuery = `UPDATE categories SET name='${name}', description='${description}', parent_id=${
        parent_id ?? "NULL"
      }, icon_url='${icon_url}' WHERE id=${id}`;
      console.log(updateCategoryQuery);

      await Database.mssql().query(updateCategoryQuery);
      return true;
    } catch (error) {
      throw error;
    }
  };
  public toggleStatusCategory = async (id: number) => {
    try {
      const toggleCategoryQuery = `UPDATE categories SET is_active = CASE WHEN is_active = 1 THEN 0 ELSE 1 END WHERE id=${id}`;
      await Database.mssql().query(toggleCategoryQuery);
      return true;
    } catch (error) {
      throw error;
    }
  };
}
