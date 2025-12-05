import 'package:flutter/material.dart';
import "package:flutter_svg/flutter_svg.dart";
import 'package:task_manager_app/ui/screens/authScreens/sign_in_screen.dart';
import 'package:task_manager_app/ui/utils/assets_path.dart';
import 'package:task_manager_app/ui/widgets/background_screen.dart';

import '../controller/auth_controller.dart';
import 'main_bottom_nav_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _moveToNextScreen();
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    bool isUserAlreadyLoggedIn = await AuthController.isUserAlreadyLoggedIn();

    if (!mounted) return;

    if (isUserAlreadyLoggedIn) {
      await AuthController.getUserData();

      if (!mounted) return;

      if (AuthController.user != null) {
        if (!mounted) return;
        Navigator.pushReplacementNamed(context, MainBottomNavBar.routeName);
        return;
      }
    }
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, SignInScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundScreen(
        child: Center(child: SvgPicture.asset(AssetPaths.logo)),
      ),
    );
  }
}
