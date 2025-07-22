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
      : primary = const MultiLightColors().textMainAccent,
        onPrimary = const MultiLightColors().backgroundSurfacesDefault,
        primaryContainer = const MultiLightColors().supportiveColorsBlueMain,
        onPrimaryContainer = const MultiLightColors().textMainPrimaryDefault,
        inversePrimary = const MultiLightColors().textReversedAccent,
        secondary = const MultiLightColors().buttonsMainGhostDefault,
        onSecondary = const MultiLightColors().backgroundSurfacesDefault,
        secondaryContainer = const MultiLightColors().backgroundGroupsDefault,
        onSecondaryContainer = const MultiLightColors().textMainPrimaryDefault,
        tertiary = const MultiLightColors().additionalNeutralGrey,
        onTertiary = const MultiLightColors().backgroundSurfacesDefault,
        tertiaryContainer = const MultiLightColors().supportiveColorsGreyMain,
        onTertiaryContainer = const MultiLightColors().textMainPrimaryDefault,
        error = const MultiLightColors().textMainError,
        onError = const MultiLightColors().backgroundSurfacesDefault,
        errorContainer = const MultiLightColors().supportiveColorsRedMain,
        onErrorContainer = const MultiLightColors().supportiveColorsRedContrast,
        background = const MultiLightColors().backgroundPageDefault,
        onBackground = const MultiLightColors().textMainPrimaryDefault,
        surface = const MultiLightColors().backgroundSurfacesDefault,
        onSurface = const MultiLightColors().textMainPrimaryDefault,
        surfaceTint = const MultiLightColors().backgroundSurfacesHovered,
        surfaceVariant = const MultiLightColors().backgroundGroupsDefault,
        onSurfaceVariant = const MultiLightColors().textMainSecondary,
        inverseSurface = const MultiLightColors().backgroundSecondary,
        onInverseSurface = const MultiLightColors().textReversedSecondary,
        shadow = const MultiLightColors().additionalBlackout,
        outline = const MultiLightColors().bordersMainDefault,
        _primaryDark = const MultiDarkColors().textMainAccent,
        _onPrimaryDark = const MultiDarkColors().backgroundSurfacesDefault,
        _primaryContainerDark =
            const MultiDarkColors().backgroundSurfacesActive,
        _onPrimaryContainerDark =
            const MultiDarkColors().textMainPrimaryDefault,
        _inversePrimaryDark = const MultiDarkColors().textReversedAccent,
        _secondaryDark = const MultiDarkColors().buttonsMainGhostDefault,
        _onSecondaryDark = const MultiDarkColors().backgroundSurfacesDefault,
        _secondaryContainerDark =
            const MultiDarkColors().backgroundSurfacesHovered,
        _onSecondaryContainerDark =
            const MultiDarkColors().textMainPrimaryDefault,
        _tertiaryDark = const MultiDarkColors().textMainSecondary,
        _onTertiaryDark = const MultiDarkColors().backgroundSurfacesDefault,
        _tertiaryContainerDark =
            const MultiDarkColors().backgroundSurfacesTransparent,
        _onTertiaryContainerDark =
            const MultiDarkColors().textMainPrimaryDefault,
        _errorDark = const MultiDarkColors().textMainError,
        _onErrorDark = const MultiDarkColors().backgroundSurfacesDefault,
        _errorContainerDark = const MultiDarkColors().bordersErrorDefault,
        _onErrorContainerDark = const MultiDarkColors().textMainError,
        _backgroundDark = const MultiDarkColors().backgroundPageDefault,
        _onBackgroundDark = const MultiDarkColors().textMainPrimaryDefault,
        _surfaceDark = const MultiDarkColors().backgroundSurfacesDefault,
        _onSurfaceDark = const MultiDarkColors().textMainPrimaryDefault,
        _surfaceTintDark = const MultiDarkColors().backgroundSurfacesHovered,
        _surfaceVariantDark = const MultiDarkColors().backgroundSurfacesActive,
        _onSurfaceVariantDark = const MultiDarkColors().textMainSecondary,
        _inverseSurfaceDark = const MultiDarkColors().backgroundSurfacesDefault,
        _onInverseSurfaceDark = const MultiDarkColors().textReversedPrimary,
        _shadowDark = const MultiDarkColors().additionalBlackout,
        _outlineDark = const MultiDarkColors().bordersMainDefault;
}
