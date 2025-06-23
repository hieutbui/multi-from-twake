import 'package:fluffychat/pages/registration_contacts/registration_contacts_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegistrationContacts extends StatefulWidget {
  const RegistrationContacts({super.key});

  @override
  State<RegistrationContacts> createState() => RegistrationContactsController();
}

class RegistrationContactsController extends State<RegistrationContacts> {
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
      RegistrationContactsView(controller: this);
}
