import 'package:flutter/material.dart';

class InputTextFormFIeld extends StatelessWidget {
  final IconData? icon;
  final String hintText;
  final String? Function(String?)? validator;
  final VoidCallback? onChanged;
  final bool? obscureText;
  final int maxLines;
  const InputTextFormFIeld({
    super.key,
    required this.controller,
    this.icon,
    required this.hintText,
    this.validator,
    this.onChanged,
    this.obscureText,
    this.maxLines = 1
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(117, 0, 0, 0),
            offset: Offset(-4, 4),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: TextFormField(
        // textCapitalization: TextCapitalization.sentences,
        maxLines: maxLines,
        validator: validator,
        controller: controller,
        obscureText: obscureText != null ? obscureText! : false,
        // onChanged: ,
        decoration: InputDecoration(
          prefixIcon: icon != null ? Icon(icon, color: Colors.grey) : null,
          hintText: hintText,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          filled: true,
          fillColor: const Color.fromRGBO(255, 255, 255, 1),
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
    );
  }
}
