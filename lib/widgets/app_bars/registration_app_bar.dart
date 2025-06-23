import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class RegistrationAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final Color? backgroundColor;
  final bool? centerTitle;
  final Widget? leading;
  final double? leadingWidth;
  final Widget? title;
  final List<Widget>? actions;
  final String? rightButtonText;
  final bool isShowLeading;

  const RegistrationAppBar({
    super.key,
    this.backgroundColor,
    this.centerTitle,
    this.leading,
    this.leadingWidth,
    this.title,
    this.actions,
    this.rightButtonText,
    this.isShowLeading = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      backgroundColor: backgroundColor ?? Colors.transparent,
      toolbarHeight: 28.0,
      centerTitle: centerTitle ?? false,
      leading: isShowLeading == true
          ? leading ??
              Padding(
                padding: const EdgeInsets.only(left: 14),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.white,
                    size: 16,
                  ),
                  onPressed: () => context.pop(),
                  padding: const EdgeInsets.all(6),
                  constraints: const BoxConstraints(
                    minWidth: 28,
                    minHeight: 28,
                    maxWidth: 28,
                    maxHeight: 28,
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      const Color(
                        0xFF2A2A2A,
                      ) /* Buttons-Main-Secondary-15-Opasity */,
                    ),
                    shape: MaterialStateProperty.all(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                  ),
                ),
              )
          : null,
      leadingWidth: leadingWidth,
      title: title,
      actions: actions ??
          [
            TextButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                ),
                backgroundColor: MaterialStateProperty.all(
                  const Color(0xFF2A2A2A),
                ),
              ),
              onPressed: () => {},
              child: Text(
                rightButtonText ?? 'Help',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white.withAlpha(222),
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ),
            const SizedBox(width: 20),
          ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(36.0);
}
