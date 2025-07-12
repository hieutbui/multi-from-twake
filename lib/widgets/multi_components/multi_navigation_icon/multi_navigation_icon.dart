import 'package:fluffychat/widgets/multi_components/multi_navigation_icon/multi_navigation_icon_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MultiNavigationIcon extends StatelessWidget {
  final String icon;
  final int notificationCount;
  final bool isSelected;
  final Color? color;

  const MultiNavigationIcon({
    super.key,
    required this.icon,
    this.notificationCount = 0,
    this.isSelected = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Badge(
      backgroundColor: Theme.of(context).colorScheme.error,
      isLabelVisible: notificationCount > 0,
      largeSize: MultiNavigationIconStyle.badgeHeight,
      label: Text(
        notificationCount.toString(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context).colorScheme.onError,
            ),
      ),
      child: SvgPicture.asset(
        icon,
      ),
    );
  }
}
