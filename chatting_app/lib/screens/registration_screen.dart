import 'package:chatting_app/widgets.dart/custom_app_bar.dart';
import 'package:chatting_app/widgets.dart/input_field.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              SizedBox(height: 30),
              Text(
                "Register",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                "You and your friends always connected",
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(height: 30),
              InputField(
                controller: nameController,
                prefixIcon: Icons.person,
                hintText: 'Name',
              ),
              SizedBox(height: 20),
              InputField(
                controller: emailController,
                prefixIcon: Icons.email,
                hintText: 'Email',
              ),
              SizedBox(height: 20),

              InputField(
                controller: passwordController,
                prefixIcon: Icons.password,
                hintText: 'Password',
              ),
              SizedBox(height: 20),

              InputField(
                controller: confirmPasswordController,
                prefixIcon: Icons.password,
                hintText: 'Re-type password',
              ),
              SizedBox(height: 10),
              ElevatedButton(onPressed: () {}, child: Text("Register")),
            ],
          ),
        ),
      ),
    );
  }
}
