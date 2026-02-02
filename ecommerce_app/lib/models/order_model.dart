import 'package:ecommerce_app/models/cart_item_view_model.dart';
import 'package:ecommerce_app/models/order_item_model.dart';
import 'package:ecommerce_app/models/product_model.dart';

class OrderModel {
  final String? id;
  final double totalItems;
  List<OrderItemModel> cartItems;
  final String deliveryType, deliveryTime;
  final double deliveryCost;
  // final String deliveryAddress;
  final String paymentMethod, paymentStatus;
  final double total;

  OrderModel({
    this.id,
    required this.totalItems,
    required this.cartItems,
    required this.deliveryType,
    required this.deliveryTime,
    required this.deliveryCost,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.total,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json, String id) {
    return OrderModel(
      id: id,
      totalItems: json['totalItems'],
      cartItems: json['cartItems'],
      deliveryType: json['deliveryType'],
      deliveryTime: json['deliveryTime'],
      deliveryCost: json['deliveryCost'],
      paymentMethod: json['paymentMethod'],
      paymentStatus: json['paymentStatus'],
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() => {
    'totalItems': totalItems,
    'cartItems': cartItems.map((e) => e.toJson()).toList(),
    'deliveryType': deliveryType,
    'deliveryTime': deliveryTime,
    'deliveryCost': deliveryCost,
    'paymentMethod': paymentMethod,
    'paymentStatus': paymentStatus,
    'total': total,
    'createdAt': DateTime.now().toIso8601String(),
  };
}
