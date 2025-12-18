
import 'package:flutter/material.dart';
class DataDisplayCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  const DataDisplayCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white),
            SizedBox(height: 5),
            Text(value, style: TextStyle(fontSize: 15, color: Colors.white)),
            SizedBox(height: 5),
            Text(label, style: TextStyle(fontSize: 12, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
