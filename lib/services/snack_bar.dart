import 'package:flutter/material.dart';

class SnackBarService {
  static const errorColor = Colors.red;
  static const okColor = Colors.green;
  static String msg = '';

  static Future<void> showSnackBar(
      BuildContext context, String? message, bool error) async {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();

    if (message != null) {msg = message;}

    final snackBar = SnackBar(
      content: Text(msg),
      backgroundColor: error ? errorColor : okColor,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}