class CartModel {
  final String productId;
  final String deliveryType, deliveryTime;
  final double deliveryCost;
  final int quantity;

  CartModel({
    required this.productId,
    required this.deliveryType,
    required this.deliveryTime,
    required this.deliveryCost,
    required this.quantity,
    // required this.productId
  });

  factory CartModel.fromJson(Map<String, dynamic> json, String id) {
    return CartModel(
      productId: json['productId'],
      deliveryType: json['deliveryType'],
      deliveryTime: json['deliveryTime'],
      deliveryCost: json['deliveryCost'],
      quantity: json['quantity'],
      // productId:json['productId']
    );
  }

  Map<String, dynamic> toJson() => {
    'productId': productId,
    'deliveryType': deliveryType,
    'deliveryTime': deliveryTime,
    'deliveryCost': deliveryCost,
    'quantity': quantity,
    // 'productId':productId
  };
}
