class CartModel {
  final String? id;
  final String productId;
  final int quantity;

  CartModel({
    required this.productId,
    required this.quantity,
    this.id
  });

  factory CartModel.fromJson(Map<String, dynamic> json, String id) {
    return CartModel(
      productId: json['productId'],
      quantity: json['quantity'],
      id:id
    );
  }

  Map<String, dynamic> toJson() => {
    'productId': productId,
    'quantity': quantity,
  };
}
