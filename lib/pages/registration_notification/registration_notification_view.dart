import 'package:fluffychat/pages/registration_notification/registration_notification.dart';
import 'package:fluffychat/resource/image_paths.dart';
import 'package:fluffychat/widgets/app_bars/registration_app_bar.dart';
import 'package:fluffychat/widgets/multi_registration_button.dart';
import 'package:flutter/material.dart';

class RegistrationNotificationView extends StatelessWidget {
  final RegistrationNotificationController controller;

  const RegistrationNotificationView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.50, -0.00),
          end: Alignment(0.50, 1.00),
          colors: [Color(0xFF0E0F13), Color(0xFF191B26)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const RegistrationAppBar(
          rightButtonText: 'Logout',
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'Don’t miss a beat',
                    maxLines: null,
                    softWrap: true,
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          color: Colors.white.withAlpha(222),
                          fontSize: 34,
                        ),
                  ),
                ),
                const SizedBox(height: 12.0),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Keep up with updates and chats from your friends and contacts',
                    style: TextStyle(
                      color:
                          Colors.white.withAlpha(153) /* Text-Main-Secondary */,
                      fontSize: 17,
                      fontFamily: 'SF Pro',
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.41,
                    ),
                  ),
                ),
                const SizedBox(height: 90.0),
                Center(child: Image.asset(ImagePaths.imgNotificationRequest)),
                const SizedBox(height: 44.0),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: MultiRegistrationButton(
                    label: 'Turn on notifications',
                    type: MultiRegistrationButtonType.mainPrimaryDefault,
                  ),
                ),
                const SizedBox(height: 12.0),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: MultiRegistrationButton(
                    label: 'Not right now',
                    type: MultiRegistrationButtonType.mainSecondaryDefault,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
