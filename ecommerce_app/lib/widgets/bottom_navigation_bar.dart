import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ecommerce_app/screens/cart_screen.dart';
import 'package:ecommerce_app/screens/shop_screen.dart';
import 'package:flutter/material.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  BottomNavigationBarWidget({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });
  final int currentIndex;
  final ValueChanged<int> onTap;

  final items = [
    Icon(Icons.home),
    Icon(Icons.favorite),
    Icon(Icons.shopping_cart_sharp),
    Icon(Icons.person),
  ];

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(
        context,
      ).copyWith(iconTheme: IconThemeData(color: Colors.white)),
      child: CurvedNavigationBar(
        index: currentIndex,
        items: items,
        color: Colors.blue,
        backgroundColor: Colors.transparent,
        onTap: onTap,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 300),
      ),
    );
  }
}
