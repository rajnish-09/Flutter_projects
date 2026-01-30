class CartModel {
  final String categoryId;
  final String? id;
  final String imagePath, title, description, deliveryType, deliveryTime;
  final double price, deliveryCost;
  final double? discount, rating;
  final int quantity;

  CartModel({
    required this.categoryId,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.price,
    this.rating,
    this.discount,
    this.id,
    required this.deliveryType,
    required this.deliveryTime,
    required this.deliveryCost,
    required this.quantity,
  });

  factory CartModel.fromJson(Map<String, dynamic> json, String id) {
    return CartModel(
      id: id,
      categoryId: json['categoryId'],
      imagePath: json['imagePath'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      discount: json['discount'],
      rating: json['rating'],
      deliveryType: json['deliveryType'],
      deliveryTime: json['deliveryTime'],
      deliveryCost: json['deliveryCost'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() => {
    'categoryId': categoryId,
    'imagePath': imagePath,
    'title': title,
    'description': description,
    'price': price,
    'discount': discount,
    'rating': rating,
    'deliveryType': deliveryType,
    'deliveryTime': deliveryTime,
    'deliveryCost': deliveryCost,
    'quantity': quantity,
  };
}
