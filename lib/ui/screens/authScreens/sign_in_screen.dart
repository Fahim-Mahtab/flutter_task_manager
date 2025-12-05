import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app/data/models/user_model.dart';
import 'package:task_manager_app/ui/controller/auth_controller.dart';
import 'package:task_manager_app/ui/screens/authScreens/email_verification_screen.dart';
import 'package:task_manager_app/ui/screens/authScreens/sign_up_screen.dart';
import 'package:task_manager_app/ui/widgets/background_screen.dart';
import 'package:task_manager_app/ui/widgets/custom_text_field.dart';
import '../../../data/service/network_caller.dart';
import '../../../data/utils/urls.dart';
import '../../widgets/snackbar_msg.dart';
import '../main_bottom_nav_bar.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const String routeName = 'sign-in';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _signInLoader = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundScreen(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Form(
            key: _formKey,
            child: Column(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 100),
                Text(
                  "Get Started With",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                CustomTextField(
                  hintText: "Email",
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
                ),
                CustomTextField(
                  controller: _passwordController,
                  hintText: "Password",
                  obscureText: true,
                  maxLine: 1,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return "Password field cant be empty";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Visibility(
                  visible: _signInLoader == false,
                  replacement: Center(child: CircularProgressIndicator()),
                  child: FilledButton(
                    onPressed: _onTapSignInButton,
                    child: Icon(Icons.arrow_circle_right_outlined, size: 25),
                  ),
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
      ),
    );
  }

  void _onTapSignInButton() {
    if (_formKey.currentState!.validate()) {
      _signIn();
    }
  }

  Future<void> _signIn() async {
    _signInLoader = true;
    setState(() {});
    try {
      Map<String, dynamic> requestBody = {
        "email": _emailController.text.trim(),
        "password": _passwordController.text,
      };
      NetworkResponse response = await NetworkCaller.postRequest(
        Urls.loginUrl,
        body: requestBody,
      );
      if (response.isSuccess) {
        UserModel userModel = UserModel.fromJson(response.body["data"]);
        String accessToken = response.body["token"];
        await AuthController.saveUserData(accessToken, userModel);
        if (mounted) {
          setState(() {
            _signInLoader = false;
            _clearTextFields();
          });
          showSnackBar(context, "Login  Successful");
          Navigator.pushNamedAndRemoveUntil(
            context,
            MainBottomNavBar.routeName,
            (route) => false,
          );
        }
      } else {
        if (mounted) {
          setState(() {
            _signInLoader = false;
          });
          showSnackBar(context, response.errorMessage);
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _signInLoader = false;
        });
      }
    }
  }

  void _onTapSignUpButton() {
    Navigator.pushNamed(context, SignUpScreen.routeName);
  }

  @override
  void dispose() {
    //dispose to save memory and make the app faster
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _clearTextFields() {
    _emailController.clear();

    _passwordController.clear();
  }

  void _onTapForgetPasswordButton() {
    Navigator.pushNamed(context, ForgotPasswordScreen.routeName);
  }
}
