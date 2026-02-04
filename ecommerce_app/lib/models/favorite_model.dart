import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteModel {
  final String productId;

  FavoriteModel({required this.productId});

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(productId: json['productId']);
  }

  Map<String, dynamic> toJson() => {
    'productId': productId,
    'createdAt': FieldValue.serverTimestamp(),
  };
}
