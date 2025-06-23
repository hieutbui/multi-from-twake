import 'package:fluffychat/pages/registration_notification/registration_notification_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegistrationNotification extends StatefulWidget {
  const RegistrationNotification({super.key});

  @override
  State<RegistrationNotification> createState() =>
      RegistrationNotificationController();
}

class RegistrationNotificationController
    extends State<RegistrationNotification> {
  @override
  void initState() {
    super.initState();
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

  void onTapCreateAccount() {
    //TODO: Implement onTapCreateAccount
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
