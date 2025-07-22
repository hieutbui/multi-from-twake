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
                color: MultiColors.of(context).textMainTertiaryDisabled,
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
    switch (type) {
      case MultiRegistrationButtonType.mainSecondaryDefault:
        return MultiColors.of(context).buttonsMainSecondaryDefault;
      case MultiRegistrationButtonType.mainSecondaryDisabled:
        return MultiColors.of(context).buttonsMainSecondaryDisabled;
      case MultiRegistrationButtonType.mainPrimaryDefault:
        return MultiColors.of(context).buttonsMainPrimaryDefault;
      case MultiRegistrationButtonType.mainSecondary15Opacity:
        return MultiColors.of(context).buttonsMainSecondary15Opasity;
      case MultiRegistrationButtonType.mainError:
        return MultiColors.of(context).buttonsMainSecondaryDefault;
    }
  }

  Color? getForegroundColor(BuildContext context) {
    switch (type) {
      case MultiRegistrationButtonType.mainSecondaryDefault:
        return MultiColors.of(context).textMainPrimaryDefault;
      case MultiRegistrationButtonType.mainSecondaryDisabled:
        return MultiColors.of(context).textMainTertiaryDisabled;
      case MultiRegistrationButtonType.mainPrimaryDefault:
        return MultiColors.of(context).textReversedPrimary;
      case MultiRegistrationButtonType.mainSecondary15Opacity:
        return MultiColors.of(context).textReversedPrimary;
      case MultiRegistrationButtonType.mainError:
        return MultiColors.of(context).textMainError;
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
