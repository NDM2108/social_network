import 'package:flutter/material.dart';

class AppFunctions {
  static void showError(BuildContext context, String message) {
    final snackBar = SnackBar(
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
