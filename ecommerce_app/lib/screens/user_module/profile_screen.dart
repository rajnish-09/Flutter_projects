import 'package:ecommerce_app/bloc/auth/auth_bloc.dart';
import 'package:ecommerce_app/bloc/auth/auth_event.dart';
import 'package:ecommerce_app/bloc/auth/auth_state.dart';
import 'package:ecommerce_app/bloc/user/user_bloc.dart';
import 'package:ecommerce_app/bloc/user/user_event.dart';
import 'package:ecommerce_app/bloc/user/user_state.dart';
import 'package:ecommerce_app/screens/login_screen.dart';
import 'package:ecommerce_app/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(GetUser());
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController provinceController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController streetController = TextEditingController();

    bool _initialized = false;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is LogoutSuccess) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            }
          },
        ),
        BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserLoaded) {
              _initialized = true;
              nameController.text = state.userData.name;
              emailController.text = state.userData.email;
              phoneController.text = state.userData.phone;
              countryController.text = state.userData.country ?? '';
              provinceController.text = state.userData.province ?? '';
              cityController.text = state.userData.city ?? '';
              streetController.text = state.userData.street ?? '';
            }
          },
        ),
      ],
      child: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserLoaded) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Center(
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: AssetImage(
                            'assets/images/prod1.jpg',
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
                      Text(
                        "Personal details",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 15),
                      ProfileTextField(
                        controller: nameController,
                        label: 'Name',
                      ),
                      SizedBox(height: 15),
                      ProfileTextField(
                        controller: emailController,
                        label: 'Email',
                      ),
                      SizedBox(height: 15),
                      ProfileTextField(
                        controller: phoneController,
                        label: 'Phone',
                      ),
                      SizedBox(height: 30),
                      Text(
                        "Address details",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 15),
                      ProfileTextField(
                        controller: countryController,
                        label: 'Country',
                      ),
                      SizedBox(height: 15),
                      ProfileTextField(
                        controller: provinceController,
                        label: 'Province',
                      ),
                      SizedBox(height: 15),
                      ProfileTextField(
                        controller: cityController,
                        label: 'City',
                      ),
                      SizedBox(height: 15),
                      ProfileTextField(
                        controller: streetController,
                        label: 'Street',
                      ),
                      SizedBox(height: 30),
                      SubmitButton(buttonText: 'Save', onPressed: () {}),
                      SizedBox(height: 30),
                      SubmitButton(
                        buttonText: 'Logout',
                        onPressed: () {
                          context.read<AuthBloc>().add(LogoutEvent());
                        },
                        backgroundColor: Color(0xffF83758),
                      ),
                    ],
                  );
                }
                return SizedBox();
              },
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileTextField extends StatelessWidget {
  const ProfileTextField({
    super.key,
    required this.controller,
    required this.label,
  });

  final TextEditingController controller;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          SizedBox(height: 10),
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              filled: true,
              fillColor: Colors.transparent,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.transparent),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
