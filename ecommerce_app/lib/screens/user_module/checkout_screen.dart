import 'package:ecommerce_app/bloc/order/order_bloc.dart';
import 'package:ecommerce_app/bloc/order/order_event.dart';
import 'package:ecommerce_app/bloc/order/order_state.dart';
import 'package:ecommerce_app/models/order_model.dart';
import 'package:ecommerce_app/screens/user_module/cart_screen.dart';
import 'package:ecommerce_app/screens/user_module/main_navigation_screen.dart';
import 'package:ecommerce_app/widgets/delivery_container.dart';
import 'package:ecommerce_app/widgets/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutScreen extends StatefulWidget {
  final OrderModel order;
  const CheckoutScreen({super.key, required this.order});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String selectedValue = '';
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
                      final finalOrder = widget.order.copyWith(
                        paymentMethod: selectedValue,
                        paymentStatus: selectedValue == 'cod'
                            ? 'Pending'
                            : 'Completed',
                      );
                      context.read<OrderBloc>().add(
                        PlaceOrder(orders: finalOrder),
                      );
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
