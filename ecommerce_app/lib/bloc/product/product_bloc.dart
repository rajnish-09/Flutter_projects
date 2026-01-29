import 'package:ecommerce_app/bloc/product/product_event.dart';
import 'package:ecommerce_app/bloc/product/product_state.dart';
import 'package:ecommerce_app/service/firebase_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  FirebaseService firebaseService = FirebaseService();
  ProductBloc() : super(ProductInitial()) {
    on<AddProduct>((event, emit) async {
      try {
        emit(ProductLoading());
        await firebaseService.addProduct(event.product);
        emit(AddProductSuccess(successMsg: 'Successfully added'));
        final products = await firebaseService.getProducts();
        emit(ProductLoaded(products: products));
      } catch (e) {
        emit(AddProductFailed(errorMsg: "Failed to add product"));
      }
    });

    on<FetchProduct>((event, emit) async {
      try {
        emit(ProductLoading());
        final products = await firebaseService.getProducts();
        emit(ProductLoaded(products: products));
      } catch (e) {
        emit(ProductLoadFailed(errorMsg: 'Failed to load products'));
      }
    });

    on<EditProduct>((event, emit) async {
      try {
        emit(ProductLoading());
        await firebaseService.editProduct(event.product);
        final products = await firebaseService.getProducts();
        emit(EditProductSuccess(successMsg: 'Product updated successfully'));
        emit(ProductLoaded(products: products));
      } catch (e) {
        print("DEBUG ERROR: $e");
        emit(EditProductFailed(errorMsg: 'Product updating failed.'));
      }
    });
  }
}
