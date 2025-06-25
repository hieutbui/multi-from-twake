import 'package:fluffychat/pages/registration_notification/registration_notification_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegistrationNotification extends StatefulWidget {
  // Store user info from previous steps
  final Map<String, dynamic> userInfo;

  const RegistrationNotification({super.key, required this.userInfo});

  @override
  State<RegistrationNotification> createState() =>
      RegistrationNotificationController();
}

class RegistrationNotificationController
    extends State<RegistrationNotification> {
  // User info
  late final String firstName;
  late final String lastName;
  late final String username;
  late final bool allowContacts;

  // Retrieved from RegistrationWithEmail page and stored across the flow
  // This would need to be securely passed between screens
  late final String email;
  late final String password;

  // UI state
  bool enableNotifications = true;
  bool isLoading = false;
  String? errorMessage;
  @override
  void initState() {
    super.initState();

    // Extract user data from previous steps
    firstName = widget.userInfo['firstName'] as String? ?? '';
    lastName = widget.userInfo['lastName'] as String? ?? '';
    username = widget.userInfo['username'] as String? ?? '';
    allowContacts = widget.userInfo['allowContacts'] as bool? ?? true;

    // Get stored email/password - in a real app these would be securely passed between screens
    // For now, we're assuming these are part of the userInfo map passed from previous screens
    email = widget.userInfo['email'] as String? ?? '';
    password = widget.userInfo['password'] as String? ?? '';
  }

  @override
  void dispose() {
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

  void turnOnNotifications() {
    // Start registration process
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    // Check if we have all required information
    if (email.isEmpty || password.isEmpty || username.isEmpty) {
      setState(() {
        isLoading = false;
        errorMessage = 'Missing required registration information';
      });
      return;
    }
  }

  void onTapSignUp() {
    context.push('/home/multiRegistration');
  }

  void onTapForgotPassword() {
    //TODO: Implement onTapForgotPassword
  }

  @override
  Widget build(BuildContext context) =>
      RegistrationNotificationView(controller: this);
}
