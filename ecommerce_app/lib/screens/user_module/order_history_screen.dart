import 'package:ecommerce_app/bloc/favorite/favorite_bloc.dart';
import 'package:ecommerce_app/bloc/favorite/favorite_event.dart';
import 'package:ecommerce_app/bloc/favorite/favorite_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FavoriteBloc>().add(LoadFavorites());
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
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
                              fav.price - ((fav.price * fav.discount!) / 100);
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
                                        borderRadius: BorderRadius.circular(10),
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
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 3,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          10,
                                                        ),
                                                    border: Border.all(
                                                      color: Color(0xffCACACA),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    discountedPrice.toString(),
                                                    style: GoogleFonts.raleway(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                                        fav.price.toString(),
                                                        style: TextStyle(
                                                          color: Colors.grey,
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
                                  // context.read<CartBloc>().add(
                                  //   DeleteCartItem(cart: cart.cart),
                                  // );
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
    );
  }
}
