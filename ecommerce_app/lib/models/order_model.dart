import 'package:cloud_firestore/cloud_firestore.dart';
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
  final String orderStatus;
  final DateTime? createdAt;

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
    this.orderStatus = 'Pending',
    this.createdAt,
  });

  OrderModel copyWith({
    String? paymentMethod,
    String? paymentStatus,
    String? id,
  }) {
    return OrderModel(
      id: id ?? this.id,
      totalItems: totalItems,
      cartItems: cartItems,
      deliveryType: deliveryType,
      deliveryTime: deliveryTime,
      deliveryCost: deliveryCost,
      total: total,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      orderStatus: orderStatus,
      createdAt: createdAt,
    );
  }

  factory OrderModel.fromJson(Map<String, dynamic> json, String id) {
    return OrderModel(
      id: id,
      totalItems: json['totalItems'],
      cartItems: (json['cartItems'] as List)
          .map((e) => OrderItemModel.fromJson(e))
          .toList(),
      deliveryType: json['deliveryType'],
      deliveryTime: json['deliveryTime'],
      deliveryCost: json['deliveryCost'],
      paymentMethod: json['paymentMethod'],
      paymentStatus: json['paymentStatus'],
      total: json['total'],
      orderStatus: json['orderStatus'],
      createdAt: json['createdAt'] != null
          ? (json['createdAt'] as Timestamp).toDate()
          : null,
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
    'createdAt': FieldValue.serverTimestamp(),
    'orderStatus': orderStatus,
  };
}


