import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ecommerce_app/screens/user_module/cart_screen.dart';
import 'package:ecommerce_app/screens/user_module/profile_screen.dart';
import 'package:ecommerce_app/screens/user_module/shop_screen.dart';
import 'package:ecommerce_app/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class MainNavigationScreen extends StatefulWidget {
  final int? currentIndex;
  const MainNavigationScreen({super.key, this.currentIndex});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.currentIndex ?? 0;
  }

  final pages = [
    ShopScreen(),
    Center(child: Text("Favorites")),
    CartScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final items = [
      Icon(Icons.home),
      Icon(Icons.favorite),
      Icon(Icons.shopping_cart_sharp),
      Icon(Icons.person),
    ];
    return Scaffold(
      extendBody: true,
      body: pages[currentIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(
          context,
        ).copyWith(iconTheme: IconThemeData(color: Colors.white)),
        child: CurvedNavigationBar(
          index: currentIndex,
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
      ),
    );
  }
}

// Theme(
//       data: Theme.of(
//         context,
//       ).copyWith(iconTheme: IconThemeData(color: Colors.white)),
//       child: CurvedNavigationBar(
//         index: currentIndex,
//         items: items,
//         color: Colors.blue,
//         backgroundColor: Colors.transparent,
//         onTap: onTap,
//         animationCurve: Curves.easeInOut,
//         animationDuration: Duration(milliseconds: 300),
//       ),
//     )
