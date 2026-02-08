import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String name, phone, email;
  final String? uid, password;
  final String? country, province, city, street;
  final String role = 'user';
  final String? imagePath;

  UserModel({
    required this.name,
    required this.phone,
    this.uid,
    required this.email,
    this.country,
    this.province,
    this.city,
    this.street,
    this.imagePath,
    this.password
  });

  factory UserModel.fromJson(Map<String, dynamic> json, String id) {
    return UserModel(
      uid: id,
      name: json['name']??'',
      phone: json['phone']??'',
      email: json['email']??'',
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
