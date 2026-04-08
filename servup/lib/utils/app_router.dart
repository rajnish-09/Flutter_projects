import 'package:go_router/go_router.dart';
import 'package:servup/screens/user/book_now_screen.dart';
import 'package:servup/screens/user/favorites_screen.dart';
import 'package:servup/screens/user/home_screen.dart';
import 'package:servup/screens/user/main_wrapper.dart';
import 'package:servup/screens/user/user_profile_screen.dart';

class AppRouter {
  static const String home = '/';
  static const String favorites = '/favorites';
  static const String bookings = '/bookings';
  static const String profile = '/profile';

  GoRouter router = GoRouter(
    initialLocation: home,
    routes: [
      ShellRoute(
        builder: (context, state, child) => MainWrapper(child: child),
        routes: [
          GoRoute(
            name: 'home',
            path: home,
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            name: 'favorites',
            path: favorites,
            builder: (context, state) => const FavoritesScreen(),
          ),
          GoRoute(
            name: 'bookings',
            path: bookings,
            builder: (context, state) => const BookNowScreen(),
          ),
          GoRoute(
            name: 'profile',
            path: profile,
            builder: (context, state) => const UserProfileScreen(),
          ),
        ],
      ),
    ],
  );
}
