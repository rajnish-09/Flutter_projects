class UserModel {
  final String name, email, phone;
  final String? id, password;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    this.password,
    this.id,
  });

  factory UserModel.fromJson(Map<String, dynamic> json, String id) {
    return UserModel(
      id: id,
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'phone': phone,
  };
}
