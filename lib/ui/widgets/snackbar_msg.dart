import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message) {
  // build context is used to show snack bar on screen and
  // string is used to show message on snack bar screen
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}
