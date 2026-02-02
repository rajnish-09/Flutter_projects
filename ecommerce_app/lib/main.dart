import 'package:ecommerce_app/bloc/auth/auth_bloc.dart';
import 'package:ecommerce_app/bloc/cart/cart_bloc.dart';
import 'package:ecommerce_app/bloc/category/category_bloc.dart';
import 'package:ecommerce_app/bloc/order/order_bloc.dart';
import 'package:ecommerce_app/bloc/product/product_bloc.dart';
import 'package:ecommerce_app/bloc/uploadImage/upload_bloc.dart';
import 'package:ecommerce_app/firebase_options.dart';
import 'package:ecommerce_app/screens/admin_module/add_product_screen.dart';
import 'package:ecommerce_app/screens/admin_module/admin_dashboard.dart';
import 'package:ecommerce_app/screens/get_started_screen.dart';
import 'package:ecommerce_app/screens/login_screen.dart';
import 'package:ecommerce_app/screens/user_module/main_navigation_screen.dart';
import 'package:ecommerce_app/screens/user_module/product_display_screen.dart';
import 'package:ecommerce_app/screens/user_module/shop_screen.dart';
import 'package:ecommerce_app/screens/signup_screen.dart';
import 'package:ecommerce_app/service/firebase_service.dart';
import 'package:ecommerce_app/service/image_service.dart';
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
      providers: [
        BlocProvider(create: (_) => CategoryBloc(FirebaseService())),
        BlocProvider(create: (_) => UploadBloc(ImageService())),
        BlocProvider(create: (_) => ProductBloc()),
        BlocProvider(create: (_) => CartBloc()),
        BlocProvider(create: (_) => OrderBloc()),
        BlocProvider(create: (_) => AuthBloc()),
      ],
      child: MaterialApp(
        theme: ThemeData(textTheme: GoogleFonts.nunitoSansTextTheme()),
        home: LoginScreen(),
      ),
    );
  }
}
