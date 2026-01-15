// import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:task_management/auth/auth_service.dart';
import 'package:task_management/auth/bloc/auth_bloc.dart';
import 'package:task_management/firebase_options.dart';
import 'package:task_management/tasks/bloc/task_bloc.dart';
import 'package:task_management/ui/auth_gate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:bloc/m';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc(AuthService())),
        BlocProvider(create: (_) => TaskBloc()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: AuthGate());
  }
}
