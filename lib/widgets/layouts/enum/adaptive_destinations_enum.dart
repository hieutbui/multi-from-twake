import 'package:fluffychat/resource/image_paths.dart';
import 'package:fluffychat/utils/matrix_sdk_extensions/client_stories_extension.dart';
import 'package:fluffychat/utils/responsive/responsive_utils.dart';
import 'package:fluffychat/widgets/layouts/adaptive_layout/app_adaptive_scaffold_body_view_style.dart';
import 'package:fluffychat/widgets/multi_components/multi_navigation_icon/multi_navigation_icon.dart';
import 'package:fluffychat/widgets/unread_rooms_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:matrix/matrix.dart';

enum AdaptiveDestinationEnum {
  contacts,
  rooms,
  //TODO: update when Figma has this screen
  voice,
  stories,
  settings;

  NavigationDestination getNavigationDestination(
    BuildContext context,
    ValueNotifier<Profile?> profile,
  ) {
    switch (this) {
      case AdaptiveDestinationEnum.contacts:
        return NavigationDestination(
          icon: MultiNavigationIcon(
            icon: ImagePaths.icBottomNavContactsInactive,
          ),
          label: 'Contacts',
          selectedIcon: MultiNavigationIcon(
            icon: ImagePaths.icBottomNavContactsActive,
          ),
        );
      case AdaptiveDestinationEnum.rooms:
        return NavigationDestination(
          icon: UnreadRoomsBadge(
            icon: ImagePaths.icBottomNavMessageInactive,
            filter: (room) => !room.isSpace && !room.isStoryRoom,
          ),
          selectedIcon: UnreadRoomsBadge(
            icon: ImagePaths.icBottomNavMessageActive,
            filter: (room) => !room.isSpace && !room.isStoryRoom,
            isSelected: true,
          ),
          label: 'Chats',
        );
      case AdaptiveDestinationEnum.stories:
        return NavigationDestination(
          icon: UnreadRoomsBadge(
            icon: ImagePaths.icBottomNavStoriesInactive,
            filter: (room) => !room.isSpace && room.isStoryRoom,
          ),
          selectedIcon: UnreadRoomsBadge(
            icon: ImagePaths.icBottomNavStoriesActive,
            filter: (room) => !room.isSpace && room.isStoryRoom,
            isSelected: true,
          ),
          label: 'Stories',
        );
      case AdaptiveDestinationEnum.settings:
        return NavigationDestination(
          icon: MultiNavigationIcon(
            icon: ImagePaths.icBottomNavSettingInactive,
          ),
          selectedIcon: MultiNavigationIcon(
            icon: ImagePaths.icBottomNavSettingActive,
          ),
          label: 'Settings',
        );
      default:
        return NavigationDestination(
          icon: UnreadRoomsBadge(
            icon: ImagePaths.icBottomNavMessageInactive,
            filter: (room) => !room.isSpace && !room.isStoryRoom,
          ),
          label: '',
        );
    }
  }

  BottomNavigationBarItem getNavigationDestinationForBottomBar(
    BuildContext context,
    ValueNotifier<Profile?> profile,
  ) {
    switch (this) {
      case AdaptiveDestinationEnum.contacts:
        return BottomNavigationBarItem(
          icon: MultiNavigationIcon(
            icon: ImagePaths.icBottomNavContactsInactive,
          ),
          label: 'Contacts',
          activeIcon: MultiNavigationIcon(
            icon: ImagePaths.icBottomNavContactsActive,
            isSelected: true,
          ),
        );
      case AdaptiveDestinationEnum.rooms:
        return BottomNavigationBarItem(
          icon: UnreadRoomsBadge(
            icon: ImagePaths.icBottomNavMessageInactive,
            filter: (room) => !room.isSpace && !room.isStoryRoom,
          ),
          activeIcon: UnreadRoomsBadge(
            icon: ImagePaths.icBottomNavMessageActive,
            filter: (room) => !room.isSpace && !room.isStoryRoom,
            isSelected: true,
          ),
          label: 'Chats',
        );
      case AdaptiveDestinationEnum.voice:
        return BottomNavigationBarItem(
          icon: Transform.scale(
            scale: 64 / 60,
            child: Container(
              height: ResponsiveUtils.heightBottomNavigation,
              width: ResponsiveUtils.heightBottomNavigation,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppAdaptiveScaffoldBodyViewStyle.centerItemColor(
                  context,
                ),
                border: Border.all(
                  width: 6.5625,
                  color: AppAdaptiveScaffoldBodyViewStyle.centerItemBorderColor(
                    context,
                  ),
                ),
              ),
              child: Center(
                child: SvgPicture.asset(ImagePaths.icRecord),
              ),
            ),
          ),
          label: 'Voice',
        );
      case AdaptiveDestinationEnum.stories:
        return BottomNavigationBarItem(
          icon: UnreadRoomsBadge(
            icon: ImagePaths.icBottomNavStoriesInactive,
            filter: (room) => !room.isSpace && room.isStoryRoom,
          ),
          activeIcon: UnreadRoomsBadge(
            icon: ImagePaths.icBottomNavStoriesActive,
            filter: (room) => !room.isSpace && room.isStoryRoom,
            isSelected: true,
          ),
          label: 'Stories',
        );
      case AdaptiveDestinationEnum.settings:
        return BottomNavigationBarItem(
          icon: MultiNavigationIcon(
            icon: ImagePaths.icBottomNavSettingInactive,
          ),
          activeIcon: MultiNavigationIcon(
            icon: ImagePaths.icBottomNavSettingActive,
            isSelected: true,
          ),
          label: 'Settings',
        );
      default:
        return BottomNavigationBarItem(
          icon: UnreadRoomsBadge(
            icon: ImagePaths.icBottomNavMessageInactive,
            filter: (room) => !room.isSpace && !room.isStoryRoom,
          ),
          activeIcon: UnreadRoomsBadge(
            icon: ImagePaths.icBottomNavMessageActive,
            filter: (room) => !room.isSpace && !room.isStoryRoom,
            isSelected: true,
          ),
          label: '',
        );
    }
  }
}
