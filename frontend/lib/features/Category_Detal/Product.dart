class Product {
  final String imageUrl;
  final String name;
  final int price;
  final double rating;
  final String categoryId;
  final String description;

  Product({
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.rating,
    required this.categoryId,
    required this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      imageUrl: json['image_url'] ?? '',
      name: json['name'] ?? '',
      price: (json['price'] as num?)?.toInt() ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      categoryId: json['category_id'] ?? '',
      description: json['description'] ?? '',
    );
  }
}
