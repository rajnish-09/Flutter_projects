import 'package:ecommerce_app/bloc/cart/cart_bloc.dart';
import 'package:ecommerce_app/bloc/cart/cart_event.dart';
import 'package:ecommerce_app/bloc/cart/cart_state.dart';
import 'package:ecommerce_app/bloc/product/product_bloc.dart';
import 'package:ecommerce_app/bloc/product/product_state.dart';
import 'package:ecommerce_app/screens/user_module/checkout_screen.dart';
import 'package:ecommerce_app/widgets/delivery_container.dart';
import 'package:ecommerce_app/widgets/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String selectedDeliveryType = 'Standard';
  String deliveryTime = '5-7';
  double deliveryCost = 100;

  void getDeliveryInformation() {
    if (selectedDeliveryType == 'Standard') {
      deliveryTime = '5-7';
      deliveryCost = 100;
    }
    if (selectedDeliveryType == 'Express') {
      deliveryTime = '2-3';
      deliveryCost = 150;
    }
  }

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
          child: BlocListener<CartBloc, CartState>(
            listener: (context, state) {
              if (state is CartItemDeleted) {
                showToastWidget(state.msg, Colors.green);
              }
              if (state is CartItemDeleteFailed) {
                showToastWidget(state.msg, Colors.red);
              }
            },
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
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
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
                      if (state.cartItems.isEmpty) {
                        return Center(child: Text("No items in cart yet."));
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: state.cartItems.length,
                        itemBuilder: (context, index) {
                          final cart = state.cartItems[index];
                          double discountedPrice = cart.product.price;
                          double itemTotal =
                              cart.product.price * cart.cart.quantity;
                          if (cart.product.discount != null &&
                              cart.product.discount! > 0) {
                            discountedPrice =
                                cart.product.price -
                                ((cart.product.price * cart.product.discount!) /
                                    100);
                            itemTotal = discountedPrice * cart.cart.quantity;
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
                                            cart.product.imagePath,
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
                                                cart.product.title,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Text(
                                                "Quantity: ${cart.cart.quantity}",
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
                                                                FontWeight.bold,
                                                          ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 5),
                                                  if (cart.product.discount !=
                                                          null &&
                                                      cart.product.discount! >
                                                          0)
                                                    Column(
                                                      children: [
                                                        Text(
                                                          "Upto ${cart.product.discount!.toStringAsFixed(1)}% off",
                                                          style: TextStyle(
                                                            color: Color(
                                                              0xffEB3030,
                                                            ),
                                                            fontSize: 8,
                                                          ),
                                                        ),
                                                        Text(
                                                          cart.product.price
                                                              .toString(),
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
                                    Divider(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Total order(${cart.cart.quantity}):",
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
                                    context.read<CartBloc>().add(
                                      DeleteCartItem(cart: cart.cart),
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
                Divider(),
                Text(
                  "Delivery",
                  style: GoogleFonts.raleway(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDeliveryType = 'Standard';
                    });
                  },
                  child: DeliveryContainer(
                    title: 'Standard',
                    time: '5-7',
                    cost: 100,
                    isSelected: selectedDeliveryType == 'Standard',
                  ),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDeliveryType = 'Express';
                    });
                  },
                  child: DeliveryContainer(
                    title: 'Express',
                    time: '2-3',
                    cost: 150,
                    isSelected: selectedDeliveryType == 'Express',
                  ),
                ),
                SizedBox(height: 10),
                Divider(),
                SizedBox(height: 10),
                BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    double totalSum = 0;
                    double shippingFee = 0;
                    double grandTotal = 0;
                    if (state is CartLoaded) {
                      totalSum = state.cartItems.fold(0, (sum, item) {
                        double price = item.product.price;
                        if (item.product.discount != null &&
                            item.product.discount! > 0) {
                          price =
                              item.product.price -
                              ((item.product.price * item.product.discount!) /
                                  100);
                        }
                        return sum + (price * item.cart.quantity);
                      });
                      grandTotal = totalSum + shippingFee;
                    }
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Total:"),
                            Text(
                              totalSum.toString(),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Grand Total:"),
                            Text(
                              grandTotal.toString(),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CheckoutScreen(),
                        ),
                      );
                    },
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
      ),
    );
  }
}
