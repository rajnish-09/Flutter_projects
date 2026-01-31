import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/cart_item_view_model.dart';
import 'package:ecommerce_app/models/cart_model.dart';
import 'package:ecommerce_app/models/category_model.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:http/http.dart';

class FirebaseService {
  final categoriesCollection = FirebaseFirestore.instance.collection(
    'categories',
  );
  final productCollection = FirebaseFirestore.instance.collection('Products');
  final cartCollection = FirebaseFirestore.instance.collection('Cart');

  Future<void> addCategory(CategoryModel category) async {
    await categoriesCollection.add(category.toJson());
  }

  Future<List<CategoryModel>> getAllCategories() async {
    final response = await categoriesCollection.get();
    return response.docs
        .map((e) => CategoryModel.fromJson(e.data(), e.id))
        .toList();
  }

  Future<void> addProduct(ProductModel product) async {
    await productCollection.add(product.toJson());
  }

  Future<List<ProductModel>> getProducts() async {
    final response = await productCollection.get();
    return response.docs
        .map((e) => ProductModel.fromJson(e.data(), e.id))
        .toList();
  }

  Future<void> editProduct(ProductModel product) async {
    await productCollection.doc(product.id).update(product.toJson());
  }

  Future<void> deleteProduct(ProductModel product) async {
    await productCollection.doc(product.id).delete();
  }

  Future<void> addProductToCart(CartModel cart) async {
    await cartCollection.add(cart.toJson());
  }

  Future<List<CartModel>> getCartItems() async {
    final response = await cartCollection.get();
    return response.docs
        .map((e) => CartModel.fromJson(e.data(), e.id))
        .toList();
  }

  Future<List<CartItemViewModel>> getCartWithProducts() async {
    final response = await cartCollection.get();
    return Future.wait(
      response.docs.map((e) async {
        final cart = CartModel.fromJson(e.data(), e.id);
        final productDoc = await productCollection.doc(cart.productId).get();
        final product = ProductModel.fromJson(
          productDoc.data()!,
          productDoc.id,
        );
        return CartItemViewModel(cart: cart, product: product);
      }),
    );
  }

  // Future<List<CartItemVM>> getCartWithProducts() async {
  //   final cartSnapshot = await cartRef.get();

  //   final cartItems = await Future.wait(
  //     cartSnapshot.docs.map((doc) async {
  //       final cart = CartModel.fromJson(doc.data());

  //       final productDoc =
  //           await productsRef.doc(cart.productId).get();

  //       final product = ProductModel.fromJson(productDoc.data()!);

  //       return CartItemVM(cart: cart, product: product);
  //     }),
  //   );

  //   return cartItems;
  // }
}
