import 'package:fluffychat/config/multi_sys_variables/multi_colors.dart';
import 'package:fluffychat/config/multi_sys_variables/multi_typography.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/input_borders/gradient_outline_input_border.dart';

class ChatListTabBarStyles {
  static InputDecoration folderNameInputDecoration(BuildContext context) {
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
      hintText: "Folder Name",
      hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: MultiColors.of(context).textMainTertiaryDisabled,
          ),
      floatingLabelBehavior: FloatingLabelBehavior.never,
    );
  }

  static InputDecoration addChatInputDecoration(BuildContext context) {
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
      hintText: "Add chat",
      hintStyle: TextStyle(
        fontFamily: MultiFonts.sfProDisplay,
        fontSize: MultiMobileTypography.buttonFontMedium,
        color: MultiColors.of(context).buttonsMainGhostDefault,
      ),
      prefixIcon: SizedBox(
        width: 10,
        child: Icon(
          Icons.add,
          size: 20,
          color: MultiColors.of(context).buttonsMainGhostDefault,
        ),
      ),
      prefixIconConstraints: const BoxConstraints(minWidth: 36),
      floatingLabelBehavior: FloatingLabelBehavior.never,
    );
  }

  static InputDecoration folderNameEditInputDecoration(BuildContext context) {
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
      contentPadding: const EdgeInsetsDirectional.fromSTEB(12, 28, 12, 12),
      hintText: "Folder Name",
      hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: MultiColors.of(context).textMainTertiaryDisabled,
          ),
      suffix: Padding(
        padding: const EdgeInsetsDirectional.only(start: 8),
        child: GestureDetector(
          onTap: () {},
          child: Text(
            "Delete folder",
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: MultiColors.of(context).buttonsMainGhostError,
                ),
          ),
        ),
      ),
    );
  }
}
