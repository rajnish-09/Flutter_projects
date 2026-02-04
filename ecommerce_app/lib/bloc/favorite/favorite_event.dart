

import 'package:ecommerce_app/models/favorite_model.dart';

abstract class FavoriteEvent {}

class LoadFavorites extends FavoriteEvent {}

class ToggleFavorite extends FavoriteEvent {
  final FavoriteModel favProductId;
  ToggleFavorite({required this.favProductId});
}
