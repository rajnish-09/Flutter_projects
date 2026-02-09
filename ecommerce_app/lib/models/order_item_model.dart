class OrderItemModel {
  final String productId;
  final String title;
  final String imagePath;
  final double price;
  final double? discount;
  final int quantity;
  // final String categoryId;

  OrderItemModel({
    required this.productId,
    required this.title,
    required this.imagePath,
    required this.price,
    this.discount,
    required this.quantity,
    // required this.categoryId,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      productId: json['productId'],
      title: json['title'],
      imagePath: json['imagePath'],
      price: json['price'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() => {
    'productId': productId,
    'title': title,
    'imagePath': imagePath,
    'price': price,
    'discount': discount,
    'quantity': quantity,

    // 'categoryId': categoryId,
  };
}
