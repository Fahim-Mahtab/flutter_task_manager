import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/screens/sign_up_screen.dart';
import 'package:task_manager_app/ui/widgets/background_screen.dart';
import 'package:task_manager_app/ui/widgets/custom_text_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});
  static const String routeName = 'sign-in';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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
                "Get Started With",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 20),
              CustomTextField(hintText: "Email"),
              CustomTextField(hintText: "Password"),
              SizedBox(height: 20),
              FilledButton(
                onPressed: _onTapSignInButton,
                child: Icon(Icons.arrow_circle_right_outlined, size: 25),
              ),
              SizedBox(height: 50),
              Center(
                child: Column(
                  children: [
                    TextButton(
                      onPressed: _onTapForgetPasswordButton,
                      child: Text("Forget Password ?"),
                    ),
                    RichText(
                      text: TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = _onTapDontHaveAccountButton,
                        text: "Don't have an account ? ",
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = _onTapSignUpButton,
                            text: "Sign Up",
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
  void _onTapSignUpButton() {
    Navigator.pushNamed(context, SignUpScreen.routeName);
  }

  void _onTapForgetPasswordButton() {}
  void _onTapDontHaveAccountButton() {}
}
