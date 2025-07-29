import 'package:fluffychat/pages/chat_details/participant_list_item/participant_list_item.dart';
import 'package:fluffychat/widgets/stacked_cards/stacked_cards_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:matrix/matrix.dart';

class ChatDetailsMembersPage extends StatelessWidget {
  final ValueNotifier<List<User>?> displayMembersNotifier;
  final int actualMembersCount;
  final VoidCallback openDialogInvite;
  final VoidCallback requestMoreMembersAction;
  final VoidCallback? onUpdatedMembers;
  final bool isMobileAndTablet;

  const ChatDetailsMembersPage({
    super.key,
    required this.displayMembersNotifier,
    required this.actualMembersCount,
    required this.openDialogInvite,
    required this.requestMoreMembersAction,
    required this.isMobileAndTablet,
    this.onUpdatedMembers,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: displayMembersNotifier,
      builder: (context, members, child) {
        members ??= [];
        final canRequestMoreMembers = members.length < actualMembersCount;

        // Create a combined list that includes both members and potentially a "load more" item
        final List<dynamic> itemsList = [...members];

        if (canRequestMoreMembers) {
          // Add a special item to represent "load more"
          itemsList.add('load_more');
        }

        return SizedBox.expand(
          child: StackedCardsWidget<dynamic>(
            items: itemsList,
            cardHeight: 80,
            itemBuilder: (context, item, index, isStacked) {
              // If this is our special "load more" item
              if (item == 'load_more') {
                return ListTile(
                  title: Text(
                    L10n.of(context)!.loadCountMoreParticipants(
                      (actualMembersCount - members!.length).toString(),
                    ),
                  ),
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    child: const Icon(
                      Icons.refresh,
                      color: Colors.grey,
                    ),
                  ),
                  onTap: requestMoreMembersAction,
                );
              }

              if (item is User) {
                return ParticipantListItem(
                  item,
                  onUpdatedMembers: onUpdatedMembers,
                );
              }

              return const SizedBox.shrink();
            },
          ),
        );
      },
    );
  }
}
