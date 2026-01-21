import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DeliveryContainer extends StatelessWidget {
  const DeliveryContainer({
    super.key,
    required this.time,
    required this.title,
    required this.cost,
  });
  final String title, time;
  final double cost;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Color.fromARGB(146, 0, 76, 255)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: GoogleFonts.raleway(fontSize: 16)),
            // SizedBox(width: 20),
            Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Color(0xffF5F8FF),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                '$time days',
                style: GoogleFonts.raleway(fontSize: 13, color: Colors.blue),
              ),
            ),
            Text(
              "Rs ${cost.toStringAsFixed(0)}",
              style: GoogleFonts.raleway(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
