import 'package:fluffychat/pages/entrance/entrance.dart';
import 'package:fluffychat/pages/entrance/entrance_view_style.dart';
import 'package:fluffychat/resource/image_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:auth_buttons/auth_buttons.dart'
    show AppleAuthButton, EmailAuthButton, GoogleAuthButton, AuthButtonStyle;

class EntranceMainView extends StatelessWidget {
  final EntranceController controller;

  const EntranceMainView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImagePaths.splashBackgrounDDark),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top),
          Column(
            children: [
              SizedBox(
                height: controller.sizeScreenHeight * 0.09,
              ),
              SvgPicture.asset(ImagePaths.multiWordLogo),
              const SizedBox(height: EntranceViewStyle.shortSpacing),
              SvgPicture.asset(ImagePaths.multiSlogan),
              const SizedBox(height: EntranceViewStyle.mediumSpacing),
              Image.asset(ImagePaths.multiAvatars),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).padding.top),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EntranceViewStyle.padding,
              decoration: EntranceViewStyle.backgroundDecoration,
              child: Padding(
                padding: EntranceViewStyle.logoPadding,
                child: Column(
                  children: [
                    Text(
                      'Welcome to Multi',
                      style: EntranceViewStyle().welcomeTextStyle(context),
                    ),
                    const SizedBox(height: EntranceViewStyle.shortSpacing),
                    Text(
                      'Sign up to unlock your AI-powered space — secure, personal, and always with you.',
                      textAlign: TextAlign.center,
                      style: EntranceViewStyle().subtitleTextStyle(context),
                    ),
                    SizedBox(height: controller.sizeScreenHeight * 0.05),
                    AppleAuthButton(
                      onPressed: controller.onContinueWithApple,
                      text: 'Continue with Apple',
                      style: AuthButtonStyle(
                        buttonColor: const Color(
                          0xFFEAECF5,
                        ) /* Buttons-Main-Primary-Default */,
                        iconSize: 18,
                        iconColor: Colors.black.withAlpha(222),
                        height: 48,
                        width: double.infinity,
                        textStyle: EntranceViewStyle().buttonTextStyle(context),
                      ),
                    ),
                    const SizedBox(height: EntranceViewStyle.shortSpacing),
                    EmailAuthButton(
                      onPressed: controller.onContinueWithEmail,
                      text: 'Continue with Email',
                      style: AuthButtonStyle(
                        buttonColor: const Color(
                          0x26EAECF5,
                        ) /* Buttons-Main-Secondary-Default */,
                        iconColor: Colors.white.withAlpha(222),
                        iconSize: 18,
                        height: 48,
                        width: double.infinity,
                        textStyle:
                            EntranceViewStyle().buttonGreyTextStyle(context),
                      ),
                    ),
                    const SizedBox(height: EntranceViewStyle.shortSpacing),
                    GoogleAuthButton(
                      onPressed: controller.onContinueWithGoogle,
                      text: 'Continue with Google',
                      style: AuthButtonStyle(
                        buttonColor: const Color(
                          0x26EAECF5,
                        ) /* Buttons-Main-Secondary-Default */,
                        iconSize: 18,
                        iconColor: Colors.white.withAlpha(222),
                        height: 48,
                        width: double.infinity,
                        textStyle:
                            EntranceViewStyle().buttonGreyTextStyle(context),
                      ),
                    ),
                    const SizedBox(height: EntranceViewStyle.shortSpacing),
                    Padding(
                      padding: EntranceViewStyle.logoPadding,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Already have an account?',
                            style: EntranceViewStyle()
                                .haveAccountTextStyle(context),
                          ),
                          TextButton(
                            onPressed: controller.onLogin,
                            child: Text(
                              'Log In',
                              style:
                                  EntranceViewStyle().loginTextStyle(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
