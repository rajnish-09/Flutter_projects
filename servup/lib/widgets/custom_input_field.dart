import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  const CustomInputField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.validate,
    this.textCapitalization,
    this.textInputType,
    this.obscureText,
  });

  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validate;
  final TextCapitalization? textCapitalization;
  final TextInputType? textInputType;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xffF1F3FD),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        hintText: hintText,
        hintStyle: TextStyle(color: const Color.fromARGB(255, 124, 124, 124)),
      ),
      keyboardType: textInputType ?? TextInputType.name,
      autovalidateMode: AutovalidateMode.onUserInteractionIfError,
      validator: validate,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      obscureText: obscureText ?? false,
    );
  }
}
