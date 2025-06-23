import 'package:flutter/material.dart';

class MultiRegistrationButton extends StatelessWidget {
  final String label;
  final MultiRegistrationButtonType type;
  final VoidCallback? onPressed;
  final bool? isDisabled;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const MultiRegistrationButton({
    super.key,
    required this.label,
    required this.type,
    this.onPressed,
    this.isDisabled,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? getBackgroundColor(),
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      width: double.infinity,
      height: 48,
      child: InkWell(
        onTap: isDisabled == true ? null : onPressed,
        child: Text(
          label,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontSize: 17,
                height: 1.29,
                color: foregroundColor ?? getForegroundColor(),
              ),
        ),
      ),
    );
  }

  Color? getBackgroundColor() {
    switch (type) {
      case MultiRegistrationButtonType.mainSecondaryDefault:
        return const Color(0x26EAECF5) /* Buttons-Main-Secondary-Default */;
      case MultiRegistrationButtonType.mainSecondaryDisabled:
        return const Color(0x33EAECF5) /* Buttons-Main-Secondary-Disabled */;
      case MultiRegistrationButtonType.mainPrimaryDefault:
        return const Color(0xFFEAECF5) /* Buttons-Main-Primary-Default */;
      case MultiRegistrationButtonType.mainSecondary15Opacity:
        return const Color(0x26EAECF5) /* Buttons-Main-Secondary-15-Opasity */;
      case MultiRegistrationButtonType.mainError:
        return const Color(0x26EAECF5) /* Buttons-Main-Secondary-Default */;
    }
  }

  Color? getForegroundColor() {
    switch (type) {
      case MultiRegistrationButtonType.mainSecondaryDefault:
        return Colors.white.withAlpha(222) /* Text-Main-Primary_Default */;
      case MultiRegistrationButtonType.mainSecondaryDisabled:
        return Colors.white.withAlpha(97) /* Text-Main-Tertiary_Disabled */;
      case MultiRegistrationButtonType.mainPrimaryDefault:
        return Colors.black.withAlpha(222) /* Text-Reversed-Primary */;
      case MultiRegistrationButtonType.mainSecondary15Opacity:
        return Colors.black.withAlpha(222) /* Text-Reversed-Primary */;
      case MultiRegistrationButtonType.mainError:
        return const Color(0xFFF57F8D) /* Text-Main-Error */;
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
