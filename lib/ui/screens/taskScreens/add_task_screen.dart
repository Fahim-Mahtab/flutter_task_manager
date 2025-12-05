import 'package:flutter/material.dart';
import 'package:task_manager_app/data/service/network_caller.dart';
import 'package:task_manager_app/data/utils/urls.dart';
import 'package:task_manager_app/ui/widgets/background_screen.dart';
import 'package:task_manager_app/ui/widgets/my_app_bar.dart';
import 'package:task_manager_app/ui/widgets/my_filled_button.dart';
import 'package:task_manager_app/ui/widgets/snackbar_msg.dart';

import '../../../data/models/user_model.dart';
import '../../controller/auth_controller.dart';
import '../../widgets/custom_text_field.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  static const String routeName = '/add-new-task';

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: BackgroundScreen(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 100),
                Text(
                  "Add New Task",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 16),
                CustomTextField(
                  controller: _subjectController,
                  hintText: 'Subject',
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a subject';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 10),
                CustomTextField(
                  controller: _descriptionController,
                  hintText: 'Description',
                  maxLine: 10,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Description";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20),
                Visibility(
                  visible: _isSubmitting == false,
                  replacement: CircularProgressIndicator(),
                  child: MyFilledButton(onTapFilledButton: _onTapSubmitButton),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onSubmit() async {
    _isSubmitting == true;
    setState(() {});
    Map<String, dynamic> requestBody = {
      "title": _subjectController.text,
      "description": _descriptionController.text,
      "status": "New",
    };
    NetworkResponse response = await NetworkCaller.postRequest(
      Urls.createTask,
      body: requestBody,
    );
    if (response.isSuccess) {
      _isSubmitting = false;
      _clearTextFields();
      showSnackBar(context, "New Task Added");
    } else {
      showSnackBar(context, response.errorMessage);
    }
  }

  void _clearTextFields() {
    _subjectController.clear();
    _descriptionController.clear();
  }

  void _onTapSubmitButton() {
    if (_formKey.currentState!.validate()) {
      _onSubmit();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.clear();
    _subjectController.clear();
  }
}
