import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ecommerce_app/bloc/cart/cart_bloc.dart';
import 'package:ecommerce_app/bloc/cart/cart_event.dart';
import 'package:ecommerce_app/bloc/cart/cart_state.dart';
import 'package:ecommerce_app/bloc/favorite/favorite_bloc.dart';
import 'package:ecommerce_app/bloc/favorite/favorite_event.dart';
import 'package:ecommerce_app/bloc/favorite/favorite_state.dart';
import 'package:ecommerce_app/screens/user_module/cart_screen.dart';
import 'package:ecommerce_app/screens/user_module/favorite_screen.dart';
import 'package:ecommerce_app/screens/user_module/order_history_screen.dart';
import 'package:ecommerce_app/screens/user_module/profile_screen.dart';
import 'package:ecommerce_app/screens/user_module/shop_screen.dart';
import 'package:ecommerce_app/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    context.read<FavoriteBloc>().add(LoadFavorites());
    context.read<CartBloc>().add(FetchCartItems());
  }

  final List<Widget> pages = [
    ShopScreen(),
    FavoriteScreen(),
    CartScreen(),
    OrderHistoryScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(index: currentIndex, children: pages),
      bottomNavigationBar: Theme(
        data: Theme.of(
          context,
        ).copyWith(iconTheme: IconThemeData(color: Colors.white)),
        child: BlocBuilder<FavoriteBloc, FavoriteState>(
          builder: (context, state) {
            int favCount = 0;
            if (state is FavoriteLoaded) {
              favCount = state.favorites.length;
            }
            return BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                int cartCount = 0;

                if (state is CartLoaded) {
                  cartCount = state.cartItems.length;
                }

                final items = [
                  Icon(Icons.home),
                  Badge(
                    label: Text(favCount.toString()),
                    isLabelVisible: favCount > 0,
                    child: Icon(Icons.favorite),
                  ),
                  Badge(
                    label: Text(cartCount.toString()),
                    isLabelVisible: cartCount > 0,
                    child: Icon(Icons.shopping_cart_sharp),
                  ),
                  Icon(Icons.shopping_cart_checkout_rounded),
                  Icon(Icons.person),
                ];
                return CurvedNavigationBar(
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
                );
              },
            );
          },
        ),
      ),
    );
  }
}
