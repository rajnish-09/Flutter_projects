import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String name, phone, email;
  final String? uid;
  final String? imagePath;

  UserModel({
    required this.name,
    required this.phone,
    this.uid,
    required this.email,
    this.imagePath,
  });

  factory UserModel.fromJson(Map<String, dynamic> json, String id) {
    return UserModel(
      uid: id,
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      imagePath: json['imagePath'],
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'phone': phone,
    'email': email,
    'imagePath': imagePath,
  };
}
