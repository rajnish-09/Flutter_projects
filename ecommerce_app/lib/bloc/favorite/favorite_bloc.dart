import 'package:ecommerce_app/bloc/favorite/favorite_event.dart';
import 'package:ecommerce_app/bloc/favorite/favorite_state.dart';
import 'package:ecommerce_app/service/firebase_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FirebaseService firebaseService = FirebaseService();
  FavoriteBloc() : super(FavoriteInitial()) {
    on<ToggleFavorite>((event, emit) async {
      try {
        if (event.isAdding) {
          await firebaseService.addFavoriteProduct(event.favProductId);
          final fav = await firebaseService.getFavoriteProducts();
          emit(FavoriteLoaded(favorites: fav));
        } else {
          await firebaseService.removeFavorite(event.favProductId);
          final fav = await firebaseService.getFavoriteProducts();
          emit(FavoriteLoaded(favorites: fav));
        }
      } catch (e) {
        throw Exception(e.toString());
      }
    });

    on<LoadFavorites>((event, emit) async {
      emit(FavoriteLoading());
      final fav = await firebaseService.getFavoriteProducts();
      emit(FavoriteLoaded(favorites: fav));
    });

    on<DeleteFavorite>((event, emit) async {
      try {
        await firebaseService.deleteFavoriteItem(event.cart);
        final fav = await firebaseService.getFavoriteProducts();
        emit(FavoriteLoaded(favorites: fav));
      } catch (e) {
        print(e.toString());
        emit(FavoriteError('Error'));
      }
    });
  }
}
