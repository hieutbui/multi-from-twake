import 'package:fluffychat/pages/registration_name/registration_name_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegistrationName extends StatefulWidget {
  const RegistrationName({super.key});

  @override
  State<RegistrationName> createState() => RegistrationNameController();
}

class RegistrationNameController extends State<RegistrationName> {
  final TextEditingController nameController = TextEditingController();

  final FocusNode nameFocusNode = FocusNode();

  // UI state
  bool isLoading = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    // Default values can be removed for production
    nameController.text = '';
  }

  @override
  void dispose() {
    nameController.dispose();
    nameFocusNode.dispose();
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
    final name = nameController.text.trim();

    if (name.isEmpty) {
      setState(() {
        errorMessage = 'Name is required';
      });
      return;
    }

    setState(() {
      errorMessage = null;
    });

    // Navigate to next page, passing the name data for later use in signup
    context.push(
      '/home/registrationContacts',
      // We should pass both names for the final registration step
      extra: {'name': name},
    );
  }

  void handleNameInput(String value) {
    setState(() {
      errorMessage = null; // Clear error when user starts typing
    });
    // Auto-focus on last name field if first name is complete
    if (value.isNotEmpty && value.length > 2) {
      nameFocusNode.requestFocus();
    }
  }

  void onTapSignUp() {
    context.push('/home/multiRegistration');
  }

  void onTapForgotPassword() {
    //TODO: Implement onTapForgotPassword
  }

  @override
  Widget build(BuildContext context) => RegistrationNameView(controller: this);
}
