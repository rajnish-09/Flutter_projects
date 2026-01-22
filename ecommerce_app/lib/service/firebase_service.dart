import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/category_model.dart';

class FirebaseService {
  final categoriesCollection = FirebaseFirestore.instance.collection(
    'categories',
  );

  Future<void> addCategory(CategoryModel category) async {
    await categoriesCollection.add(category.toJson());
  }
}
