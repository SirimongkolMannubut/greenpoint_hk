class ProductModel {
  final String id;
  final String storeId;
  final String name;
  final String imageUrl;
  final double price;
  final int stock;
  final String category;
  final String description;

  ProductModel({
    required this.id,
    required this.storeId,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.stock,
    required this.category,
    required this.description,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      storeId: json['store_id'],
      name: json['name'],
      imageUrl: json['image_url'],
      price: json['price']?.toDouble() ?? 0.0,
      stock: json['stock'] ?? 0,
      category: json['category'] ?? '',
      description: json['description'] ?? '',
    );
  }

  bool get inStock => stock > 0;
}
