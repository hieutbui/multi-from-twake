import 'package:flutter/material.dart';
import 'package:gradient_borders/input_borders/gradient_outline_input_border.dart';

import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:linagora_design_flutter/linagora_design_flutter.dart';

class SearchViewStyle {
  static double get toolbarHeightSearch => 80;

  static double get toolbarHeightOfSliverAppBar => 44.0;

  static EdgeInsetsGeometry get paddingRecentChatsHeaders =>
      const EdgeInsets.symmetric(horizontal: 16, vertical: 4.0);

  static EdgeInsetsGeometry get paddingLeadingAppBar =>
      const EdgeInsetsDirectional.only(end: 8, start: 8);

  static EdgeInsetsGeometry get contentPaddingAppBar =>
      const EdgeInsets.all(12.0);

  static EdgeInsetsGeometry get paddingRecentChats => const EdgeInsets.all(8);

  static const double paddingBackButton = 8.0;

  static final BorderRadius borderRadiusTextField = BorderRadius.circular(24);

  static EdgeInsetsGeometry get appbarPadding =>
      const EdgeInsetsDirectional.only(
        bottom: 0.0,
        top: 0.0,
      );

  static TextStyle? headerTextStyle(BuildContext context) =>
      Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          );

  static const double searchIconSize = 24.0;

  static InputDecoration searchInputDecoration(
    BuildContext context, {
    String? hintText,
    Color? prefixIconColor,
  }) {
    return InputDecoration(
      border: GradientOutlineInputBorder(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF738C96).withOpacity(0.0),
            const Color(0xFF738C96),
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        width: 1.0,
        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
      ),
      hintText: hintText ?? L10n.of(context)!.search,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      prefixIcon: Icon(
        Icons.search,
        size: SearchViewStyle.searchIconSize,
        color: prefixIconColor ?? LinagoraRefColors.material().neutral[60],
      ),
      suffixIcon: const SizedBox.shrink(),
    );
  }
}
