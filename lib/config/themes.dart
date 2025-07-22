import 'package:fluffychat/config/multi_sys_variables/multi_colors.dart';
import 'package:fluffychat/config/multi_sys_variables/multi_sys_colors.dart';
import 'package:fluffychat/config/multi_sys_variables/multi_typography.dart';
import 'package:fluffychat/di/global/get_it_initializer.dart';
import 'package:fluffychat/utils/responsive/responsive_utils.dart';
import 'package:fluffychat/widgets/multi_custom_border_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:linagora_design_flutter/colors/linagora_ref_colors.dart';

import 'app_config.dart';

abstract class TwakeThemes {
  static const double columnWidth = 360.0;
  static const double iconSize = 24.0;

  static bool isColumnModeByWidth(double width) => width > columnWidth * 2 + 64;

  static bool isColumnMode(BuildContext context) =>
      isColumnModeByWidth(MediaQuery.sizeOf(context).width);

  static bool getDisplayNavigationRail(BuildContext context) =>
      !(GoRouterState.of(context).path?.startsWith('/settings') == true);

  static ResponsiveUtils responsive = getIt.get<ResponsiveUtils>();

  static var fallbackTextTheme = const TextTheme(
    bodyLarge: TextStyle(
      fontFamily: MultiFonts.sfPro,
      fontWeight: FontWeight.w400,
      fontSize: MultiMobileTypography.bodyFontBody,
      height: 1.18,
      letterSpacing: -0.4080000162124634,
    ), // Mapped from Figma's bodyLarge
    bodyMedium: TextStyle(
      fontFamily: MultiFonts.sfPro,
      fontWeight: FontWeight.w400,
      fontSize: MultiMobileTypography.bodyFontCallout,
      height: 1.38,
      letterSpacing: -0.32,
    ), // Mapped from Figma's bodyMedium
    bodySmall: TextStyle(
      fontFamily: MultiFonts.sfPro,
      fontWeight: FontWeight.w400,
      fontSize: MultiMobileTypography.bodyFontSubhead,
      height: 1.2,
      letterSpacing: -0.24000000357627868,
    ), // Mapped from Figma's bodySmall
    labelLarge: TextStyle(
      fontFamily: MultiFonts.sfPro,
      fontWeight: FontWeight.w500,
      fontSize: MultiMobileTypography.captionFontFootnote,
      height: 1.38,
      letterSpacing: -0.07800000309944152,
    ), // Mapped from Figma's captionFootnote
    labelMedium: TextStyle(
      fontFamily: MultiFonts.sfPro,
      fontWeight: FontWeight.w400,
      fontSize: MultiMobileTypography.captionFontCaption1,
      height: 1.33,
    ), // Mapped from Figma's captionCaption1
    labelSmall: TextStyle(
      fontFamily: MultiFonts.sfPro,
      fontWeight: FontWeight.w400,
      fontSize: MultiMobileTypography.captionFontCaption2,
      height: 1.27,
      letterSpacing: 0.055,
    ), // Mapped from Figma's captionCaption2
    displayLarge: TextStyle(
      fontFamily: MultiFonts.sfPro,
      fontWeight: FontWeight.w400,
      fontSize: MultiMobileTypography.headlineFontLarge,
      height: 1.13,
      letterSpacing: 0.64,
    ), // Mapped from Figma's headlineExtraLarge
    displayMedium: TextStyle(
      fontFamily: MultiFonts.sfPro,
      fontWeight: FontWeight.w400,
      fontSize: MultiMobileTypography.headlineFontMedium,
      height: 1.21,
      letterSpacing: 0.3639999866485596,
    ), // Mapped from Figma's headlineMedium
    displaySmall: TextStyle(
      fontFamily: MultiFonts.sfPro,
      fontWeight: FontWeight.w500,
      fontSize: MultiMobileTypography.headlineFontSmall,
      height: 1.27,
      letterSpacing: 0.66,
    ), // Mapped from Figma's headlineSmall
    headlineLarge: TextStyle(
      fontFamily: MultiFonts.sfPro,
      fontWeight: FontWeight.w700,
      fontSize: MultiMobileTypography.headlineFontExtraLarge,
      height: 1.24,
      letterSpacing: 0.3740000081062317,
    ), // Mapped from Figma's headlineLargeTitle
    headlineMedium: TextStyle(
      fontFamily: MultiFonts.sfPro,
      fontWeight: FontWeight.w400,
      fontSize: MultiMobileTypography.headlineFontSmall,
      height: 1.3,
      letterSpacing: 0.3799999952316284,
    ), // Mapped from Figma's headlineExtraSmall
    headlineSmall: TextStyle(
      fontFamily: MultiFonts.sfPro,
      fontWeight: FontWeight.w400,
      fontSize: MultiMobileTypography.headlineFontExtraSmall,
      height: 1.29,
      letterSpacing: -0.4080000162124634,
    ), // Mapped from Figma's headlineSubtitle
    titleLarge: TextStyle(
      fontFamily: MultiFonts.sfProDisplay,
      fontWeight: FontWeight.w500,
      fontSize: MultiMobileTypography.buttonFontLarge,
      height: 1.29,
    ), // Mapped from Figma's buttonsLarge
    titleMedium: TextStyle(
      fontFamily: MultiFonts.sfProDisplay,
      fontWeight: FontWeight.w400,
      fontSize: MultiMobileTypography.buttonFontMedium,
      height: 1.33,
    ), // Mapped from Figma's buttonsMedium
    titleSmall: TextStyle(
      fontFamily: MultiFonts.sfProDisplay,
      fontWeight: FontWeight.w400,
      fontSize: MultiMobileTypography.buttonFontSmall,
      height: 1.38,
    ), // Mapped from Figma's buttonsSmall
  );

  static const Duration animationDuration = Duration(milliseconds: 250);
  static const Curve animationCurve = Curves.easeInOut;

  static ThemeData buildTheme(
    BuildContext context,
    Brightness brightness, [
    Color? seed,
  ]) =>
      ThemeData(
        visualDensity: VisualDensity.standard,
        useMaterial3: true,
        fontFamily: MultiFonts.sfPro,
        textTheme: brightness == Brightness.light
            ? Typography.material2021().black.merge(fallbackTextTheme)
            : Typography.material2021().white.merge(fallbackTextTheme),
        snackBarTheme: const SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
        ),
        splashColor: Colors.transparent,
        scaffoldBackgroundColor: MultiSysColors.material().onPrimary,
        dividerColor: brightness == Brightness.light
            ? Colors.blueGrey.shade50
            : Colors.blueGrey.shade900,
        popupMenuTheme: const PopupMenuThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          isDense: true,
          contentPadding: const EdgeInsets.all(12.0),
          fillColor: MultiColors.of(context).backgroundInputsDefault,
          border: const MultiCustomBorderInput(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          focusColor: MultiColors.of(context).backgroundInputsActive,
          focusedBorder: MultiCustomBorderInput(
            shadow: const BoxShadow(
              color: Color(0x3F4C64BA),
              blurRadius: 4,
              offset: Offset(0, 0),
              spreadRadius: 2,
            ),
            borderSide: BorderSide(
              width: 1.0,
              color: MultiColors.of(context).bordersMainActive,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          errorBorder: MultiCustomBorderInput(
            shadow: const BoxShadow(
              color: Color(0x3FEB7C62),
              blurRadius: 4,
              offset: Offset(0, 0),
              spreadRadius: 2,
            ),
            borderSide: BorderSide(
              width: 1.0,
              color: MultiColors.of(context).bordersErrorDefault,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          focusedErrorBorder: MultiCustomBorderInput(
            shadow: const BoxShadow(
              color: Color(0x3FEB7C62),
              blurRadius: 4,
              offset: Offset(0, 0),
              spreadRadius: 2,
            ),
            borderSide: BorderSide(
              width: 1.0,
              color: MultiColors.of(context).bordersErrorDefault,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          labelStyle: fallbackTextTheme.headlineSmall?.merge(
            TextStyle(
              color: MultiColors.of(context).textMainTertiaryDisabled,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          floatingLabelStyle: fallbackTextTheme.labelSmall?.merge(
            TextStyle(
              color: MultiColors.of(context).textMainTertiaryDisabled,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          filled: true,
          hintStyle: fallbackTextTheme.headlineSmall?.merge(
            TextStyle(
              color: MultiColors.of(context).textMainTertiaryDisabled,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          errorStyle: fallbackTextTheme.labelLarge?.merge(
            TextStyle(
              color: MultiSysColors.material().error,
            ),
          ),
        ),
        appBarTheme: AppBarTheme(
          toolbarHeight: AppConfig.toolbarHeight(context),
          scrolledUnderElevation: 0,
          titleSpacing: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: brightness.reversed,
            statusBarBrightness: brightness,
          ),
          foregroundColor: brightness == Brightness.light
              ? MultiSysColors.material().onBackground
              : MultiSysColors.material().onBackgroundDark,
          backgroundColor: MultiSysColors.material().onPrimary,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
          ),
        ),
        dialogTheme: const DialogTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(16),
            textStyle: const TextStyle(fontSize: 16),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
          ),
        ),
        highlightColor: Colors.transparent,
        colorScheme: ColorScheme.fromSeed(
          seedColor: seed ?? AppConfig.colorSchemeSeed,
          brightness: brightness,
          primary: brightness == Brightness.light
              ? MultiSysColors.material().primary
              : MultiSysColors.material().primaryDark,
          onPrimary: brightness == Brightness.light
              ? MultiSysColors.material().onPrimary
              : MultiSysColors.material().onPrimaryDark,
          primaryContainer: brightness == Brightness.light
              ? MultiSysColors.material().primaryContainer
              : MultiSysColors.material().primaryContainerDark,
          onPrimaryContainer: brightness == Brightness.light
              ? MultiSysColors.material().onPrimaryContainer
              : MultiSysColors.material().onPrimaryContainerDark,
          inversePrimary: brightness == Brightness.light
              ? MultiSysColors.material().inversePrimary
              : MultiSysColors.material().inversePrimaryDark,
          tertiary: brightness == Brightness.light
              ? MultiSysColors.material().tertiary
              : MultiSysColors.material().tertiaryDark,
          onTertiary: brightness == Brightness.light
              ? MultiSysColors.material().onTertiary
              : MultiSysColors.material().onTertiaryDark,
          tertiaryContainer: brightness == Brightness.light
              ? MultiSysColors.material().tertiaryContainer
              : MultiSysColors.material().tertiaryContainerDark,
          onTertiaryContainer: brightness == Brightness.light
              ? MultiSysColors.material().onTertiaryContainer
              : MultiSysColors.material().onTertiaryContainerDark,
          secondary: brightness == Brightness.light
              ? MultiSysColors.material().secondary
              : MultiSysColors.material().secondaryDark,
          onSecondary: brightness == Brightness.light
              ? MultiSysColors.material().onSecondary
              : MultiSysColors.material().onSecondaryDark,
          secondaryContainer: brightness == Brightness.light
              ? MultiSysColors.material().secondaryContainer
              : MultiSysColors.material().secondaryContainerDark,
          onSecondaryContainer: brightness == Brightness.light
              ? MultiSysColors.material().onSecondaryContainer
              : MultiSysColors.material().onSecondaryContainerDark,
          // TODO: remove when the color scheme is updated
          // ignore: deprecated_member_use
          background: brightness == Brightness.light
              ? MultiSysColors.material().background
              : MultiSysColors.material().backgroundDark,
          // TODO: remove when the color scheme is updated
          // ignore: deprecated_member_use
          onBackground: brightness == Brightness.light
              ? MultiSysColors.material().onBackground
              : MultiSysColors.material().onBackgroundDark,
          error: brightness == Brightness.light
              ? MultiSysColors.material().error
              : MultiSysColors.material().errorDark,
          onError: brightness == Brightness.light
              ? MultiSysColors.material().onError
              : MultiSysColors.material().onErrorDark,
          errorContainer: brightness == Brightness.light
              ? MultiSysColors.material().errorContainer
              : MultiSysColors.material().errorContainerDark,
          onErrorContainer: brightness == Brightness.light
              ? MultiSysColors.material().onErrorContainer
              : MultiSysColors.material().onErrorContainerDark,
          surface: brightness == Brightness.light
              ? MultiSysColors.material().surface
              : MultiSysColors.material().surfaceDark,
          onSurface: brightness == Brightness.light
              ? MultiSysColors.material().onSurface
              : MultiSysColors.material().onSurfaceDark,
          surfaceTint: brightness == Brightness.light
              ? MultiSysColors.material().surfaceTint
              : MultiSysColors.material().surfaceTintDark,
          surfaceContainerHighest: brightness == Brightness.light
              ? MultiSysColors.material().surfaceVariant
              : MultiSysColors.material().surfaceVariantDark,
          onSurfaceVariant: brightness == Brightness.light
              ? MultiSysColors.material().onSurfaceVariant
              : MultiSysColors.material().onSurfaceVariantDark,
          inverseSurface: brightness == Brightness.light
              ? MultiSysColors.material().inverseSurface
              : MultiSysColors.material().inverseSurfaceDark,
          onInverseSurface: brightness == Brightness.light
              ? MultiSysColors.material().onInverseSurface
              : MultiSysColors.material().onInverseSurfaceDark,
          shadow: brightness == Brightness.light
              ? MultiSysColors.material().shadow
              : MultiSysColors.material().shadowDark,
          outline: brightness == Brightness.light
              ? MultiSysColors.material().outline
              : MultiSysColors.material().outlineDark,
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: brightness == Brightness.light
              ? MultiSysColors.material().primary
              : MultiSysColors.material().primaryDark,
        ),
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
            iconSize: WidgetStateProperty.all(iconSize),
            iconColor: WidgetStateProperty.all(
              brightness == Brightness.light
                  ? MultiSysColors.material().onSurface
                  : MultiSysColors.material().onSurfaceDark,
            ),
          ),
        ),
        iconTheme: IconThemeData(
          size: iconSize,
          color: brightness == Brightness.light
              ? MultiSysColors.material().onBackground
              : MultiSysColors.material().onBackgroundDark,
        ),
        switchTheme: SwitchThemeData(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          overlayColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.selected)) {
                return brightness == Brightness.light
                    ? MultiSysColors.material().primary
                    : MultiSysColors.material().primaryDark;
              } else {
                return brightness == Brightness.light
                    ? MultiSysColors.material().outline
                    : MultiSysColors.material().outlineDark;
              }
            },
          ),
          thumbColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.selected)) {
                return brightness == Brightness.light
                    ? MultiSysColors.material().onPrimary
                    : MultiSysColors.material().onPrimaryDark;
              } else {
                return brightness == Brightness.light
                    ? MultiSysColors.material().outline
                    : MultiSysColors.material().outlineDark;
              }
            },
          ),
          trackColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.selected)) {
                return brightness == Brightness.light
                    ? MultiSysColors.material().primary
                    : MultiSysColors.material().primaryDark;
              } else {
                return brightness == Brightness.light
                    ? MultiSysColors.material().surface
                    : MultiSysColors.material().surfaceDark;
              }
            },
          ),
        ),
        navigationBarTheme: NavigationBarThemeData(
          height: 64,
          labelTextStyle: WidgetStateProperty.resolveWith(
            (states) {
              if (states.contains(WidgetState.selected)) {
                return fallbackTextTheme.labelSmall?.copyWith(
                  fontSize: 11,
                  color: MultiSysColors.material().primary,
                );
              }
              return responsive.isDesktop(context)
                  ? fallbackTextTheme.labelSmall?.copyWith(
                      fontSize: 11,
                      color: LinagoraRefColors.material().neutral[10],
                    )
                  : fallbackTextTheme.labelSmall?.copyWith(
                      fontSize: 11,
                      color: MultiSysColors.material().tertiary,
                    );
            },
          ),
          backgroundColor: brightness == Brightness.light
              ? MultiSysColors.material().surface
              : MultiSysColors.material().surfaceDark,
          shadowColor: brightness == Brightness.light
              ? MultiSysColors.material().shadow
              : MultiSysColors.material().shadowDark,
          elevation: 4.0,
          overlayColor: WidgetStateColor.resolveWith(
            (states) {
              return Colors.transparent;
            },
          ),
        ),
        navigationRailTheme: NavigationRailThemeData(
          indicatorColor: brightness == Brightness.light
              ? MultiSysColors.material().inversePrimary
              : MultiSysColors.material().secondaryContainerDark,
        ),
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: brightness == Brightness.light
              ? MultiSysColors.material().background
              : MultiSysColors.material().backgroundDark,
          surfaceTintColor: brightness == Brightness.light
              ? MultiSysColors.material().background
              : MultiSysColors.material().backgroundDark,
        ),
        // bottomNavigationBarTheme: BottomNavigationBarThemeData(
        //   backgroundColor: MultiSysColors.material().surface,
        //   selectedLabelStyle: fallbackTextTheme.labelSmall?.copyWith(
        //     fontSize: 11,
        //     color: MultiSysColors.material().primary,
        //   ),
        //   unselectedLabelStyle: fallbackTextTheme.labelSmall?.copyWith(
        //     fontSize: 11,
        //     color: MultiSysColors.material().tertiary,
        //   ),
        //   selectedItemColor: MultiSysColors.material().primary,
        //   unselectedItemColor: MultiSysColors.material().tertiary,
        // ),
      );
}

extension on Brightness {
  Brightness get reversed =>
      this == Brightness.dark ? Brightness.light : Brightness.dark;
}
