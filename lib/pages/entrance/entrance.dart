import 'package:fluffychat/pages/entrance/entrance_view.dart';
import 'package:fluffychat/utils/platform_infos.dart';
import 'package:fluffychat/widgets/matrix.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:fluffychat/di/global/get_it_initializer.dart';
import 'package:fluffychat/utils/responsive/responsive_utils.dart';
import 'package:matrix/matrix.dart';

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

  void onContinueWithApple() async {
    // TODO: Implement Apple Sign In
    // context.push('/home');
    final test = await Matrix.of(context).getLoginClient().login(
          LoginType.mLoginPassword,
          user: '@hieubui102:omni',
          password: 'TestPassword123!',
          initialDeviceDisplayName: PlatformInfos.clientName,
        );
    Logs().d('test: $test');
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
    context.push('/home/multiLogin');
  }

  @override
  Widget build(BuildContext context) => EntranceMainView(controller: this);
}
