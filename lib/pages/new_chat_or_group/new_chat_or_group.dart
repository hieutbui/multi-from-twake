import 'package:fluffychat/pages/new_chat_or_group/new_chat_or_group_view.dart';
import 'package:fluffychat/presentation/mixins/contacts_view_controller_mixin.dart';
import 'package:fluffychat/presentation/mixins/go_to_direct_chat_mixin.dart';
import 'package:fluffychat/presentation/mixins/go_to_group_chat_mixin.dart';
import 'package:fluffychat/presentation/mixins/invite_external_contact_mixin.dart';
import 'package:fluffychat/presentation/model/contact/presentation_contact.dart';
import 'package:fluffychat/presentation/model/search/presentation_search.dart';
import 'package:fluffychat/widgets/matrix.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:matrix/matrix.dart';

class NewChatOrGroup extends StatefulWidget {
  const NewChatOrGroup({super.key});

  @override
  State<NewChatOrGroup> createState() => NewChatOrGroupController();
}

class NewChatOrGroupController extends State<NewChatOrGroup>
    with
        ContactsViewControllerMixin,
        GoToGroupChatMixin,
        GoToDraftChatMixin,
        InviteExternalContactMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onBackPress() {
    context.pop();
  }

  void onContactAction(
    BuildContext context,
    PresentationContact contact,
  ) async {
    if (contact.matrixId == null || contact.matrixId?.isEmpty == true) {
      Logs().e('NewPrivateChatController::onContactAction: no MatrixId');
      return;
    }
    final roomId =
        Matrix.of(context).client.getDirectChatFromUserId(contact.matrixId!);
    if (roomId == null) {
      goToDraftChat(
        context: context,
        path: 'rooms',
        contactPresentationSearch: ContactPresentationSearch(
          matrixId: contact.matrixId,
          displayName: contact.displayName,
        ),
      );
    } else {
      context.push('/rooms/$roomId');
    }
  }

  void onExternalContactAction(
    BuildContext context,
    PresentationContact contact,
  ) {
    showInviteExternalContactDialog(context, () {
      onContactAction(
        context,
        contact,
      );
    });
  }

  @override
  Widget build(BuildContext context) => NewChatOrGroupView(
        controller: this,
      );
}
