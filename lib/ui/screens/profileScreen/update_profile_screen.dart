import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager_app/data/models/user_model.dart';
import 'package:task_manager_app/data/service/network_caller.dart';
import 'package:task_manager_app/data/utils/urls.dart';
import 'package:task_manager_app/ui/controller/auth_controller.dart';
import 'package:task_manager_app/ui/widgets/background_screen.dart';
import 'package:task_manager_app/ui/widgets/custom_text_field.dart';
import 'package:task_manager_app/ui/widgets/my_app_bar.dart';
import 'package:task_manager_app/ui/widgets/my_filled_button.dart';
import 'package:task_manager_app/ui/widgets/snack_bar_msg.dart';

import '../../widgets/photo_picker.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = '/profile-screen';

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ImagePicker _imagePicker = ImagePicker();

  XFile? _selectedImage;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final userData = AuthController.user;
    if (userData != null) {
      _emailTEController.text = userData.email;
      _firstNameTEController.text = userData.firstName;
      _lastNameTEController.text = userData.lastName;
      _mobileTEController.text = userData.mobile;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(tappable: false),
      body: BackgroundScreen(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Form(
              key: _formKey,
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
                  GestureDetector(
                    onTap: _onTapPhotoPicker,
                    child: PhotoPicker(pickedImage: _selectedImage),
                  ),
                  CustomTextField(
                    hintText: "Email",
                    controller: _emailTEController,
                    readOnly: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  CustomTextField(
                    hintText: "First Name",
                    controller: _firstNameTEController,
                  ),
                  CustomTextField(
                    hintText: "Last Name",
                    controller: _lastNameTEController,
                  ),
                  CustomTextField(
                    hintText: "Mobile",
                    keyboardType: TextInputType.phone,
                    controller: _mobileTEController,
                  ),
                  CustomTextField(
                    hintText: "Password",
                    controller: _passwordTEController,
                    obscureText: true,
                    maxLine: 1,
                  ),
                  SizedBox(height: 10),
                  Visibility(
                    visible: !_isLoading,
                    replacement: Center(child: CircularProgressIndicator()),
                    child: MyFilledButton(
                      onTapFilledButton: _onTapUpdateProfileButton,
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

  Future<void> _updateProfile() async {
    _isLoading = true;
    setState(() {});
    Map<String, String> requestBody = {
      "email": _emailTEController.text,
      "firstName": _firstNameTEController.text,
      "lastName": _lastNameTEController.text,
      "mobile": _mobileTEController.text,
      "password": _passwordTEController.text,
      //"photo": _selectedImage!.path,
    };
    if (_passwordTEController.text.isNotEmpty) {
      requestBody["password"] = _passwordTEController.text;
    }
    if (_selectedImage != null) {
      Uint8List imageBytes = await _selectedImage!.readAsBytes();
      requestBody["photo"] = base64Encode(imageBytes);
    }
    final NetworkResponse response = await NetworkCaller.postRequest(
      Urls.updateProfileUrl,
      body: requestBody,
    );
    _isLoading = false;
    if (response.isSuccess) {

      setState(() {});
      await AuthController.updateUserData(UserModel.fromJson((requestBody)));
      showSnackBar(context, "Profile Updated");
    } else {
      showSnackBar(context, response.errorMessage);
    }
  }

  Future<void> _onTapPhotoPicker() async {
    final XFile? image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (image != null) {
      _selectedImage = image;
      setState(() {});
    }
  }

  void _onTapUpdateProfileButton() async {
    if (_formKey.currentState!.validate()) {
      _updateProfile();
    }
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
