import 'package:fluffychat/config/multi_sys_variables/multi_colors.dart';
import 'package:fluffychat/pages/entrance/entrance.dart';
import 'package:fluffychat/pages/entrance/entrance_view_style.dart';
import 'package:fluffychat/resource/image_paths.dart';
import 'package:fluffychat/utils/platform_infos.dart';
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
              decoration: EntranceViewStyle.backgroundDecoration(context),
              child: Padding(
                padding: EntranceViewStyle.logoPadding,
                child: Column(
                  children: [
                    Text(
                      'Welcome to Multi',
                      style:
                          Theme.of(context).textTheme.headlineLarge?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                    ),
                    const SizedBox(height: EntranceViewStyle.shortSpacing),
                    Text(
                      'Sign up to unlock your AI-powered space — secure, personal, and always with you.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                    ),
                    SizedBox(height: controller.sizeScreenHeight * 0.05),
                    if (PlatformInfos.isIOS)
                      AppleAuthButton(
                        onPressed: controller.onContinueWithApple,
                        text: 'Continue with Apple',
                        style: AuthButtonStyle(
                          separator: EntranceViewStyle.oauthButtonSeparator,
                          buttonColor:
                              MultiColors.of(context).buttonsMainPrimaryDefault,
                          borderRadius: 16,
                          iconSize: EntranceViewStyle.oauthButtonIconSize,
                          iconColor:
                              Theme.of(context).colorScheme.onInverseSurface,
                          height: EntranceViewStyle.oauthButtonHeight,
                          width: double.infinity,
                          textStyle:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onInverseSurface,
                                  ),
                        ),
                      ),
                    const SizedBox(height: EntranceViewStyle.shortSpacing),
                    EmailAuthButton(
                      onPressed: controller.onContinueWithEmail,
                      text: 'Continue with Email',
                      style: AuthButtonStyle(
                        separator: EntranceViewStyle.oauthButtonSeparator,
                        buttonColor:
                            MultiColors.of(context).buttonsMainSecondaryDefault,
                        borderRadius: 16,
                        iconColor: Theme.of(context).colorScheme.onSurface,
                        iconSize: EntranceViewStyle.oauthButtonIconSize,
                        height: EntranceViewStyle.oauthButtonHeight,
                        width: double.infinity,
                        textStyle: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                      ),
                    ),
                    const SizedBox(height: EntranceViewStyle.shortSpacing),
                    GoogleAuthButton(
                      onPressed: controller.onContinueWithGoogle,
                      text: 'Continue with Google',
                      style: AuthButtonStyle(
                        separator: EntranceViewStyle.oauthButtonSeparator,
                        buttonColor:
                            MultiColors.of(context).buttonsMainSecondaryDefault,
                        borderRadius: 16,
                        iconSize: EntranceViewStyle.oauthButtonIconSize,
                        iconColor: Theme.of(context).colorScheme.onSurface,
                        height: EntranceViewStyle.oauthButtonHeight,
                        width: double.infinity,
                        textStyle: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                      ),
                    ),
                    const SizedBox(height: EntranceViewStyle.shortSpacing),
                    Padding(
                      padding: EntranceViewStyle.logoPadding,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Already have an account? ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.tertiary,
                                ),
                          ),
                          TextButton(
                            onPressed: controller.onLogin,
                            style: TextButton.styleFrom(
                              minimumSize: Size.zero,
                              padding: EdgeInsets.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              'Log In',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer,
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
