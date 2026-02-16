import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String msg, Color backgroundColor) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(msg), backgroundColor: backgroundColor),
  );
}
