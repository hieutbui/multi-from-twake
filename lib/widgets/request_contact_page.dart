import 'package:fluffychat/config/multi_sys_variables/multi_typography.dart';
import 'package:fluffychat/resource/image_paths.dart';
import 'package:fluffychat/widgets/app_bars/registration_app_bar.dart';
import 'package:fluffychat/widgets/multi_registration_button.dart';
import 'package:flutter/material.dart';

class RequestContactPage extends StatelessWidget {
  final void Function()? onTapEnableContact;
  final void Function()? onTapNotRightNow;
  final void Function()? onBackButtonPressed;

  const RequestContactPage({
    super.key,
    this.onTapEnableContact,
    this.onTapNotRightNow,
    this.onBackButtonPressed,
  });

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
        appBar: RegistrationAppBar(
          rightButtonText: 'Logout',
          onBackButtonPressed: onBackButtonPressed,
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
                    'Find your contacts',
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
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      fontSize: 17,
                      fontFamily: MultiFonts.sfPro,
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.41,
                    ),
                  ),
                ),
                const SizedBox(height: 90.0),
                Center(child: Image.asset(ImagePaths.imgRegistrationContacts)),
                const SizedBox(height: 44.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: MultiRegistrationButton(
                    label: 'Enable access',
                    type: MultiRegistrationButtonType.mainPrimaryDefault,
                    onPressed: onTapEnableContact,
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
      ),
    );
  }
}
