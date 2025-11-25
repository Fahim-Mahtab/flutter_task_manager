import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_manager_app/data/service/network_caller.dart';
import 'package:task_manager_app/ui/widgets/background_screen.dart';
import 'package:task_manager_app/ui/widgets/custom_text_field.dart';
import 'package:task_manager_app/ui/widgets/snackbar_msg.dart';

import '../../../data/utils/urls.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const String routeName = "/sign_up";

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _signUpLoader = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundScreen(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Visibility(
            visible: !_signUpLoader,
            replacement: Center(child: CircularProgressIndicator()),

            ///replacement is used to show loader when api is calling
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 100),
                  Text(
                    "Join With Us",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  CustomTextField(
                    controller: _emailController,
                    hintText: "Email",
                    keyboardType: TextInputType.emailAddress,
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
                    controller: _firstNameController,
                    hintText: "First Name",
                    keyboardType: TextInputType.text,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
                    ],
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Enter a valid name";
                      }
                      return null;
                    },
                  ),
                  CustomTextField(
                    controller: _lastNameController,
                    hintText: "Last Name",
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Enter a valid name";
                      }
                      return null;
                    },
                  ),
                  CustomTextField(
                    controller: _mobileController,
                    hintText: "Mobile",
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value != null &&
                          value.isNotEmpty &&
                          !RegExp(r'^[0-9]+$').hasMatch(value)) {
                        return "Only digits allowed";
                      }
                      return null;
                    },
                    /* inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),

                      ///prevents words to be entered
                    ],*/
                    maxLength: 11,
                  ),
                  CustomTextField(
                    controller: _passwordController,
                    hintText: "Password",
                    obscureText: true,
                    maxLine: 1,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "Enter your password correctly";
                      }
                      if (value.length < 7) {
                        return "Enter password not more than 7";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  FilledButton(
                    onPressed: _onTapSignUpButton,
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
        ),
      ),
    );
  }

  void _onTapSignUpButton() {
    if (_formKey.currentState!.validate()) {
      ///Api calling here
      _signup();
    }
  }

  Future<void> _signup() async {
    // this function is used to call api and handle response and show snack bar message accordingly
    _signUpLoader = true;
    setState(
      () {},
    ); // setState() is used to update the state of the widget to get the loader to show
    Map<String, dynamic> requestBody = {
      "email": _emailController.text.trim(),

      ///these are my response which will be send to api as post request
      "firstName": _firstNameController.text.trim(),
      "lastName": _lastNameController.text.trim(),
      "mobile": _mobileController.text.trim(),
      "password": _passwordController.text,
    };
    NetworkResponse response = await NetworkCaller.postRequest(
      Urls.registrationUrl,
      body: requestBody,
    );
    if (response.isSuccess) {
      showSnackBar(context, "Registration Successful");
      _signUpLoader = false;
    } else {
      showSnackBar(context, response.errorMessage);
    }
  }

  void _onTapSignInButton() {
    Navigator.pop(context);
  }
}
