import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/screens/cart_screen.dart';
import 'package:ecommerce_app/widgets/delivery_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDisplayScreen extends StatefulWidget {
  const ProductDisplayScreen({super.key, required this.product});
  final ProductModel product;

  @override
  State<ProductDisplayScreen> createState() => _ProductDisplayScreenState();
}

class _ProductDisplayScreenState extends State<ProductDisplayScreen> {
  @override
  Widget build(BuildContext context) {
    // final discountPercent = widget.product.discount;
    final double discountedPrice =
        widget.product.price -
        (widget.product.price * (widget.product.discount! / 100));

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Hero(
                tag: widget.product.imagePath,
                child: Image.network(
                  widget.product.imagePath,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.5,
                  fit: BoxFit.cover,
                ),
              ),
              // SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Rs $discountedPrice",
                              style: GoogleFonts.raleway(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (widget.product.discount != 0 ||
                                widget.product.discount! > 0) ...[
                              Row(
                                children: [
                                  Text(
                                    widget.product.price.toStringAsFixed(0),
                                    style: GoogleFonts.raleway(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xffF1AEAE),
                                      decoration: TextDecoration.lineThrough,
                                      decorationColor: Color(0xffF1AEAE),
                                      decorationThickness: 2,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color(0xffF81140),
                                      border: BoxBorder.all(
                                        color: Colors.transparent,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      '${widget.product.discount.toString()} %',
                                      style: GoogleFonts.raleway(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                        IconButton(onPressed: () {}, icon: Icon(Icons.share)),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      widget.product.title,
                      style: GoogleFonts.raleway(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.product.description,
                      style: GoogleFonts.nunitoSans(fontSize: 15),
                    ),
                    RatingBar(
                      filledIcon: Icons.star,
                      emptyIcon: Icons.star_border,
                      onRatingChanged: (rating) {
                        // print(rating);
                      },
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Size: XL',
                      style: GoogleFonts.raleway(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizeContainer(size: 'S'),
                        SizeContainer(size: 'M'),
                        SizeContainer(size: 'L'),
                        SizeContainer(size: 'XL'),
                        SizeContainer(size: '2XL'),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Delivery",
                      style: GoogleFonts.raleway(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    DeliveryContainer(
                      title: 'Standard',
                      time: '5-7',
                      cost: 100,
                    ),
                    SizedBox(height: 10),
                    DeliveryContainer(title: 'Express', time: '2-3', cost: 150),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(10),
                            ),
                            backgroundColor: Color(0xff004CFF),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.shopping_cart, color: Colors.white),
                              SizedBox(width: 5),
                              Text(
                                "Add to cart",
                                style: GoogleFonts.raleway(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CartScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(10),
                            ),
                            backgroundColor: Colors.green,
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.shopping_bag, color: Colors.white),
                              SizedBox(width: 5),
                              Text(
                                "Buy now",
                                style: GoogleFonts.raleway(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
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

class SizeContainer extends StatelessWidget {
  const SizeContainer({super.key, required this.size});
  final String size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Color(0xffFA7189), width: 2),
        ),
        child: Text(
          size,
          style: GoogleFonts.nunitoSans(fontSize: 14, color: Color(0xffFA7189)),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
