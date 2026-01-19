class ProductModel {
  final String imagePath, title, description;
  final double price, rating;

  ProductModel({
    required this.imagePath,
    required this.title,
    required this.description,
    required this.price,
    required this.rating,
  });
}

class Product {
  List<ProductModel> products = [
    ProductModel(
      imagePath: 'assets/images/just_for_you_image1.jpg',
      title: 'Huba T-shirt very goood',
      description:
          'klsdj flsdjflksdjf ldsjj sdjkfhsdhf lsd flksdjf lksdflkjd flds',
      price: 2000,
      rating: 4,
    ),
    ProductModel(
      imagePath: 'assets/images/just_for_you_image2.jpg',
      title: 'Wild horn bag',
      description: 'klsdj flsdjflksdjf ldsjj flds',
      price: 5000,
      rating: 3,
    ),
    ProductModel(
      imagePath: 'assets/images/just_for_you_image3.jpg',
      title: 'Denim pants',
      description: 'klsdj flsdjflksdjf ldsjj flds',
      price: 3200,
      rating: 4,
    ),
    ProductModel(
      imagePath: 'assets/images/just_for_you_image4.jpg',
      title: 'Abibas shoe',
      description: 'klsdj flsdjflksdjf ldsjj flds',
      price: 10000,
      rating: 5,
    ),
  ];
}
