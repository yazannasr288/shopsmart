class ProductModel {
  const ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.category,
  });

  final String id;
  final String title;
  final double price;
  final String imageUrl;
  final String category;
}
