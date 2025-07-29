import 'package:fluffychat/config/default_power_level_member.dart';
import 'package:fluffychat/config/multi_sys_variables/multi_colors.dart';
import 'package:fluffychat/config/multi_sys_variables/multi_typography.dart';
import 'package:fluffychat/utils/user_extension.dart';
import 'package:fluffychat/widgets/avatar/avatar.dart';
import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';

class ParticipantListItem extends StatelessWidget {
  final User member;

  final VoidCallback? onUpdatedMembers;

  const ParticipantListItem(
    this.member, {
    super.key,
    this.onUpdatedMembers,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: member.membership == Membership.join ? 1 : 0.5,
      child: SizedBox(
        height: 80,
        child: Container(
          height: 56, // Explicitly constrain inner container height
          decoration: BoxDecoration(
            color: MultiColors.of(context).backgroundSurfacesDefault,
            borderRadius: const BorderRadiusDirectional.all(
              Radius.circular(12.0),
            ),
          ),
          padding: const EdgeInsetsDirectional.all(12.0),
          child: Row(
            children: [
              Avatar(
                mxContent: member.avatarUrl,
                name: member.calcDisplayname(),
                size: 40.0,
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            member.calcDisplayname(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                              fontSize: 16,
                              fontFamily: MultiFonts.sfProDisplay,
                              fontWeight: FontWeight.w600,
                              height: 1.0, // Reduce line height
                              letterSpacing: 0.48,
                            ),
                          ),
                        ),
                        if (member.getDefaultPowerLevelMember.powerLevel >=
                            DefaultPowerLevelMember.owner.powerLevel) ...[
                          Text(
                            member.getDefaultPowerLevelMember
                                .displayName(context),
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurfaceVariant,
                                      height: 1.0, // Reduce line height
                                    ),
                          ),
                        ] else if (member.membership != Membership.join) ...[
                          Text(
                            _getMembershipDisplayText(member.membership),
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurfaceVariant,
                                      height: 1.0, // Reduce line height
                                    ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 1), // Minimal spacing
                    Text(
                      member.id,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                            height: 1.0, // Reduce line height
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getMembershipDisplayText(Membership membership) {
    switch (membership) {
      case Membership.invite:
        return 'Invited';
      case Membership.join:
        return 'Joined';
      case Membership.leave:
        return 'Left';
      case Membership.ban:
        return 'Banned';
      case Membership.knock:
        return 'Knock';
    }
  }

  // Future _onItemTap(BuildContext context) async {
  //   final responsive = getIt.get<ResponsiveUtils>();

  //   if (responsive.isMobile(context)) {
  //     await _openDialogInvite(context);
  //   } else {
  //     await _openProfileDialog(context);
  //   }
  // }

  // Future _openDialogInvite(BuildContext context) async {
  //   if (PlatformInfos.isMobile) {
  //     Navigator.of(context).push(
  //       CupertinoPageRoute(
  //         builder: (ctx) => ProfileInfoPage(
  //           roomId: member.room.id,
  //           userId: member.id,
  //           onUpdatedMembers: onUpdatedMembers,
  //         ),
  //       ),
  //     );
  //     return;
  //   }
  //   await showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     useSafeArea: false,
  //     useRootNavigator: !PlatformInfos.isMobile,
  //     builder: (dialogContext) {
  //       return ProfileInfoPage(
  //         roomId: member.room.id,
  //         userId: member.id,
  //         onUpdatedMembers: onUpdatedMembers,
  //         onNewChatOpen: () {
  //           Navigator.of(dialogContext).pop();
  //         },
  //       );
  //     },
  //   );
  // }

  // Future _openProfileDialog(BuildContext context) => showDialog(
  //       context: context,
  //       builder: (dialogContext) => AlertDialog(
  //         contentPadding: const EdgeInsets.all(0),
  //         backgroundColor: LinagoraRefColors.material().primary[100],
  //         surfaceTintColor: Colors.transparent,
  //         content: SizedBox(
  //           width: ParticipantListItemStyle.fixedDialogWidth,
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               Stack(
  //                 children: [
  //                   Align(
  //                     alignment: Alignment.topRight,
  //                     child: Padding(
  //                       padding: ParticipantListItemStyle.closeButtonPadding,
  //                       child: IconButton(
  //                         onPressed: () => Navigator.of(dialogContext).pop(),
  //                         icon: const Icon(Icons.close),
  //                       ),
  //                     ),
  //                   ),
  //                   ProfileInfoBody(
  //                     user: member,
  //                     onNewChatOpen: () {
  //                       Navigator.of(dialogContext).pop();
  //                     },
  //                     onUpdatedMembers: onUpdatedMembers,
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     );
}
