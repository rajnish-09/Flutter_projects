import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

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
                  onPressed: () {},
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
    );
  }
}
