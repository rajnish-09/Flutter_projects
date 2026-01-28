class CategoryModel {
  final String? id;
  final String name;
  final String imagePath;
  final String? code;
  CategoryModel({
    required this.name,
    required this.imagePath,
    this.id,
    this.code,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json, String id) {
    return CategoryModel(
      id: id,
      name: json['name'],
      imagePath: json['imagePath'],
      code: json['code'],
    );
  }

  Map<String, dynamic> toJson() => {
    // 'id': id,
    'name': name,
    'imagePath': imagePath,
    'code': code,
  };
}
