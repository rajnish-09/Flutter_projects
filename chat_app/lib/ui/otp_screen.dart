import 'package:chat_app/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;
  const OtpScreen({super.key, required this.verificationId});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final phoneController = TextEditingController();

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
                initialCountryCode: 'NP',
                onChanged: (phone) {
                  // print(phone.completeNumber); // +977XXXXXXXX
                },
              ),

              SizedBox(height: 50),
              SubmitButton(buttonText: 'Continue', onPressed: () {}),
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
