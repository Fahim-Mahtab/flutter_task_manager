import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/screens/sign_in_screen.dart';
import 'package:task_manager_app/ui/widgets/background_screen.dart';
import 'package:task_manager_app/ui/widgets/custom_text_field.dart';

class SetForgetPasswordScreen extends StatefulWidget {
  const SetForgetPasswordScreen({super.key});
  static const String routeName = "/set-forget-password";

  @override
  State<SetForgetPasswordScreen> createState() =>
      _SetForgetPasswordScreenState();
}

class _SetForgetPasswordScreenState extends State<SetForgetPasswordScreen> {
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
                "Set Password",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                "Minimum length password 8 characters with \nLetter and number combination",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(height: 10),
              CustomTextField(hintText: "Password", obscureText: true),
              CustomTextField(hintText: "Confirm Password", obscureText: true),
              SizedBox(height: 20),
              FilledButton(
                onPressed: _onTapFilledButton,
                child: Text(
                  "Confirm",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              SizedBox(height: 30),
              Center(
                child: Column(
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "Have an account ? ",
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

  void _onTapFilledButton() {

  }

  void _onTapSignInButton() {
    Navigator.pushNamed(context, SignInScreen.routeName);
  }
}
