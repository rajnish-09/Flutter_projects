import 'package:flutter/material.dart';
import 'package:servup/widgets/custom_input_field.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Center(
                  child: const Text(
                    "Create Your Account",
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                ),
                Center(
                  child: const Text(
                    "Welcome. Let's get you started",
                    style: TextStyle(
                      color: Color.fromARGB(255, 129, 129, 129),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text("Full Name"),
                const SizedBox(height: 5),
                CustomInputField(
                  controller: nameController,
                  hintText: 'Ram Shrestha',
                ),
                const SizedBox(height: 10),
                const Text("Email"),
                const SizedBox(height: 5),
                CustomInputField(
                  controller: emailController,
                  hintText: 'ram123@gmail.com',
                ),
                const SizedBox(height: 10),
                const Text("Phone"),
                const SizedBox(height: 5),
                CustomInputField(
                  controller: nameController,
                  hintText: '9800000000',
                ),
                const SizedBox(height: 10),
                const Text("Password"),
                const SizedBox(height: 5),
                CustomInputField(
                  controller: nameController,
                  hintText: '**********',
                ),
                const SizedBox(height: 10),
                const Text("Confirm Password"),
                const SizedBox(height: 5),
                CustomInputField(
                  controller: nameController,
                  hintText: '**********',
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff005CAB),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: Text("Login", style: TextStyle(color: Colors.white)),
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: Text(
                    "OR",
                    style: TextStyle(
                      color: const Color.fromARGB(255, 151, 151, 151),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    label: Text(
                      "Google",
                      style: TextStyle(color: Colors.black),
                    ),
                    icon: Icon(Icons.g_mobiledata),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
