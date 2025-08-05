import 'package:fluffychat/resource/image_paths.dart';
import 'package:fluffychat/widgets/app_bars/registration_app_bar.dart';
import 'package:fluffychat/widgets/multi_registration_button.dart';
import 'package:flutter/material.dart';

class RequestNotificationPage extends StatelessWidget {
  final void Function()? onTapEnableNotification;
  final void Function()? onTapNotRightNow;
  final void Function()? onBackButtonPressed;

  const RequestNotificationPage({
    super.key,
    this.onTapEnableNotification,
    this.onTapNotRightNow,
    this.onBackButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF0E0F13), Color(0xFF191B26)],
        ),
      ),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: RegistrationAppBar(
          rightButtonText: 'Logout',
          onBackButtonPressed: onBackButtonPressed,
        ),
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 100.0),
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
                    fontFamily: 'SFPro',
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.41,
                  ),
                ),
              ),
              const SizedBox(height: 90.0),
              Center(child: Image.asset(ImagePaths.imgNotificationRequest)),
              const SizedBox(height: 44.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: MultiRegistrationButton(
                  label: 'Turn on notifications',
                  type: MultiRegistrationButtonType.mainPrimaryDefault,
                  onPressed: onTapEnableNotification,
                ),
              ),
              const SizedBox(height: 12.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: MultiRegistrationButton(
                  label: 'Not right now',
                  type: MultiRegistrationButtonType.mainSecondaryDefault,
                  onPressed: onTapNotRightNow,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
