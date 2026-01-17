// import 'package:chat_app/ui/otp_screen.dart';
import 'package:chat_app/bloc/auth/auth_service.dart';
import 'package:chat_app/utils/showSnackBar.dart';
import 'package:chat_app/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phoneController = TextEditingController();

  AuthService authService = AuthService();
  String phoneNumber = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Spacer(),
              Text(
                'Enter your phone number',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),
              Text(
                'Please confirm your country code and enter \nyour phone number',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(height: 20),
              IntlPhoneField(
                controller: phoneController,
                initialCountryCode: 'NP',
                onChanged: (phone) {
                  phoneNumber = phone.completeNumber;
                },
              ),

              SizedBox(height: 50),
              SubmitButton(
                buttonText: 'Send otp',
                onPressed: () {
                  if (phoneNumber.isEmpty) {
                    showSnackBar(context, 'Enter a valid phone number');
                  } else {
                    authService.registerNewUser(context, phoneNumber);
                  }
                },
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  OutlineInputBorder inputTextFormFieldStyle() {
    return OutlineInputBorder(borderSide: BorderSide(style: BorderStyle.none));
  }
}
