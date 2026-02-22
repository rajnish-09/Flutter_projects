import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/bloc/auth/auth_bloc.dart';
import 'package:whatsapp_clone/bloc/auth/auth_event.dart';
import 'package:whatsapp_clone/bloc/auth/auth_state.dart';
import 'package:whatsapp_clone/screens/auth_module/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthLogoutSuccess) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            }
          },
          child: ElevatedButton(
            onPressed: () {
              context.read<AuthBloc>().add(LogoutEvent());
            },
            child: Text("Logout"),
          ),
        ),
      ),
    );
  }
}
