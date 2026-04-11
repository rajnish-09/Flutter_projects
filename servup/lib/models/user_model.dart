class UserModel {
  final String name, email, phone;
  final String? id, password;
  final String role;
  final String? profession;
  final String? category;
  final String? experience;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    this.password,
    this.id,
    this.role = 'user',
    this.profession,
    this.category,
    this.experience,
  });

  factory UserModel.fromJson(Map<String, dynamic> json, String id) {
    return UserModel(
      id: id,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      role: json['role'] ?? 'user',
      profession: json['profession'],
      category: json['category'],
      experience: json['experience'],
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'phone': phone,
    'role': role,
    if (profession != null) 'profession': profession,
    if (category != null) 'category': category,
    if (experience != null) 'experience': experience,
  };
}
