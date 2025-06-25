import 'package:fluffychat/pages/registration_name/registration_name_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegistrationName extends StatefulWidget {
  const RegistrationName({super.key});

  @override
  State<RegistrationName> createState() => RegistrationNameController();
}

class RegistrationNameController extends State<RegistrationName> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  final FocusNode firstNameFocusNode = FocusNode();
  final FocusNode lastNameFocusNode = FocusNode();

  // UI state
  bool isLoading = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    // Default values can be removed for production
    firstNameController.text = '';
    lastNameController.text = '';
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    firstNameFocusNode.dispose();
    lastNameFocusNode.dispose();
    firstNameFocusNode.removeListener(() {});
    lastNameFocusNode.removeListener(() {});
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
    final firstName = firstNameController.text.trim();
    final lastName = lastNameController.text.trim();

    if (firstName.isEmpty) {
      setState(() {
        errorMessage = 'First name is required';
      });
      return;
    }

    if (lastName.isEmpty) {
      setState(() {
        errorMessage = 'Last name is required';
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
      extra: {'firstName': firstName, 'lastName': lastName},
    );
  }

  void onTapSignUp() {
    context.push('/home/multiRegistration');
  }

  void onTapForgotPassword() {
    //TODO: Implement onTapForgotPassword
  }

  void handleFirstNameInput(String value) {
    setState(() {
      errorMessage = null; // Clear error when user starts typing
    });
    // Auto-focus on last name field if first name is complete
    if (value.isNotEmpty && value.length > 2) {
      lastNameFocusNode.requestFocus();
    }
  }

  void handleLastNameInput(String value) {
    setState(() {
      errorMessage = null; // Clear error when user starts typing
    });
  }

  @override
  Widget build(BuildContext context) => RegistrationNameView(controller: this);
}
