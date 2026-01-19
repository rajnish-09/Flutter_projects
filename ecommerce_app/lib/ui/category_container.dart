import 'package:ecommerce_app/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryContainerCard extends StatelessWidget {
  const CategoryContainerCard({super.key, required this.category});
  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color.fromARGB(255, 255, 255, 255),
        boxShadow: [
          BoxShadow(color: Colors.grey, offset: Offset(-4, 4), blurRadius: 8),
        ],
      ),
      child: Column(
        children: [
          Wrap(
            spacing: 5,
            runSpacing: 5,
            children: category.imagePath.map((img) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(img, width: 50),
              );
            }).toList(),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                category.title,
                style: GoogleFonts.raleway(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: Color(0xffDFE9FF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '100',
                  style: GoogleFonts.raleway(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
