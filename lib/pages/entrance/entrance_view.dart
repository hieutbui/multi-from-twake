import 'package:fluffychat/pages/entrance/entrance.dart';
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
              const SizedBox(height: 12),
              SvgPicture.asset(ImagePaths.multiSlogan),
              const SizedBox(height: 32),
              Image.asset(ImagePaths.multiAvatars),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).padding.top),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              decoration: const ShapeDecoration(
                color: Color(0xFF171718) /* Background-Page-Default */,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Text(
                      'Welcome to Multi',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            color: Colors.white.withAlpha(222),
                            fontSize: 34,
                            letterSpacing: 0.37,
                          ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Sign up to unlock your AI-powered space — secure, personal, and always with you.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: Colors.white.withAlpha(153),
                            fontSize: 17,
                            letterSpacing: -0.41,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                    SizedBox(height: controller.sizeScreenHeight * 0.05),
                    Column(
                      children: [
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
                            textStyle: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: Colors.black.withAlpha(222),
                                  /* Text-Reversed-Primary */
                                  fontSize: 17,
                                ),
                          ),
                        ),
                        const SizedBox(height: 12),
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
                            textStyle: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: Colors.white.withAlpha(222),
                                  /* Text-Main-Primary_Default */
                                  fontSize: 17,
                                ),
                          ),
                        ),
                        const SizedBox(height: 12),
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
                            textStyle: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: Colors.white.withAlpha(222),
                                  fontSize: 17,
                                ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Already have an account?',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                  color: Colors.white
                                      .withAlpha(153) /* Text-Main-Secondary */,
                                  fontSize: 17,
                                  letterSpacing: -0.41,
                                  fontWeight: FontWeight.w400,
                                ),
                          ),
                          TextButton(
                            onPressed: controller.onLogin,
                            child: Text(
                              'Log In',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color: Colors.white.withAlpha(
                                      222,
                                    ) /* Text-Main-Primary_Default */,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                  ),
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
