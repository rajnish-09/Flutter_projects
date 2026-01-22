import 'package:ecommerce_app/bloc/category/category_bloc.dart';
import 'package:ecommerce_app/firebase_options.dart';
import 'package:ecommerce_app/screens/admin_module/admin_dashboard.dart';
import 'package:ecommerce_app/screens/get_started_screen.dart';
import 'package:ecommerce_app/screens/login_screen.dart';
import 'package:ecommerce_app/screens/main_navigation_screen.dart';
import 'package:ecommerce_app/screens/product_display_screen.dart';
import 'package:ecommerce_app/screens/shop_screen.dart';
import 'package:ecommerce_app/screens/signup_screen.dart';
import 'package:ecommerce_app/service/firebase_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => CategoryBloc(FirebaseService()))],
      child: MaterialApp(
        theme: ThemeData(textTheme: GoogleFonts.nunitoSansTextTheme()),
        home: AdminDashboard(),
      ),
    );
  }
}
