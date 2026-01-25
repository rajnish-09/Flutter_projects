import 'package:ecommerce_app/models/product_model.dart';

abstract class ProductEvent {}

class AddProduct extends ProductEvent {
  final ProductModel product;
  AddProduct({required this.product});
}
