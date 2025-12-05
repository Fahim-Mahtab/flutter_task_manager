import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager_app/data/service/network_caller.dart';
import 'package:task_manager_app/data/utils/urls.dart';
import 'package:task_manager_app/ui/screens/authScreens/set_forget_password_screen.dart';
import 'package:task_manager_app/ui/screens/authScreens/sign_in_screen.dart';
import 'package:task_manager_app/ui/widgets/background_screen.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({super.key});

  static const String routeName = '/pin-verification';

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  bool _inProgress = false;
  final TextEditingController _pinTEController = TextEditingController();
  static String recoveryVerifyOtp(String email, String otp) {
    return Urls.recoveryVerifyOtpUrl;
  }

  @override
  Widget build(BuildContext context) {
    final String email = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      body: BackgroundScreen(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 100),
              Text(
                "PIN Verification",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 5),
              Text(
                "A 6 digit verification pin was send to your \nemail address",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(height: 10),
              PinCodeTextField(
                controller: _pinTEController,
                backgroundColor: Colors.transparent,
                appContext: context,
                length: 6,
                obscureText: false,
                animationType: AnimationType.fade,
                animationDuration: Duration(milliseconds: 300),
                keyboardType: TextInputType.number,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  activeFillColor: Colors.grey,
                  inactiveFillColor: Colors.grey,
                  selectedColor: Colors.grey,
                ),
              ),
              SizedBox(height: 8),
              Visibility(
                visible: _inProgress == false,
                replacement: Center(child: CircularProgressIndicator()),
                child: FilledButton(
                  onPressed: () {
                    _onTapFilledButton(email);
                  },
                  child: Icon(Icons.arrow_circle_right_outlined, size: 25),
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
    );
  }

  Future<void> _onTapFilledButton(String email) async {
    _inProgress = true;
    setState(() {});
    NetworkResponse response = await NetworkCaller.getRequest(
      recoveryVerifyOtp(email, _pinTEController.text.trim()),
    );
    _inProgress = false;
    setState(() {});
    if (response.isSuccess) {
      Navigator.pushNamed(
        context,
        SetForgetPasswordScreen.routeName,
        arguments: {"email": email, "otp": _pinTEController.text.trim()},
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
    Navigator.pushNamed(context, SignInScreen.routeName);
  }
}
