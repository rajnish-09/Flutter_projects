import 'package:ecommerce_app/bloc/cart/cart_bloc.dart';
import 'package:ecommerce_app/bloc/cart/cart_event.dart';
import 'package:ecommerce_app/bloc/favorite/favorite_bloc.dart';
import 'package:ecommerce_app/bloc/favorite/favorite_event.dart';
import 'package:ecommerce_app/bloc/favorite/favorite_state.dart';
import 'package:ecommerce_app/models/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  int count = 1;

  @override
  void initState() {
    super.initState();
    context.read<FavoriteBloc>().add(LoadFavorites());
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(Duration(seconds: 2));
        // if (!mounted) return;
        context.read<FavoriteBloc>().add(LoadFavorites());
      },
      child: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: RefreshIndicator(
              onRefresh: () async {
                await Future.delayed(Duration(seconds: 2));
                // if (!mounted) return;
                context.read<FavoriteBloc>().add(LoadFavorites());
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Favorites",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  BlocBuilder<FavoriteBloc, FavoriteState>(
                    builder: (context, state) {
                      if (state is FavoriteLoading) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (state is FavoriteLoaded) {
                        if (state.favorites.isEmpty) {
                          return Center(child: Text("No favorites yet."));
                        }

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: state.favorites.length,
                          itemBuilder: (context, index) {
                            final fav = state.favorites[index];
                            double discountedPrice = fav.price;
                            if (fav.discount != null && fav.discount! > 0) {
                              discountedPrice =
                                  fav.price -
                                  ((fav.price * fav.discount!) / 100);
                              // itemTotal = discountedPrice * cart.cart.quantity;
                            }
                            return Stack(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 20),
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(0, -2),
                                        blurRadius: 2,
                                        spreadRadius: -2,
                                        color: Colors.grey,
                                      ),
                                      BoxShadow(
                                        offset: Offset(0, 2),
                                        blurRadius: 10.0,
                                        spreadRadius: -2,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            child: Image.network(
                                              fav.imagePath,
                                              width: 150,
                                              height: 150,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  fav.title,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                SizedBox(height: 5),
                                                Row(
                                                  children: [
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                            horizontal: 10,
                                                            vertical: 3,
                                                          ),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              10,
                                                            ),
                                                        border: Border.all(
                                                          color: Color(
                                                            0xffCACACA,
                                                          ),
                                                        ),
                                                      ),
                                                      child: Text(
                                                        discountedPrice
                                                            .toString(),
                                                        style:
                                                            GoogleFonts.raleway(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                      ),
                                                    ),

                                                    SizedBox(width: 5),
                                                    if (fav.discount != null &&
                                                        fav.discount! > 0)
                                                      Column(
                                                        children: [
                                                          Text(
                                                            "Upto ${fav.discount!.toStringAsFixed(1)}% off",
                                                            style: TextStyle(
                                                              color: Color(
                                                                0xffEB3030,
                                                              ),
                                                              fontSize: 8,
                                                            ),
                                                          ),
                                                          Text(
                                                            fav.price
                                                                .toString(),
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 10,
                                                              decoration:
                                                                  TextDecoration
                                                                      .lineThrough,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                  ],
                                                ),
                                                SizedBox(height: 5),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Quantity",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      child: Row(
                                                        children: [
                                                          IconButton(
                                                            onPressed: () {
                                                              if (count > 1) {
                                                                setState(() {
                                                                  count--;
                                                                });
                                                              }
                                                            },
                                                            icon: Icon(
                                                              Icons.remove,
                                                              size: 20,
                                                            ),
                                                          ),
                                                          // SizedBox(width: 5),
                                                          Text(
                                                            count.toString(),
                                                          ),
                                                          // SizedBox(width: 5),
                                                          IconButton(
                                                            onPressed: () {
                                                              if (count < 9) {
                                                                setState(() {
                                                                  count++;
                                                                });
                                                              }
                                                            },
                                                            icon: Icon(
                                                              Icons.add,
                                                              size: 20,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                ElevatedButton.icon(
                                                  icon: Icon(
                                                    Icons.shopping_cart,
                                                    color: Colors.white,
                                                  ),
                                                  onPressed: () {
                                                    final cart = CartModel(
                                                      productId: fav.id!,
                                                      quantity: count,
                                                    );
                                                    context
                                                        .read<CartBloc>()
                                                        .add(
                                                          AddToCart(cart: cart),
                                                        );
                                                    context
                                                        .read<FavoriteBloc>()
                                                        .add(
                                                          DeleteFavorite(
                                                            cart: cart,
                                                          ),
                                                        );
                                                  },

                                                  style: ElevatedButton.styleFrom(
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadiusGeometry.circular(
                                                            10,
                                                          ),
                                                    ),
                                                    backgroundColor: Color(
                                                      0xff004CFF,
                                                    ),
                                                  ),
                                                  label: Text(
                                                    "Add to cart",
                                                    style: GoogleFonts.raleway(
                                                      fontSize: 15,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: IconButton(
                                    style: IconButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(
                                        143,
                                        225,
                                        225,
                                        225,
                                      ),
                                    ),
                                    onPressed: () {
                                      final cart = CartModel(
                                        productId: fav.id!,
                                        quantity: count,
                                      );
                                      context.read<FavoriteBloc>().add(
                                        DeleteFavorite(cart: cart),
                                      );
                                    },
                                    icon: Icon(Icons.delete, color: Colors.red),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      }
                      return SizedBox();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
