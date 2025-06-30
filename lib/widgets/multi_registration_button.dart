import 'package:fluffychat/config/multi_sys_variables/multi_colors.dart';
import 'package:flutter/material.dart';

class MultiRegistrationButton extends StatelessWidget {
  final String label;
  final MultiRegistrationButtonType type;
  final VoidCallback? onPressed;
  final bool? isDisabled;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool? isLoading;

  const MultiRegistrationButton({
    super.key,
    required this.label,
    required this.type,
    this.onPressed,
    this.isDisabled,
    this.backgroundColor,
    this.foregroundColor,
    this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      enableFeedback: (isDisabled == true || isLoading == true) ? false : true,
      onTap: (isDisabled == true || isLoading == true) ? null : onPressed,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor ?? getBackgroundColor(context),
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        width: double.infinity,
        height: 48,
        child: isLoading == true
            ? CircularProgressIndicator(
                color: Theme.of(context).brightness == Brightness.light
                    ? MultiLightColors.textMainTertiaryDisabled
                    : MultiDarkColors.textMainTertiaryDisabled,
              )
            : Text(
                label,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 17,
                      height: 1.29,
                      color: foregroundColor ?? getForegroundColor(context),
                    ),
              ),
      ),
    );
  }

  Color? getBackgroundColor(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    switch (type) {
      case MultiRegistrationButtonType.mainSecondaryDefault:
        return brightness == Brightness.light
            ? MultiLightColors.buttonsMainSecondaryDefault
            : MultiDarkColors.buttonsMainSecondaryDefault;
      case MultiRegistrationButtonType.mainSecondaryDisabled:
        return brightness == Brightness.light
            ? MultiLightColors.buttonsMainSecondaryDisabled
            : MultiDarkColors.buttonsMainSecondaryDisabled;
      case MultiRegistrationButtonType.mainPrimaryDefault:
        return brightness == Brightness.light
            ? MultiLightColors.buttonsMainPrimaryDefault
            : MultiDarkColors.buttonsMainPrimaryDefault;
      case MultiRegistrationButtonType.mainSecondary15Opacity:
        return brightness == Brightness.light
            ? MultiLightColors.buttonsMainSecondary15Opasity
            : MultiDarkColors.buttonsMainSecondary15Opasity;
      case MultiRegistrationButtonType.mainError:
        return brightness == Brightness.light
            ? MultiLightColors.buttonsMainSecondaryDefault
            : MultiDarkColors.buttonsMainSecondaryDefault;
    }
  }

  Color? getForegroundColor(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    switch (type) {
      case MultiRegistrationButtonType.mainSecondaryDefault:
        return brightness == Brightness.light
            ? MultiLightColors.textMainPrimaryDefault
            : MultiDarkColors.textMainPrimaryDefault;
      case MultiRegistrationButtonType.mainSecondaryDisabled:
        return brightness == Brightness.light
            ? MultiLightColors.textMainTertiaryDisabled
            : MultiDarkColors.textMainTertiaryDisabled;
      case MultiRegistrationButtonType.mainPrimaryDefault:
        return brightness == Brightness.light
            ? MultiLightColors.textReversedPrimary
            : MultiDarkColors.textReversedPrimary;
      case MultiRegistrationButtonType.mainSecondary15Opacity:
        return brightness == Brightness.light
            ? MultiLightColors.textReversedPrimary
            : MultiDarkColors.textReversedPrimary;
      case MultiRegistrationButtonType.mainError:
        return brightness == Brightness.light
            ? MultiLightColors.textMainError
            : MultiDarkColors.textMainError;
    }
  }
}

enum MultiRegistrationButtonType {
  mainPrimaryDefault,
  mainSecondary15Opacity,
  mainSecondaryDefault,
  mainSecondaryDisabled,
  mainError,
}
