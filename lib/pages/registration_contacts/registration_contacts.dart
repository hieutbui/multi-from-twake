import 'package:fluffychat/pages/registration_contacts/registration_contacts_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegistrationContacts extends StatefulWidget {
  // Store names from previous page
  final Map<String, String> userInfo;

  const RegistrationContacts({super.key, required this.userInfo});

  @override
  State<RegistrationContacts> createState() => RegistrationContactsController();
}

class RegistrationContactsController extends State<RegistrationContacts> {
  // User info fields
  late final String firstName;
  late final String lastName;
  late final TextEditingController usernameController;

  // UI state
  bool isLoading = false;
  String? errorMessage;
  bool allowContacts = true;
  @override
  void initState() {
    super.initState();
    // Extract name data from widget params
    firstName = widget.userInfo['firstName'] ?? '';
    lastName = widget.userInfo['lastName'] ?? '';

    // Initialize username with a default suggestion based on name
    final suggestedUsername = _generateSuggestedUsername(firstName, lastName);
    usernameController = TextEditingController(text: suggestedUsername);
  }

  // Generate a username suggestion based on first and last name
  String _generateSuggestedUsername(String firstName, String lastName) {
    if (firstName.isEmpty && lastName.isEmpty) return '';

    final firstNameLower = firstName.toLowerCase().replaceAll(' ', '');
    final lastNameLower = lastName.toLowerCase().replaceAll(' ', '');

    if (lastNameLower.isEmpty) return firstNameLower;
    if (firstNameLower.isEmpty) return lastNameLower;

    // Create username like: john.doe
    return '$firstNameLower.$lastNameLower';
  }

  @override
  void dispose() {
    usernameController.dispose();
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
    final username = usernameController.text.trim();

    if (username.isEmpty) {
      setState(() {
        errorMessage = 'Username is required';
      });
      return;
    }

    if (username.length < 3) {
      setState(() {
        errorMessage = 'Username must be at least 3 characters';
      });
      return;
    }

    setState(() {
      errorMessage = null;
      isLoading = false;
    });

    // Navigate to notifications page, passing along all the collected user info
    final userInfo = {
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'allowContacts': allowContacts,
    };

    context.push(
      '/home/registrationNotification',
      extra: userInfo,
    );
  }

  void onTapSignUp() {
    context.push('/home/multiRegistration');
  }

  void onTapForgotPassword() {
    //TODO: Implement onTapForgotPassword
  }

  @override
  Widget build(BuildContext context) =>
      RegistrationContactsView(controller: this);
}
