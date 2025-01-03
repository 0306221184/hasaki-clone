class ProductHelper {
  generateSKU({ name, category_id, id }) {
    const nameAbbreviation = name
      .split(" ")
      .map((word) => word[0])
      .join("")
      .toUpperCase();

    const sku = `CAT${category_id}-${nameAbbreviation}-${id
      .toString()
      .padStart(4, "0")}`;
    return sku;
  }
}
export default new ProductHelper();
