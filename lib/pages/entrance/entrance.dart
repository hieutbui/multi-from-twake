import 'package:fluffychat/pages/entrance/entrance_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:fluffychat/di/global/get_it_initializer.dart';
import 'package:fluffychat/utils/responsive/responsive_utils.dart';

class Entrance extends StatefulWidget {
  const Entrance({super.key});

  @override
  State<Entrance> createState() => EntranceController();
}

class EntranceController extends State<Entrance> {
  final responsive = getIt.get<ResponsiveUtils>();

  double get sizeScreenHeight => responsive.getSizeScreenHeight(context);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onContinueWithApple() {
    // TODO: Implement Apple Sign In
    context.push('/home');
  }

  void onContinueWithEmail() {
    // Navigate to email signup/login
    context.go('/home/emailRegistration');
  }

  void onContinueWithGoogle() {
    // TODO: Implement Google Sign In
    context.push('/home');
  }

  void onLogin() {
    // Navigate to login screen
    context.push('/home/login');
  }

  @override
  Widget build(BuildContext context) => EntranceMainView(controller: this);
}
