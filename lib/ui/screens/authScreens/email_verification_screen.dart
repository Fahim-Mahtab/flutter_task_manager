import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/screens/authScreens/pin_verification_screen.dart';
import 'package:task_manager_app/ui/screens/authScreens/sign_in_screen.dart';
import 'package:task_manager_app/ui/widgets/background_screen.dart';
import 'package:task_manager_app/ui/widgets/custom_text_field.dart';

import 'package:task_manager_app/data/service/network_caller.dart';
import 'package:task_manager_app/data/utils/urls.dart';
import '../../widgets/my_filled_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  static const String routeName = '/forgot-password';

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  bool _inProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundScreen(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
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
                CustomTextField(
                  controller: _emailController,
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return "Enter a valid email";
                    }
                    if (EmailValidator.validate(value!) == false) {
                      return "Enter a valid email";
                    }
                    return null;
                  },
                  hintText: "Email",
                ),
                SizedBox(height: 8),
                Visibility(
                  visible: _inProgress == false,
                  replacement: Center(child: CircularProgressIndicator()),
                  child: MyFilledButton(
                    onTapFilledButton: _onTapConfirmEmailButton,
                  ),
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
      ),
    );
  }

  void _onTapConfirmEmailButton() {
    if (_formKey.currentState!.validate()) {
      _verifyEmail();
    }
  }

  Future<void> _verifyEmail() async {
    _inProgress = true;
    setState(() {});
    NetworkResponse response = await NetworkCaller.getRequest(
      Urls.recoveryVerifyEmail(_emailController.text.trim()),
    );
    _inProgress = false;
    setState(() {});
    if (response.isSuccess) {
      Navigator.pushNamed(
        context,
        PinVerificationScreen.routeName,
        arguments: _emailController.text.trim(),
      );
    } else {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(response.errorMessage)));
      }
    }
  }

  void _onTapSignInButton() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      SignInScreen.routeName,
      (route) => false,
    );
  }
}
