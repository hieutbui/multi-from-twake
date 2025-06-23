import 'package:fluffychat/pages/registration_name/registration_name_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegistrationName extends StatefulWidget {
  const RegistrationName({super.key});

  @override
  State<RegistrationName> createState() => RegistrationNameController();
}

class RegistrationNameController extends State<RegistrationName> {
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = 'John';
  }

  @override
  void dispose() {
    nameController.dispose();
    nameController.removeListener(() {});
    super.dispose();
  }

  void onTapRule() {
    // TODO: Implement onTapRule
  }

  void onContinueWithApple() {
    // TODO: Implement onContinueWithApple
  }

  void onContinueWithGoogle() {
    // TODO: Implement onContinueWithGoogle
  }

  void onTapCreateAccount() {
    //TODO: Implement onTapCreateAccount
  }

  void onTapSignUp() {
    context.push('/home/multiRegistration');
  }

  void onTapForgotPassword() {
    //TODO: Implement onTapForgotPassword
  }

  void handleNameInput(String value) {
    // Add name validation and storage here
  }

  @override
  Widget build(BuildContext context) => RegistrationNameView(controller: this);
}
