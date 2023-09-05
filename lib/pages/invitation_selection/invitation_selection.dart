import 'package:fluffychat/pages/new_group/contacts_selection.dart';
import 'package:fluffychat/pages/new_group/contacts_selection_view.dart';
import 'package:fluffychat/widgets/fluffy_chat_app.dart';
import 'package:flutter/material.dart';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:future_loading_dialog/future_loading_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:fluffychat/utils/matrix_sdk_extensions/matrix_locals.dart';
import 'package:fluffychat/widgets/matrix.dart';
import 'package:matrix/matrix.dart';

class InvitationSelection extends StatefulWidget {
  final String roomId;
  final bool? isFullScreen;

  const InvitationSelection({
    Key? key,
    required this.roomId,
    this.isFullScreen = true,
  }) : super(key: key);

  @override
  InvitationSelectionController createState() =>
      InvitationSelectionController();
}

class InvitationSelectionController
    extends ContactsSelectionController<InvitationSelection> {
  String? get _roomId => widget.roomId;

  Room get _room => Matrix.of(context).client.getRoomById(_roomId!)!;

  @override
  bool get isFullScreen => widget.isFullScreen == true;

  @override
  String getTitle(BuildContext context) {
    return L10n.of(context)!.addMember;
  }

  @override
  String getHintText(BuildContext context) {
    return L10n.of(context)!.whoWouldYouLikeToAdd;
  }

  @override
  List<String> get disabledContactIds => Matrix.of(context)
      .client
      .getRoomById(_roomId!)!
      .getParticipants()
      .map((participant) => participant.id)
      .toList();

  @override
  void onSubmit() async {
    if (isContainsExternal) {
      performInvite();
      return;
    }
    if (OkCancelResult.ok ==
        await showOkCancelAlertDialog(
          context: context,
          title: L10n.of(context)!.inviteContactToGroup(
            _room.getLocalizedDisplayname(
              MatrixLocals(L10n.of(context)!),
            ),
          ),
          okLabel: L10n.of(context)!.yes,
          cancelLabel: L10n.of(context)!.cancel,
        )) {
      performInvite();
    }
  }

  void performInvite() async {
    final selectedContacts = selectedContactsMapNotifier.contactsList
        .map((contact) => contact.matrixId!)
        .toList();
    final success = await showFutureLoadingDialog(
      context: context,
      future: () => Future.wait(
        selectedContacts.map((id) => _room.invite(id)),
      ),
    );
    if (success.error == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(L10n.of(context)!.contactHasBeenInvitedToTheGroup),
        ),
      );
      onCloseDialogInvite();
      inviteSuccessAction();
    }
  }

  void inviteSuccessAction() {
    context.pop();
  }

  void onCloseDialogInvite() {
    FluffyChatApp.router.routerDelegate.pop();
  }

  @override
  Widget build(BuildContext context) => ContactsSelectionView(this);
}
