import 'package:ecommerce_app/bloc/product/product_event.dart';
import 'package:ecommerce_app/bloc/product/product_state.dart';
import 'package:ecommerce_app/service/firebase_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  FirebaseService firebaseService = FirebaseService();
  ProductBloc() : super(ProductInitial()) {
    on<AddProduct>((event, emit) async {
      emit(ProductLoading());
      await firebaseService.addProduct(event.product);
      emit(AddProductSuccess(successMsg: 'Successfully added'));
    });
  }
}
