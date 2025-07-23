import 'package:fluffychat/pages/new_group/contacts_selection.dart';
import 'package:fluffychat/pages/new_group/widget/selected_participants_list_style.dart';
import 'package:fluffychat/widgets/avatar/avatar.dart';
import 'package:fluffychat/widgets/matrix.dart';
import 'package:flutter/material.dart';
import 'package:linagora_design_flutter/colors/linagora_ref_colors.dart';
import 'package:matrix/matrix.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class SelectedParticipantsList extends StatefulWidget {
  final ContactsSelectionController contactsSelectionController;

  const SelectedParticipantsList({
    super.key,
    required this.contactsSelectionController,
  });

  @override
  State<StatefulWidget> createState() => _SelectedParticipantsListState();
}

class _SelectedParticipantsListState extends State<SelectedParticipantsList> {
  @override
  Widget build(BuildContext context) {
    final contactsNotifier =
        widget.contactsSelectionController.selectedContactsMapNotifier;

    return AnimatedSize(
      curve: Curves.easeIn,
      alignment: Alignment.bottomCenter,
      duration: const Duration(milliseconds: 250),
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: ListenableBuilder(
          listenable: contactsNotifier,
          builder: (context, Widget? child) {
            if (contactsNotifier.contactsList.isEmpty) {
              return const SizedBox.shrink();
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: SelectedParticipantsListStyle.paddingAll,
                  child: Wrap(
                    spacing: 12.0,
                    runSpacing: 8.0,
                    children: contactsNotifier.contactsList.map((contact) {
                      return Stack(
                        children: [
                          contact.matrixId != null
                              ? FutureBuilder<Profile>(
                                  future: Matrix.of(context)
                                      .client
                                      .getProfileFromUserId(
                                        contact.matrixId!,
                                        getFromRooms: false,
                                      ),
                                  builder: ((context, snapshot) {
                                    return Avatar(
                                      mxContent: snapshot.data?.avatarUrl,
                                      name: contact.displayName,
                                      size: SelectedParticipantsListStyle
                                          .avatarChipSize,
                                    );
                                  }),
                                )
                              : Avatar(
                                  name: contact.displayName,
                                  size: SelectedParticipantsListStyle
                                      .avatarChipSize,
                                ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: InkWell(
                              onTap: () {
                                widget.contactsSelectionController
                                    .selectedContactsMapNotifier
                                    .unselectContact(contact);
                              },
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12.0)),
                              child: Container(
                                height: 24,
                                width: 24,
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(12.0),
                                  ),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.close,
                                    size: 16,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
                Divider(
                  color: Theme.of(context)
                      .colorScheme
                      .surfaceTint
                      .withOpacity(0.16),
                ),
                const SizedBox(
                  height: 4.0,
                ),
                Padding(
                  padding: SelectedParticipantsListStyle.contactPadding,
                  child: Row(
                    children: [
                      Text(
                        '${L10n.of(context)!.selectedUsers}: ${contactsNotifier.contactsList.length}',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: LinagoraRefColors.material().tertiary[20],
                            ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () => widget.contactsSelectionController
                                  .selectedContactsMapNotifier
                                  .unselectAllContacts(),
                              child: Text(
                                L10n.of(context)!.clearAllSelected,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(
                                      color: LinagoraRefColors.material()
                                          .tertiary[20],
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
