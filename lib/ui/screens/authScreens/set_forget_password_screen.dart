import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app/data/service/network_caller.dart';
import 'package:task_manager_app/data/utils/urls.dart';
import 'package:task_manager_app/ui/screens/authScreens/sign_in_screen.dart';
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
  bool _inProgress = false;
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _confirmPasswordTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String email = args['email'];
    final String otp = args['otp'];

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
                  "Set Password",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  "Minimum length password 8 characters with \nLetter and number combination",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                SizedBox(height: 10),
                CustomTextField(
                  controller: _passwordTEController,
                  hintText: "Password",
                  obscureText: true,
                  maxLine: 1,
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return "Enter password";
                    }
                    if (value!.length < 8) {
                      return "Password must be at least 8 characters";
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  controller: _confirmPasswordTEController,
                  hintText: "Confirm Password",
                  obscureText: true,
                  maxLine: 1,
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return "Enter confirm password";
                    }
                    if (value != _passwordTEController.text) {
                      return "Passwords do not match";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Visibility(
                  visible: _inProgress == false,
                  replacement: Center(child: CircularProgressIndicator()),
                  child: FilledButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _resetPassword(email, otp);
                      }
                    },
                    child: Text(
                      "Confirm",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
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
      ),
    );
  }

  Future<void> _resetPassword(String email, String otp) async {
    _inProgress = true;
    setState(() {});
    final Map<String, dynamic> body = {
      "email": email,
      "OTP": otp,
      "password": _passwordTEController.text,
    };
    NetworkResponse response = await NetworkCaller.postRequest(
      Urls.recoverResetPasswordUrl,
      body: body,
    );
    _inProgress = false;
    setState(() {});
    if (response.isSuccess) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Password reset successful! Please login.")),
        );
        Navigator.pushNamedAndRemoveUntil(
          context,
          SignInScreen.routeName,
          (route) => false,
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(response.errorMessage)));
      }
    }
  }

  void _onTapSignInButton() {
    Navigator.pushNamed(context, SignInScreen.routeName);
  }
}
