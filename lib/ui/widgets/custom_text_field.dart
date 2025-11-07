import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
    this.inputFormatters,
    this.maxLength

  });
  final String? Function(String?)? validator;
  final String hintText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey),
      ),
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      inputFormatters: inputFormatters,
      maxLength: maxLength,
      /*validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },*/
    );
  }
}
