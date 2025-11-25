import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/widgets/background_screen.dart';
import 'package:task_manager_app/ui/widgets/custom_text_field.dart';
import 'package:task_manager_app/ui/widgets/my_app_bar.dart';
import 'package:task_manager_app/ui/widgets/my_filled_button.dart';

import '../../widgets/photo_picker.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName = '/profile-screen';

  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(tappable: false),
      body: BackgroundScreen(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 80),
              Text(
                "Update Profile",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 10),
              Text("Please fill the form to continue"),
              GestureDetector(onTap: _onTapPhotoPicker, child: PhotoPicker()),
              CustomTextField(hintText: "Email"),
              CustomTextField(hintText: "First Name"),
              CustomTextField(hintText: "Last Name"),
              CustomTextField(hintText: "Mobile"),
              CustomTextField(hintText: "Password"),
              SizedBox(height: 10),
              MyFilledButton(onTapFilledButton: _onTapFilledButton),
            ],
          ),
        ),
      ),
    );
  }
  void _onTapPhotoPicker() {}
  void _onTapFilledButton() {}
}
