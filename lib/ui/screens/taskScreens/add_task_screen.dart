import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/widgets/background_screen.dart';
import 'package:task_manager_app/ui/widgets/my_app_bar.dart';
import 'package:task_manager_app/ui/widgets/my_filled_button.dart';

import '../../widgets/custom_text_field.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});
  static const String routeName = '/add-new-task';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: BackgroundScreen(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 100),
              Text(
                "Add New Task",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 16),
              CustomTextField(hintText: 'Subject'),
              SizedBox(height: 10),
              CustomTextField(hintText: 'Description', maxLine: 10),
              SizedBox(height: 20),
              MyFilledButton(onTapFilledButton: _onTapFilledButton),
            ],
          ),
        ),
      ),
    );
  }
}

void _onTapFilledButton() {}
