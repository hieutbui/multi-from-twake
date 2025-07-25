import 'package:fluffychat/config/first_column_inner_routes.dart';
import 'package:fluffychat/config/multi_sys_variables/multi_colors.dart';
import 'package:fluffychat/config/multi_sys_variables/multi_sys_colors.dart';
import 'package:fluffychat/config/multi_sys_variables/multi_typography.dart';
import 'package:fluffychat/pages/dialer/pip/dismiss_keyboard.dart';
import 'package:fluffychat/widgets/context_menu_builder_ios_paste_without_permission.dart';
import 'package:fluffychat/widgets/twake_components/twake_icon_button.dart';
import 'package:fluffychat/widgets/app_bars/searchable_app_bar_style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:gradient_borders/input_borders/gradient_outline_input_border.dart';
import 'package:linagora_design_flutter/linagora_design_flutter.dart';

class SearchableAppBar extends StatelessWidget {
  final bool displayBackButton;
  final FocusNode focusNode;
  final String title;
  final String? hintText;
  final TextEditingController textEditingController;
  final Function() openSearchBar;
  final Function() closeSearchBar;
  final double? toolbarHeight;
  final bool isFullScreen;

  const SearchableAppBar({
    super.key,
    required this.title,
    this.hintText,
    required this.focusNode,
    required this.textEditingController,
    required this.openSearchBar,
    required this.closeSearchBar,
    this.toolbarHeight,
    this.isFullScreen = true,
    this.displayBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: toolbarHeight,
      bottom: PreferredSize(
        preferredSize: const Size(double.infinity, 4),
        child: Container(
          color: LinagoraStateLayer(
            MultiSysColors.material().surfaceTint,
          ).opacityLayer1,
          height: 1,
        ),
      ),
      flexibleSpace: Container(
        decoration: const ShapeDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.50, -0.00),
            end: Alignment(0.50, 1.00),
            colors: [
              Color(0xFF0E0F13),
              Color(0xFF232631),
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
          ),
        ),
        child: Container(
          margin: EdgeInsets.only(
            top: 12.0 + MediaQuery.of(context).padding.top,
          ),
          padding: const EdgeInsetsDirectional.only(
            bottom: 20,
            start: 20,
            end: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  TwakeIconButton(
                    icon: Icons.arrow_back,
                    onTap: () {
                      if (!FirstColumnInnerRoutes.instance
                          .goRouteAvailableInFirstColumn()) {
                        Navigator.of(context).maybePop();
                      } else {
                        if (Navigator.of(context).canPop()) {
                          Navigator.of(context).pop();
                        } else {
                          context.go('/rooms');
                        }
                      }
                    },
                    tooltip: L10n.of(context)!.back,
                    size: 16.0,
                    buttonDecoration: BoxDecoration(
                      color:
                          MultiColors.of(context).buttonsMainSecondary15Opasity,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium
                          ?.copyWith(
                            fontSize: MultiMobileTypography.headlineFontSmall,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          ),
                    ),
                  ),
                  const SizedBox(
                    width: 28.0,
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              _textFieldBuilder(context),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.black.withOpacity(0.5),
    );
  }

  Widget _textFieldBuilder(BuildContext context) {
    return TextField(
      onTapOutside: (event) {
        dismissKeyboard(context);
      },
      focusNode: focusNode,
      autofocus: true,
      maxLines: SearchableAppBarStyle.textFieldMaxLines,
      contextMenuBuilder: mobileTwakeContextMenuBuilder,
      buildCounter: (
        BuildContext context, {
        required int currentLength,
        required int? maxLength,
        required bool isFocused,
      }) =>
          const SizedBox.shrink(),
      maxLength: SearchableAppBarStyle.textFieldMaxLength,
      cursorHeight: 26,
      scrollPadding: const EdgeInsets.all(0),
      controller: textEditingController,
      decoration: InputDecoration(
        isCollapsed: true,
        hintText: hintText,
        prefixIcon: const Icon(
          Icons.search,
          size: 24,
        ),
        suffixIcon: const SizedBox.shrink(),
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
      ),
    );
  }
}
