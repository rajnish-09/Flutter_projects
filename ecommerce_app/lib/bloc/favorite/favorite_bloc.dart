import 'package:ecommerce_app/bloc/favorite/favorite_event.dart';
import 'package:ecommerce_app/bloc/favorite/favorite_state.dart';
import 'package:ecommerce_app/service/firebase_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FirebaseService firebaseService = FirebaseService();
  FavoriteBloc() : super(FavoriteInitial()) {
    on<ToggleFavorite>((event, emit) async {
      emit(FavoriteLoading());
      await firebaseService.addFavoriteProduct(event.favProductId);
    });
  }
}
