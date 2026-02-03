import 'package:flutter/material.dart';

void showSnackBar({
  required BuildContext context,
  required String msg,
  required Color backgroundColor,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(msg), backgroundColor: backgroundColor),
  );
}
