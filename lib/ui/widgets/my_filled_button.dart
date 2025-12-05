import 'package:flutter/material.dart';

class MyFilledButton extends StatelessWidget {
  final VoidCallback onTapFilledButton;


  const MyFilledButton({super.key, required this.onTapFilledButton});

  @override
  Widget build(BuildContext context) {
    return FilledButton(

      onPressed: onTapFilledButton,
      child: Icon(Icons.arrow_circle_right_outlined, size: 25),
    );
  }
}
