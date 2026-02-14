import 'dart:math';

import 'package:ecommerce_app/bloc/order/order_bloc.dart';
import 'package:ecommerce_app/bloc/order/order_event.dart';
import 'package:ecommerce_app/bloc/order/order_state.dart';
import 'package:ecommerce_app/models/order_model.dart';
import 'package:ecommerce_app/screens/admin_module/orders_screen.dart';
import 'package:ecommerce_app/screens/user_module/cart_screen.dart';
import 'package:ecommerce_app/screens/user_module/main_navigation_screen.dart';
import 'package:ecommerce_app/screens/user_module/order_history_screen.dart';
import 'package:ecommerce_app/widgets/delivery_container.dart';
import 'package:ecommerce_app/widgets/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khalti_checkout_flutter/khalti_checkout_flutter.dart';

class CheckoutScreen extends StatefulWidget {
  final OrderModel order;
  final String pidx;
  const CheckoutScreen({super.key, required this.order, required this.pidx});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  // late Future<Khalti> khalti;
  String selectedValue = '';

  // @override
  // void initState() {
  //   super.initState();
  // }

  Future<void> payWithKhalti() async {
    print("pidx ${widget.pidx}");
    final khaltiPayConfig = KhaltiPayConfig(
      publicKey: '4a6893e250b14e8f8303c4f45b3d1dec',
      pidx: widget.pidx,
      environment: Environment.test,
    );
    
    final khalti = await Khalti.init(
      payConfig: khaltiPayConfig,
      onPaymentResult: (paymentResult, khalti) {
        final finalOrder = widget.order.copyWith(
          paymentMethod: selectedValue,
          paymentStatus: 'Completed',
        );
        context.read<OrderBloc>().add(PlaceOrder(orders: finalOrder));
        khalti.close(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainNavigationScreen(currentIndex: 3,)),
        );
      },
      onMessage:
          (
            khalti, {
            description,
            statusCode,
            event,
            needsPaymentConfirmation,
          }) async {
            debugPrint(
              'Description: $description, Status Code: $statusCode, Event: $event, NeedsPaymentConfirmation: $needsPaymentConfirmation',
            );
            khalti.close(context);
          },
      onReturn: () => debugPrint('Successfully redirected to return_url.'),
    );
    khalti.open(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Choose payment method")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: BlocListener<OrderBloc, OrderState>(
            listener: (context, state) {
              if (state is OrderSuccess) {
                showSnackBar(
                  context: context,
                  msg: state.msg,
                  backgroundColor: Colors.green,
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainNavigationScreen(currentIndex: 2),
                  ),
                );
              }
            },
            child: Column(
              children: [
                Text(widget.pidx),
                Text("Choose one of the following payment method:"),
                SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedValue = 'esewa';
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      border: selectedValue == 'esewa'
                          ? Border.all(color: Colors.blue)
                          : Border.all(color: Colors.transparent),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/esewa.png",
                          width: 30,
                          height: 30,
                        ),
                        SizedBox(width: 14),
                        Text("eSewa"),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedValue = 'khalti';
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      border: selectedValue == 'khalti'
                          ? Border.all(color: Colors.blue)
                          : Border.all(color: Colors.transparent),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/khalti.png",
                          width: 30,
                          height: 30,
                        ),
                        SizedBox(width: 14),
                        Text("Khalti"),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedValue = 'cod';
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      border: selectedValue == 'cod'
                          ? Border.all(color: Colors.blue)
                          : Border.all(color: Colors.transparent),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.attach_money_sharp),
                        SizedBox(width: 14),
                        Text("Cash on delivery (Cod)"),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15),

                SizedBox(height: 25),
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
                      if (selectedValue.isEmpty) {
                        showSnackBar(
                          context: context,
                          msg: 'Please select a payment method.',
                          backgroundColor: Colors.red,
                        );
                        return;
                      }
                      if (selectedValue == 'khalti') {
                        payWithKhalti();
                      }
                    },
                    child: Text(
                      "Place order",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
