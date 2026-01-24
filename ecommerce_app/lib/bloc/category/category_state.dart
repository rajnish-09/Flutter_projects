import 'package:ecommerce_app/models/category_model.dart';

abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class AddCategorySuccess extends CategoryState {}

class AddCategoryFailed extends CategoryState {
  final String errorMessage;
  AddCategoryFailed(this.errorMessage);
}

class CategoryLoaded extends CategoryState {
  final List<CategoryModel> categories;
  CategoryLoaded({required this.categories});
}
