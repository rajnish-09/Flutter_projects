import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String name, phone, email, password;
  final String? uid;

  UserModel({
    required this.name,
    required this.phone,
    this.uid,
    required this.email,
    required this.password
  });

  factory UserModel.fromJson(Map<String, dynamic> json, String id) {
    return UserModel(
      uid: id,
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      password: json['password']
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'phone': phone,
    'email': email,
  };
}
