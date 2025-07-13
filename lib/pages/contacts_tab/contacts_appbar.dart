import 'package:fluffychat/config/multi_sys_variables/multi_typography.dart';
import 'package:fluffychat/di/global/get_it_initializer.dart';
import 'package:fluffychat/pages/search/search_text_field.dart';
import 'package:fluffychat/utils/responsive/responsive_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class ContactsAppBar extends StatelessWidget {
  final ValueNotifier<bool> isSearchModeNotifier;
  final FocusNode searchFocusNode;
  final TextEditingController textEditingController;
  final Function()? clearSearchBar;
  static ResponsiveUtils responsiveUtils = getIt.get<ResponsiveUtils>();

  const ContactsAppBar({
    super.key,
    required this.isSearchModeNotifier,
    required this.searchFocusNode,
    required this.textEditingController,
    this.clearSearchBar,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black.withOpacity(0.5),
      flexibleSpace: Container(
        decoration: const ShapeDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.50, -0.00),
            end: Alignment(0.50, 1.00),
            colors: [Color(0xFF0E0F13), Color(0xFF232631)],
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
          padding: const EdgeInsets.only(
            bottom: 20,
            left: 20,
            right: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                L10n.of(context)!.contacts,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontSize: MultiMobileTypography.headlineFontSmall,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
              ),
              const SizedBox(height: 16.0),
              ValueListenableBuilder<bool>(
                valueListenable: isSearchModeNotifier,
                builder: (context, isSearchMode, child) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: SearchTextField(
                          textEditingController: textEditingController,
                          autofocus: false,
                          focusNode: searchFocusNode,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
