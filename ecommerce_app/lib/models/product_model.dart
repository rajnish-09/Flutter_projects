class ProductModel {
  final String categoryId;
  final String? id;
  final String imagePath, title, description;
  final double price;
  final double? discount, rating;

  ProductModel({
    required this.categoryId,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.price,
    this.rating,
    this.discount,
    this.id,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json, String id) {
    return ProductModel(
      id: id,
      imagePath: json['imagePath'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      discount: json['discount'],
      categoryId: json['categoryId']
    );
  }

  Map<String, dynamic> toJson() => {
    'imagePath': imagePath,
    'title': title,
    'description': description,
    'price': price,
    'discount': discount,
    'categoryId':categoryId
  };
}

