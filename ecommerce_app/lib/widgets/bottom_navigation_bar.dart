import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  final items = [
    Icon(Icons.home),
    Icon(Icons.favorite),
    Icon(Icons.shopping_cart_sharp),
    Icon(Icons.person),
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(
        context,
      ).copyWith(iconTheme: IconThemeData(color: Colors.white)),
      child: CurvedNavigationBar(
        // index: currentIndex,
        items: items,
        color: Colors.blue,
        backgroundColor: Colors.transparent,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 300),
      ),
    );
  }
}
