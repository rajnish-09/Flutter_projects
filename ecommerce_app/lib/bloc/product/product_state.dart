import 'package:ecommerce_app/models/product_model.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class AddProductSuccess extends ProductState {
  final String successMsg;
  AddProductSuccess({required this.successMsg});
}

class AddProductFailed extends ProductState {
  final String errorMsg;
  AddProductFailed({required this.errorMsg});
}

class ProductLoadSuccess extends ProductState {
  final String successMsg;
  ProductLoadSuccess({required this.successMsg});
}
class ProductLoadFailed extends ProductState {
  final String errorMsg;
  ProductLoadFailed({required this.errorMsg});
}

class ProductLoaded extends ProductState {
  final List<ProductModel> products;
  ProductLoaded({required this.products});
}

class EditProductSuccess extends ProductState {
  final String successMsg;
  EditProductSuccess({required this.successMsg});
}

class EditProductFailed extends ProductState {
   final String errorMsg;
  EditProductFailed({required this.errorMsg});
}
