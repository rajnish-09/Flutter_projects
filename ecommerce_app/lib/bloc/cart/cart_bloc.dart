import 'package:ecommerce_app/bloc/cart/cart_event.dart';
import 'package:ecommerce_app/bloc/cart/cart_state.dart';
import 'package:ecommerce_app/service/firebase_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  FirebaseService firebaseService = FirebaseService();
  CartBloc() : super(CartInitial()) {
    on<AddToCart>((event, emit) async {
      emit(CartLoading());
      await firebaseService.addProductToCart(event.cart);
      emit(AddToCartSuccess(msg: 'Product added to cart'));
    });

    on<FetchCartItems>((event, emit) async {
      emit(CartLoading());
      final cart = await firebaseService.getCartWithProducts();
      emit(CartLoaded(cartItems: cart));
    });
  }
}
