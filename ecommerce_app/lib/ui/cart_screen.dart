import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Checkout",
          style: GoogleFonts.raleway(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                height: 130,
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
                                ),
                                Text("Contact :  +44-784232"),
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
              Container(
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
                          child: Image.asset(
                            'assets/images/watch1.jpg',
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Women’s Casual Wear",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text("Size: XL"),
                              Text("Delivery: Express"),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 3,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Color(0xffCACACA),
                                      ),
                                    ),
                                    child: Text(
                                      "Rs 2000",
                                      style: GoogleFonts.raleway(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Column(
                                    children: [
                                      Text(
                                        "Upto 30% off",
                                        style: TextStyle(
                                          color: Color(0xffEB3030),
                                          fontSize: 8,
                                        ),
                                      ),
                                      Text(
                                        "Rs 2500",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 10,
                                          decoration:
                                              TextDecoration.lineThrough,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total order(1):",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Rs 2000",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
