import 'package:ecommerce_app/models/cart_model.dart';
import 'package:ecommerce_app/models/favorite_model.dart';

abstract class FavoriteEvent {}

class LoadFavorites extends FavoriteEvent {}

class ToggleFavorite extends FavoriteEvent {
  final FavoriteModel favProductId;
  final bool isAdding;
  ToggleFavorite({required this.favProductId, required this.isAdding});
}

class DeleteFavorite extends FavoriteEvent {
  CartModel cart;
  DeleteFavorite({required this.cart});
}
