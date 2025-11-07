import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/widgets/background_screen.dart';
import 'package:task_manager_app/ui/widgets/custom_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static const String routeName = "/sign_up";

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundScreen(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 100),
              Text(
                "Join With Us",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 20),
              CustomTextField(hintText: "Email"),
              CustomTextField(hintText: "First Name"),
              CustomTextField(hintText: "Last Name"),
              CustomTextField(hintText: "Mobile"),
              CustomTextField(hintText: "Password"),
              SizedBox(height: 20),
              FilledButton(
                onPressed: _onTapSignInButton,
                child: Icon(Icons.arrow_circle_right_outlined, size: 25),
              ),
              SizedBox(height: 30),
              Center(
                child: Column(
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "Already have an account ? ",
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = _onTapSignInButton,
                            text: "Sign In",
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTapSignInButton() {}
}
