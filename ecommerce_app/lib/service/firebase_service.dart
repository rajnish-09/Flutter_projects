import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/cart_item_view_model.dart';
import 'package:ecommerce_app/models/cart_model.dart';
import 'package:ecommerce_app/models/category_model.dart';
import 'package:ecommerce_app/models/favorite_model.dart';
import 'package:ecommerce_app/models/order_model.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';

class FirebaseService {
  final categoriesCollection = FirebaseFirestore.instance.collection(
    'categories',
  );
  final productCollection = FirebaseFirestore.instance.collection('Products');
  // final cartCollection = FirebaseFirestore.instance.collection('Cart');
  // final orderCollection = FirebaseFirestore.instance.collection('Orders');
  final userCollection = FirebaseFirestore.instance.collection(
    'Ecommerce_users',
  );

  //Firebase auth
  Future<String> createUsers({required UserModel userData}) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
          email: userData.email,
          password: userData.password!,
        );
    String uid = userCredential.user!.uid;
    userCollection.doc(uid).set(userData.toJson());
    return uid;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    final response = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return response.user!.uid;
  }

  Future<User?> currentUser() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      return user;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> signoutUser() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<UserModel> getUserData() async {
    final User? user = FirebaseAuth.instance.currentUser;
    final response = await userCollection.doc(user!.uid).get();
    return UserModel.fromJson(
      response.data() as Map<String, dynamic>,
      response.id,
    );
  }

  Future<void> updateUserData(UserModel updatedUserData) async {
    final User? user = FirebaseAuth.instance.currentUser;
    await userCollection.doc(user!.uid).update(updatedUserData.toJson());
  }

   Future<UserModel> getUser() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      final response = await userCollection.doc(user!.uid).get();
      return UserModel.fromJson(
        response.data() as Map<String, dynamic>,
        response.id,
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //----------------Category-----------------------------

  Future<void> addCategory(CategoryModel category) async {
    await categoriesCollection.add(category.toJson());
  }

  Future<List<CategoryModel>> getAllCategories() async {
    final response = await categoriesCollection.get();
    return response.docs
        .map((e) => CategoryModel.fromJson(e.data(), e.id))
        .toList();
  }

  //----------------Product-----------------------------

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

  //----------------Cart-----------------------------

  Future<void> addProductToCart(CartModel cart) async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    await userCollection.doc(user.uid).collection('Cart').add(cart.toJson());
    // await cartCollection.add(cart.toJson());
  }

  // Future<List<CartModel>> getCartItems() async {
  //   final response = await cartCollection.get();
  //   return response.docs
  //       .map((e) => CartModel.fromJson(e.data(), e.id))
  //       .toList();
  // }

  Future<List<CartItemViewModel>> getCartWithProducts() async {
    final User? user = FirebaseAuth.instance.currentUser;
    final response = await userCollection
        .doc(user!.uid)
        .collection('Cart')
        .get();
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

  Future<void> deleteCartItem(CartModel cart) async {
    final User? user = FirebaseAuth.instance.currentUser;
    await userCollection
        .doc(user!.uid)
        .collection('Cart')
        .doc(cart.id)
        .delete();
    // await cartCollection.doc(cart.id).delete();
  }

  Future<void> clearCart() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    // 1. Get reference to the cart collection
    final cartRef =
        userCollection // or your userCollection
            .doc(user.uid)
            .collection("Cart"); // Make sure this matches your cart path

    // 2. Get all documents in that collection
    final snapshots = await cartRef.get();

    // 3. Start a write batch
    final batch = FirebaseFirestore.instance.batch();

    for (var doc in snapshots.docs) {
      batch.delete(doc.reference);
    }

    // 4. Commit the batch
    await batch.commit();
  }

  //----------------Order-----------------------------

  Future<void> placeOrder(OrderModel order) async {
    final User? user = FirebaseAuth.instance.currentUser;
    await userCollection.doc(user!.uid).collection('Order').add(order.toJson());
  }

  Future<List<OrderModel>> getOrderItems() async {
    final User? user = FirebaseAuth.instance.currentUser;
    final response = await userCollection
        .doc(user!.uid)
        .collection('Order')
        .orderBy('createdAt', descending: true)
        .get();
    return response.docs
        .map((e) => OrderModel.fromJson(e.data(), e.id))
        .toList();
  }

  //-----------------------Favorite--------------------------------------------
  Future<void> addFavoriteProduct(FavoriteModel favProduct) async {
    final User? user = FirebaseAuth.instance.currentUser;
    await userCollection
        .doc(user!.uid)
        .collection('Favorite')
        .doc(favProduct.productId)
        .set(favProduct.toJson());
  }

  Future<bool> isProductFavorite(String productId) async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return false;

    final snapshot = await userCollection
        .doc(user.uid)
        .collection('Favorite')
        .where('productId', isEqualTo: productId)
        .get();

    return snapshot.docs.isNotEmpty;
  }

  Future<void> removeFavorite(FavoriteModel favProduct) async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    await userCollection
        .doc(user.uid)
        .collection('Favorite')
        .doc(favProduct.productId)
        .delete();
  }

  Future<List<ProductModel>> getFavoriteProducts() async {
    final user = FirebaseAuth.instance.currentUser;

    // 1. Get IDs from Favorites
    final favSnapshot = await userCollection
        .doc(user!.uid)
        .collection('Favorite')
        .get();

    List<String> productIds = favSnapshot.docs
        .map((doc) => doc.id) // Assuming document ID = Product ID
        .toList();

    if (productIds.isEmpty) return [];

    // 2. Fetch all products whose ID is in our list (Max 30 IDs per query)
    final productSnapshot = await productCollection
        .where(FieldPath.documentId, whereIn: productIds)
        .get();

    return productSnapshot.docs
        .map((doc) => ProductModel.fromJson(doc.data(), doc.id))
        .toList();
  }

  Future<void> deleteFavoriteItem(CartModel cart) async {
    final User? user = FirebaseAuth.instance.currentUser;
    await userCollection
        .doc(user!.uid)
        .collection('Favorite')
        .doc(cart.productId)
        .delete();
    // await cartCollection.doc(cart.id).delete();
  }
}
