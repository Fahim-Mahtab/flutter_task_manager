import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/screens/authScreens/email_verification_screen.dart';
import 'package:task_manager_app/ui/screens/authScreens/pin_verification_screen.dart';
import 'package:task_manager_app/ui/screens/authScreens/set_forget_password_screen.dart';
import 'package:task_manager_app/ui/screens/authScreens/sign_in_screen.dart';
import 'package:task_manager_app/ui/screens/authScreens/sign_up_screen.dart';
import 'package:task_manager_app/ui/screens/main_bottom_nav_bar.dart';
import 'package:task_manager_app/ui/screens/profileScreen/update_profile_screen.dart';
import 'package:task_manager_app/ui/screens/splash_screen.dart';
import 'package:task_manager_app/ui/screens/taskScreens/add_task_screen.dart';

class TaskManagerApp extends StatefulWidget {
  const TaskManagerApp({super.key});

  @override
  State<TaskManagerApp> createState() => _TaskManagerAppState();
}

class _TaskManagerAppState extends State<TaskManagerApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.green,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.green,
            padding: EdgeInsets.symmetric(vertical: 12),
            //  minimumSize: Size(double.infinity, 50),
            fixedSize: Size.fromWidth(double.maxFinite),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
          titleMedium: TextStyle(fontSize: 18, color: Colors.white),
          titleSmall: TextStyle(
            fontSize: 16,
            color: Colors.grey,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      routes: <String, WidgetBuilder>{
        SignInScreen.routeName: (_) => SignInScreen(),
        SignUpScreen.routeName: (_) => SignUpScreen(),
        ForgotPasswordScreen.routeName: (_) => ForgotPasswordScreen(),
        PinVerificationScreen.routeName: (_) => PinVerificationScreen(),
        SetForgetPasswordScreen.routeName: (_) => SetForgetPasswordScreen(),
        MainBottomNavBar.routeName: (_) => MainBottomNavBar(),
        AddTaskScreen.routeName: (_) => AddTaskScreen(),
        ProfileScreen.routeName: (_) => ProfileScreen(),
      //  NewTaskListScreen.routeName : (_) => NewTaskListScreen(),
      },
    );
  }
}
