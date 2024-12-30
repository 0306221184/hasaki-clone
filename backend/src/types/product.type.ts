export type Product = {
  id: number;
  name: String;
  description?: String;
  price: Number;
  discount_price?: Number;
  sku?: String;
  quantity_in_stock: Number;
  category_id?: Number;
  category_name?: String;
  is_active?: Boolean;
  created_at?: String;
  updated_at?: String;
  rating?: Number;
  image_url?: String;
  color_variants?: String;
  size_variants?: String;
  tags?: String;
};
