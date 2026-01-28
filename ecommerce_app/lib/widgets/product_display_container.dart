import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/screens/product_display_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDisplayContainer extends StatelessWidget {
  const ProductDisplayContainer({super.key, required this.prod});

  final ProductModel prod;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDisplayScreen(product: prod),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 207, 207, 207),
                offset: Offset(0, 2),
                spreadRadius: 4,
                blurRadius: 8,
              ),
            ],
            color: Colors.white,
          ),
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: prod.imagePath,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Color(0xffDFE9FF),
                    borderRadius: BorderRadius.circular(10),
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Colors.grey,
                    //     offset: Offset(-4, 4),
                    //     blurRadius: 5,
                    //   ),
                    // ],
                    image: DecorationImage(
                      image: NetworkImage(prod.imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                prod.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.nunitoSans(fontSize: 15),
              ),
              // Text(prod.description),
              Text(
                'Rs. ${prod.price}',
                style: GoogleFonts.raleway(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Text(prod.rating.toString()),
            ],
          ),
        ),
      ),
    );
  }
}
