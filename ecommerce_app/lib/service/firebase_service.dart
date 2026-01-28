import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/category_model.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:http/http.dart';

class FirebaseService {
  final categoriesCollection = FirebaseFirestore.instance.collection(
    'categories',
  );
  final productCollection = FirebaseFirestore.instance.collection('Products');

  Future<void> addCategory(CategoryModel category) async {
    await categoriesCollection.add(category.toJson());
  }

  Future<List<CategoryModel>> getAllCategories() async {
    final response = await categoriesCollection.get();
    return response.docs
        .map(
          (e) => CategoryModel.fromJson(e.data(), e.id),
        )
        .toList();
  }

  Future<void> addProduct(ProductModel product) async {
    await productCollection.add(product.toJson());
  }

  Future<List<ProductModel>> getProducts() async {
    final response = await productCollection.get();
    return response.docs.map((e) => ProductModel.fromJson(e.data(), e.id)).toList();
  }
}
