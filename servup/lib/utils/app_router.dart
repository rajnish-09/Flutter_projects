import 'package:go_router/go_router.dart';
import 'package:servup/screens/auth/login_screen.dart';
import 'package:servup/screens/auth/signup_screen.dart';
import 'package:servup/screens/user/book_now_screen.dart';
import 'package:servup/screens/user/favorites_screen.dart';
import 'package:servup/screens/user/home_screen.dart';
import 'package:servup/screens/user/main_wrapper.dart';
import 'package:servup/screens/user/service_listing_screen.dart';
import 'package:servup/screens/user/user_profile_screen.dart';

import 'package:servup/screens/provider/provider_dashboard_screen.dart';
import 'package:servup/screens/provider/provider_booking_history_screen.dart';
import 'package:servup/screens/categories/all_categories_screen.dart';

class AppRouter {
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String favorites = '/favorites';
  static const String bookings = '/bookings';
  static const String profile = '/profile';
  static const String providerDashboard = '/provider-dashboard';
  static const String providerBookingHistory = '/provider-booking-history';
  static const String allCategories = '/all-categories';

  GoRouter router = GoRouter(
    initialLocation: signup,
    routes: [
      GoRoute(path: login, builder: (context, state) => const LoginScreen()),
      GoRoute(path: signup, builder: (context, state) => const SignupScreen()),
      GoRoute(
        path: providerDashboard,
        builder: (context, state) => const ProviderDashboardScreen(),
      ),
      GoRoute(
        path: providerBookingHistory,
        builder: (context, state) => const ProviderBookingHistoryScreen(),
      ),
      GoRoute(
        path: allCategories,
        builder: (context, state) => const AllCategoriesScreen(),
      ),
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
      GoRoute(
        path: '/service-listing',
        builder: (context, state) {
          final category = state.extra as String;
          return ServiceListingScreen(category: category);
        },
      ),

      GoRoute(
        path: '/all-categories',
        builder: (context, state) => const AllCategoriesScreen(),
      ),
    ],
  );
}
