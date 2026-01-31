import 'package:ecommerce_app/models/cart_item_view_model.dart';
import 'package:ecommerce_app/models/cart_model.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartItemViewModel> cartItems;
  CartLoaded({required this.cartItems});
}

class AddToCartSuccess extends CartState {
  final String msg;
  AddToCartSuccess({required this.msg});
}

class AddToCartFailed extends CartState {
  final String msg;
  AddToCartFailed({required this.msg});
}
