import 'package:ecommerce_app/models/cart_model.dart';
import 'package:ecommerce_app/models/product_model.dart';

class CartItemViewModel {
  final CartModel cart;
  final ProductModel product;
  CartItemViewModel({required this.cart, required this.product});
}
