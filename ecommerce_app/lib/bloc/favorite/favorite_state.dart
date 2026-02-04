import 'package:ecommerce_app/bloc/product/product_bloc.dart';
import 'package:ecommerce_app/models/favorite_model.dart';
import 'package:ecommerce_app/models/product_model.dart';

abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteLoaded extends FavoriteState {
  final List<ProductModel> favorites;
  FavoriteLoaded({required this.favorites});
}

class FavoriteError extends FavoriteState {
  final String message;
  FavoriteError(this.message);
}
