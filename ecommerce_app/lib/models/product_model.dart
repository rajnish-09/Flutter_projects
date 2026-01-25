class ProductModel {
  final String imagePath, title, description;
  final double price;
  final double? discount, rating;

  ProductModel({
    required this.imagePath,
    required this.title,
    required this.description,
    required this.price,
    this.rating,
    this.discount,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      imagePath: json['imagePath'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      discount: json['discount'],
    );
  }

  Map<String, dynamic> toJson() => {
    'imagePath': imagePath,
    'title': title,
    'description': description,
    'price': price,
    'discount': discount,
  };
}

class Product {
  List<ProductModel> products = [
    ProductModel(
      imagePath: 'assets/images/just_for_you_image4.jpg',
      title: 'Huba T-shirt very goood',
      description:
          'klsdj flsdjflksdjf ldsjj sdjkfhsdhf lsd flksdjf lksdflkjd flds',
      price: 2000,
      rating: 4,
    ),
    ProductModel(
      imagePath: 'assets/images/just_for_you_image3.jpg',
      title: 'Wild horn bag',
      description: 'klsdj flsdjflksdjf ldsjj flds',
      price: 5000,
      rating: 3,
    ),
    ProductModel(
      imagePath: 'assets/images/just_for_you_image2.jpg',
      title: 'Denim pants',
      description: 'klsdj flsdjflksdjf ldsjj flds',
      price: 3200,
      rating: 4,
    ),
    ProductModel(
      imagePath: 'assets/images/just_for_you_image1.jpg',
      title: 'Abibas shoe',
      description: 'klsdj flsdjflksdjf ldsjj flds',
      price: 10000,
      rating: 5,
    ),
    ProductModel(
      imagePath: 'assets/images/watch1.jpg',
      title: 'Titan watch Model-201',
      description: 'klsdj flsdjflksdjf ldsjj flds',
      price: 15000,
      rating: 5,
    ),
    ProductModel(
      imagePath: 'assets/images/watch2.jpg',
      title: 'Rado watch Model-A1N',
      description: 'klsdj flsdjflksdjf ldsjj flds',
      price: 4000,
      rating: 5,
    ),
  ];
}
