import 'package:ecommerce_app/models/category_model.dart';

abstract class CategoryEvent {}

class AddCategory extends CategoryEvent {
  final CategoryModel category;
  AddCategory({required this.category});
}

class FetchCategories extends CategoryEvent{}