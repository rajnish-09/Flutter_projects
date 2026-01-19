import 'package:ecommerce_app/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDisplayContainer extends StatelessWidget {
  const ProductDisplayContainer({super.key, required this.prod});

  final ProductModel prod;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 10),
      child: GestureDetector(
        onTap: () {
          // print('Clicked');
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Color(0xffDFE9FF),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(-4, 4),
                    blurRadius: 5,
                  ),
                ],
                image: DecorationImage(
                  image: AssetImage(prod.imagePath),
                  fit: BoxFit.cover,
                ),
              ),

              // child: ClipRRect(
              //   borderRadius: BorderRadius.circular(10),
              //   child: Image.asset(prod.imagePath),
              // ),
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
            Text(prod.rating.toString()),
          ],
        ),
      ),
    );
  }
}
