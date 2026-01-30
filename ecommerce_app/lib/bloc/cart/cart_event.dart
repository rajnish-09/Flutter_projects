import 'package:ecommerce_app/models/cart_model.dart';

abstract class CartEvent {}

class AddToCart extends CartEvent {
  final CartModel cart;
  AddToCart({required this.cart});
}
