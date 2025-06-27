import 'package:fluffychat/config/multi_sys_variables/multi_colors.dart';
import 'package:flutter/material.dart';

class MultiSysColors {
  final Color primary;

  final Color? _primaryDark;

  Color get primaryDark => _primaryDark ?? primary;

  final Color onPrimary;

  final Color? _onPrimaryDark;

  Color get onPrimaryDark => _onPrimaryDark ?? onPrimary;

  final Color primaryContainer;

  final Color? _primaryContainerDark;

  Color get primaryContainerDark => _primaryContainerDark ?? primaryContainer;

  final Color onPrimaryContainer;

  final Color? _onPrimaryContainerDark;

  Color get onPrimaryContainerDark =>
      _onPrimaryContainerDark ?? onPrimaryContainer;

  final Color inversePrimary;

  final Color? _inversePrimaryDark;

  Color get inversePrimaryDark => _inversePrimaryDark ?? inversePrimary;

  final Color secondary;

  final Color? _secondaryDark;

  Color get secondaryDark => _secondaryDark ?? secondary;

  final Color onSecondary;

  final Color? _onSecondaryDark;

  Color get onSecondaryDark => _onSecondaryDark ?? onSecondary;

  final Color secondaryContainer;

  final Color? _secondaryContainerDark;

  Color get secondaryContainerDark =>
      _secondaryContainerDark ?? secondaryContainer;

  final Color onSecondaryContainer;

  final Color? _onSecondaryContainerDark;

  Color get onSecondaryContainerDark =>
      _onSecondaryContainerDark ?? onSecondaryContainer;

  final Color tertiary;

  final Color? _tertiaryDark;

  Color get tertiaryDark => _tertiaryDark ?? tertiary;

  final Color onTertiary;

  final Color? _onTertiaryDark;

  Color get onTertiaryDark => _onTertiaryDark ?? onTertiary;

  final Color tertiaryContainer;

  final Color? _tertiaryContainerDark;

  Color get tertiaryContainerDark =>
      _tertiaryContainerDark ?? tertiaryContainer;

  final Color onTertiaryContainer;

  final Color? _onTertiaryContainerDark;

  Color get onTertiaryContainerDark =>
      _onTertiaryContainerDark ?? onTertiaryContainer;

  final Color error;

  final Color? _errorDark;

  Color get errorDark => _errorDark ?? error;

  final Color onError;

  final Color? _onErrorDark;

  Color get onErrorDark => _onErrorDark ?? onError;

  final Color errorContainer;

  final Color? _errorContainerDark;

  Color get errorContainerDark => _errorContainerDark ?? errorContainer;

  final Color onErrorContainer;

  final Color? _onErrorContainerDark;

  Color get onErrorContainerDark => _onErrorContainerDark ?? onErrorContainer;

  final Color background;

  final Color? _backgroundDark;

  Color get backgroundDark => _backgroundDark ?? background;

  final Color onBackground;

  final Color? _onBackgroundDark;

  Color get onBackgroundDark => _onBackgroundDark ?? onBackground;

  final Color surface;

  final Color? _surfaceDark;

  Color get surfaceDark => _surfaceDark ?? surface;

  final Color onSurface;

  final Color? _onSurfaceDark;

  Color get onSurfaceDark => _onSurfaceDark ?? onSurface;

  final Color surfaceVariant;

  final Color? _surfaceVariantDark;

  Color get surfaceVariantDark => _surfaceVariantDark ?? surfaceVariant;

  final Color onSurfaceVariant;

  final Color? _onSurfaceVariantDark;

  Color get onSurfaceVariantDark => _onSurfaceVariantDark ?? onSurfaceVariant;

  final Color inverseSurface;

  final Color? _inverseSurfaceDark;

  Color get inverseSurfaceDark => _inverseSurfaceDark ?? inverseSurface;

  final Color onInverseSurface;

  final Color? _onInverseSurfaceDark;

  Color get onInverseSurfaceDark => _onInverseSurfaceDark ?? onInverseSurface;

  final Color shadow;

  final Color? _shadowDark;

  Color get shadowDark => _shadowDark ?? shadow;

  final Color surfaceTint;

  final Color? _surfaceTintDark;

  Color get surfaceTintDark => _surfaceTintDark ?? surfaceTint;

  final Color outline;

  final Color? _outlineDark;

  Color get outlineDark => _outlineDark ?? outline;

  MultiSysColors({
    required this.primary,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.inversePrimary,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.tertiary,
    required this.onTertiary,
    required this.tertiaryContainer,
    required this.onTertiaryContainer,
    required this.error,
    required this.onError,
    required this.errorContainer,
    required this.onErrorContainer,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
    required this.inverseSurface,
    required this.onInverseSurface,
    required this.shadow,
    required this.surfaceTint,
    required this.surfaceVariant,
    required this.onSurfaceVariant,
    required this.outline,
    primaryDark,
    onPrimaryDark,
    primaryContainerDark,
    onPrimaryContainerDark,
    inversePrimaryDark,
    secondaryDark,
    onSecondaryDark,
    secondaryContainerDark,
    onSecondaryContainerDark,
    tertiaryDark,
    onTertiaryDark,
    tertiaryContainerDark,
    onTertiaryContainerDark,
    errorDark,
    onErrorDark,
    errorContainerDark,
    onErrorContainerDark,
    backgroundDark,
    onBackgroundDark,
    surfaceDark,
    onSurfaceDark,
    inverseSurfaceDark,
    onInverseSurfaceDark,
    shadowDark,
    surfaceTintDark,
    surfaceVariantDark,
    onSurfaceVariantDark,
    outlineDark,
  })  : _primaryDark = primaryDark,
        _onPrimaryDark = onPrimaryDark,
        _primaryContainerDark = primaryContainerDark,
        _onPrimaryContainerDark = onPrimaryContainerDark,
        _inversePrimaryDark = inversePrimaryDark,
        _secondaryDark = secondaryDark,
        _onSecondaryDark = onSecondaryDark,
        _secondaryContainerDark = secondaryContainerDark,
        _onSecondaryContainerDark = onSecondaryContainerDark,
        _tertiaryDark = tertiaryDark,
        _onTertiaryDark = onTertiaryDark,
        _tertiaryContainerDark = tertiaryContainerDark,
        _onTertiaryContainerDark = onTertiaryContainerDark,
        _errorDark = errorDark,
        _onErrorDark = onErrorDark,
        _errorContainerDark = errorContainerDark,
        _onErrorContainerDark = onErrorContainerDark,
        _backgroundDark = backgroundDark,
        _onBackgroundDark = onBackgroundDark,
        _surfaceDark = surfaceDark,
        _onSurfaceDark = onSurfaceDark,
        _inverseSurfaceDark = inverseSurfaceDark,
        _onInverseSurfaceDark = onInverseSurfaceDark,
        _shadowDark = shadowDark,
        _surfaceTintDark = surfaceTintDark,
        _surfaceVariantDark = surfaceVariantDark,
        _onSurfaceVariantDark = onSurfaceVariantDark,
        _outlineDark = outlineDark;

  static final MultiSysColors _materialMultiSysColors =
      MultiSysColors._material();

  factory MultiSysColors.material() {
    return _materialMultiSysColors;
  }

  MultiSysColors._material()
      : primary = MultiLightColors.textMainAccent,
        onPrimary = MultiLightColors.backgroundSurfacesDefault,
        primaryContainer = MultiLightColors.supportiveColorsBlueMain,
        onPrimaryContainer = MultiLightColors.textMainPrimaryDefault,
        inversePrimary = MultiLightColors.textReversedAccent,
        secondary = MultiLightColors.buttonsMainGhostDefault,
        onSecondary = MultiLightColors.backgroundSurfacesDefault,
        secondaryContainer = MultiLightColors.backgroundGroupsDefault,
        onSecondaryContainer = MultiLightColors.textMainPrimaryDefault,
        tertiary = MultiLightColors.additionalNeutralGrey,
        onTertiary = MultiLightColors.backgroundSurfacesDefault,
        tertiaryContainer = MultiLightColors.supportiveColorsGreyMain,
        onTertiaryContainer = MultiLightColors.textMainPrimaryDefault,
        error = MultiLightColors.textMainError,
        onError = MultiLightColors.backgroundSurfacesDefault,
        errorContainer = MultiLightColors.supportiveColorsRedMain,
        onErrorContainer = MultiLightColors.supportiveColorsRedContrast,
        background = MultiLightColors.backgroundPageDefault,
        onBackground = MultiLightColors.textMainPrimaryDefault,
        surface = MultiLightColors.backgroundSurfacesDefault,
        onSurface = MultiLightColors.textMainPrimaryDefault,
        surfaceTint = MultiLightColors.backgroundSurfacesHovered,
        surfaceVariant = MultiLightColors.backgroundGroupsDefault,
        onSurfaceVariant = MultiLightColors.textMainSecondary,
        inverseSurface = MultiLightColors.backgroundSecondary,
        onInverseSurface = MultiLightColors.textReversedSecondary,
        shadow = MultiLightColors.additionalBlackout,
        outline = MultiLightColors.bordersMainDefault,
        _primaryDark = MultiDarkColors.textMainAccent,
        _onPrimaryDark = MultiDarkColors.backgroundSurfacesDefault,
        _primaryContainerDark = MultiDarkColors.backgroundSurfacesActive,
        _onPrimaryContainerDark = MultiDarkColors.textMainPrimaryDefault,
        _inversePrimaryDark = MultiDarkColors.textReversedAccent,
        _secondaryDark = MultiDarkColors.buttonsMainGhostDefault,
        _onSecondaryDark = MultiDarkColors.backgroundSurfacesDefault,
        _secondaryContainerDark = MultiDarkColors.backgroundSurfacesHovered,
        _onSecondaryContainerDark = MultiDarkColors.textMainPrimaryDefault,
        _tertiaryDark = MultiDarkColors.textMainSecondary,
        _onTertiaryDark = MultiDarkColors.backgroundSurfacesDefault,
        _tertiaryContainerDark = MultiDarkColors.backgroundSurfacesTransparent,
        _onTertiaryContainerDark = MultiDarkColors.textMainPrimaryDefault,
        _errorDark = MultiDarkColors.textMainError,
        _onErrorDark = MultiDarkColors.backgroundSurfacesDefault,
        _errorContainerDark = MultiDarkColors.bordersErrorDefault,
        _onErrorContainerDark = MultiDarkColors.textMainError,
        _backgroundDark = MultiDarkColors.backgroundPageDefault,
        _onBackgroundDark = MultiDarkColors.textMainPrimaryDefault,
        _surfaceDark = MultiDarkColors.backgroundSurfacesDefault,
        _onSurfaceDark = MultiDarkColors.textMainPrimaryDefault,
        _surfaceTintDark = MultiDarkColors.backgroundSurfacesHovered,
        _surfaceVariantDark = MultiDarkColors.backgroundSurfacesActive,
        _onSurfaceVariantDark = MultiDarkColors.textMainSecondary,
        _inverseSurfaceDark = MultiDarkColors.backgroundSurfacesDefault,
        _onInverseSurfaceDark = MultiDarkColors.textReversedPrimary,
        _shadowDark = MultiDarkColors.additionalBlackout,
        _outlineDark = MultiDarkColors.bordersMainDefault;
}
