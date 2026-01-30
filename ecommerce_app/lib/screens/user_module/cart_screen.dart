import 'package:ecommerce_app/bloc/cart/cart_bloc.dart';
import 'package:ecommerce_app/bloc/cart/cart_event.dart';
import 'package:ecommerce_app/bloc/cart/cart_state.dart';
import 'package:ecommerce_app/bloc/product/product_bloc.dart';
import 'package:ecommerce_app/bloc/product/product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // double totalSum = 0;
  @override
  void initState() {
    super.initState();
    context.read<CartBloc>().add(FetchCartItems());
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_back_ios_sharp),
                  ),
                  Text(
                    "Checkout",
                    style: GoogleFonts.raleway(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Icon(Icons.location_on),
                  SizedBox(width: 5),
                  Text(
                    "Delivery Address",
                    style: GoogleFonts.raleway(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 120,
                child: Row(
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Address:",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "216 St Paul's Rd, London N1 2LL, UK",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  "Contact :  +977-9861491364",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.edit),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 15),
                    Container(
                      width: 80,
                      height: double.infinity,
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
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.add_rounded),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25),
              Text(
                "Shopping list",
                style: GoogleFonts.raleway(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),
              BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  if (state is CartLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (state is CartLoaded) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: state.cart.length,
                      itemBuilder: (context, index) {
                        final cart = state.cart[index];
                        double discountedPrice = cart.price;
                        double itemTotal = cart.price * cart.quantity;
                        if (cart.discount != null && cart.discount! > 0) {
                          discountedPrice =
                              cart.price -
                              ((cart.price * cart.discount!) / 100);
                          itemTotal = discountedPrice * cart.quantity;
                        }
                        return Container(
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
                                      cart.imagePath,
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
                                          cart.title,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text("Quantity: ${cart.quantity}"),
                                        Text("Delivery: ${cart.deliveryType}"),
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
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                  color: Color(0xffCACACA),
                                                ),
                                              ),
                                              child: Text(
                                                discountedPrice.toString(),
                                                style: GoogleFonts.raleway(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 5),
                                            if (cart.discount != null &&
                                                cart.discount! > 0)
                                              Column(
                                                children: [
                                                  Text(
                                                    "Upto ${cart.discount!.toStringAsFixed(0)}% off",
                                                    style: TextStyle(
                                                      color: Color(0xffEB3030),
                                                      fontSize: 8,
                                                    ),
                                                  ),
                                                  Text(
                                                    cart.price.toString(),
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 10,
                                                      decoration: TextDecoration
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
                              Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total order(${cart.quantity}):",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Rs $itemTotal",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                  return SizedBox();
                },
              ),
              Divider(),
              BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  double totalSum = 0;
                  if (state is CartLoaded) {
                    totalSum = state.cart.fold(0, (sum, item) {
                      double price = item.price;
                      if (item.discount != null && item.discount! > 0) {
                        price =
                            item.price - ((item.price * item.discount!) / 100);
                      }
                      return sum + (price * item.quantity);
                    });
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Grand Total:"),
                      Text(
                        totalSum.toString(),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffFF5F1F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Proceed to checkout",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
