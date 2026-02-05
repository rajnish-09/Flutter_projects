import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String name, phone, email, password;
  final String? uid;
  final String? country, province, city, street;
  final String role = 'user';
  final String? imagePath;

  UserModel({
    required this.name,
    required this.phone,
    this.uid,
    required this.email,
    required this.password,
    this.country,
    this.province,
    this.city,
    this.street,
    this.imagePath,
  });

  factory UserModel.fromJson(Map<String, dynamic> json, String id) {
    return UserModel(
      uid: id,
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      password: json['password'],
      country: json['country'],
      province: json['province'],
      city: json['city'],
      street: json['street'],
      imagePath: json['imagePath'],
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'phone': phone,
    'email': email,
    'country': country,
    'province': province,
    'city': city,
    'street': street,
    'role': role,
    'imagePath': imagePath,
  };
}
