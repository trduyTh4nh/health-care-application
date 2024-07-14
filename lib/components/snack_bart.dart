import 'package:flutter/material.dart';

void showCustomSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Text(message),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
