import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whatsapp_clone/bloc/auth/auth_bloc.dart';
import 'package:whatsapp_clone/bloc/auth/auth_state.dart';
import 'package:whatsapp_clone/bloc/chat/chat_bloc.dart';
import 'package:whatsapp_clone/bloc/group/group_bloc.dart';
import 'package:whatsapp_clone/bloc/message/message_bloc.dart';
import 'package:whatsapp_clone/bloc/profile/profile_bloc.dart';
import 'package:whatsapp_clone/bloc/users/user_bloc.dart';
import 'package:whatsapp_clone/screens/auth_module/auth_gate.dart';
import 'package:whatsapp_clone/screens/auth_module/login_screen.dart';
import 'package:whatsapp_clone/screens/auth_module/signup_screen.dart';
import 'package:whatsapp_clone/screens/user_module/chat_detail_screen.dart';
import 'package:whatsapp_clone/services/firebase_service.dart';
import 'package:whatsapp_clone/services/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  NotificationService().initNotification();
  runApp(MyApp());
}

class DefaultFirebaseOptions {}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc(FirebaseService())),
        BlocProvider(create: (_) => MessageBloc(FirebaseService())),
        BlocProvider(create: (_) => UserBloc(FirebaseService())),
        BlocProvider(create: (_) => ChatBloc(FirebaseService())),
        BlocProvider(create: (_) => ProfileBloc(FirebaseService())),
        BlocProvider(create: (_) => GroupBloc(FirebaseService())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthGate(),
        theme: ThemeData(textTheme: GoogleFonts.nunitoSansTextTheme()),
      ),
    );
  }
}
