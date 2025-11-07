import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/screens/pin_verification_screen.dart';
import 'package:task_manager_app/ui/screens/sign_in_screen.dart';
import 'package:task_manager_app/ui/widgets/background_screen.dart';
import 'package:task_manager_app/ui/widgets/custom_text_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});
  static const String routeName = '/forgot-password';

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
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
                "Your Email Address",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                "A 6 digit verification pin will send to your \nemail address",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(height: 10),
              CustomTextField(hintText: "Email"),
              SizedBox(height: 8),
              FilledButton(
                onPressed: _onTapFilledButton,
                child: Icon(Icons.arrow_circle_right_outlined, size: 25),
              ),
              SizedBox(height: 50),
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
    Navigator.pushNamed(context, PinVerificationScreen.routeName);
  }
  void _onTapSignInButton() {
    Navigator.pushNamed(context, SignInScreen.routeName);
  }
}
