import CategoryRepository from "../repositories/category.repository";
export default class CategoryService {
  private readonly repository: CategoryRepository;
  constructor(repository: CategoryRepository = new CategoryRepository()) {
    this.repository = repository;
  }
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
      const categoryCreated = await this.repository.createCategory({
        name,
        description,
        parent_id,
        icon_url,
      });
      return categoryCreated;
    } catch (error) {
      throw error;
    }
  };
  public getManyCategories = async () => {
    try {
      const categories = await this.repository.getManyCategories();
      return categories;
    } catch (error) {
      throw error;
    }
  };
  public getOneCategory = async (id) => {
    try {
      const category = await this.repository.getOneCategory(id);
      return category;
    } catch (error) {
      throw error;
    }
  };
  public deleteOneCategory = async (id) => {
    try {
      const categoryDeleted = await this.repository.deleteOneCategory(id);
      return categoryDeleted;
    } catch (error) {
      throw error;
    }
  };
  public updateOneCategory = async (
    id,
    { name, description, parent_id, icon_url }
  ) => {
    try {
      const categoryUpdated = await this.repository.updateOneCategory(id, {
        name,
        description,
        parent_id,
        icon_url,
      });
      return categoryUpdated;
    } catch (error) {
      throw error;
    }
  };
  public toggleStatusCategory = async (id) => {
    try {
      const toggleStatusCategory = await this.repository.toggleStatusCategory(
        id
      );
      return toggleStatusCategory;
    } catch (error) {
      throw error;
    }
  };
}
