import 'package:ecommerce_app/models/product_model.dart';

abstract class ProductEvent {}

class AddProduct extends ProductEvent {
  final ProductModel product;
  AddProduct({required this.product});
}

class FetchProduct extends ProductEvent {}

class EditProduct extends ProductEvent {
  final ProductModel product;
  EditProduct({required this.product});
}

class DeleteProduct extends ProductEvent {
  final ProductModel product;
  DeleteProduct({required this.product});
}
