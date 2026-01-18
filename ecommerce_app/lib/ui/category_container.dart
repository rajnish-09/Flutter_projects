import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryContainerCard extends StatelessWidget {
  const CategoryContainerCard({super.key, required this.category});

  final Map<String, dynamic> category;

  @override
  Widget build(BuildContext context) {
    final images = category['imagesPath'] as List<String>;
    return Expanded(
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: images.map((imgPath) {
                return Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(imgPath)),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            Text(
              category['title'],
              style: GoogleFonts.raleway(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
