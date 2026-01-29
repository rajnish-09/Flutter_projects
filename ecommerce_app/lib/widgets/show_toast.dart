import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToastWidget(String msg, Color color) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.TOP, // You can put it at the TOP to ensure it's seen
    backgroundColor: color,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
