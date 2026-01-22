class CategoryModel {
  final String? id;
  final String title;
  final String imagePath;
  final String? code;
  CategoryModel({
    required this.title,
    required this.imagePath,
    this.id,
    this.code,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json, String id) {
    return CategoryModel(
      id: id,
      title: json['title'],
      imagePath: json['imagePath'],
      code: json['code'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'imagePath': imagePath,
    'code': code,
  };
}
