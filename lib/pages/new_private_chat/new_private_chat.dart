import 'package:fluffychat/config/first_column_inner_routes.dart';
import 'package:fluffychat/mixin/comparable_presentation_contact_mixin.dart';
import 'package:fluffychat/mixin/invite_external_contact_mixin.dart';
import 'package:fluffychat/pages/new_private_chat/new_private_chat_view.dart';
import 'package:fluffychat/presentation/mixins/contact_manager_mixin.dart';
import 'package:fluffychat/presentation/mixins/go_to_direct_chat_mixin.dart';
import 'package:fluffychat/presentation/model/presentation_contact.dart';
import 'package:fluffychat/presentation/model/search/presentation_search.dart';
import 'package:fluffychat/utils/extension/build_context_extension.dart';
import 'package:fluffychat/widgets/matrix.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NewPrivateChat extends StatefulWidget {
  const NewPrivateChat({Key? key}) : super(key: key);

  @override
  NewPrivateChatController createState() => NewPrivateChatController();
}

class NewPrivateChatController extends State<NewPrivateChat>
    with
        ComparablePresentationContactMixin,
        GoToDraftChatMixin,
        ContactManagerMixin,
        InviteExternalContactMixin {
  final isShowContactsNotifier = ValueNotifier(true);
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    initSearchExternalContacts();
    // FIXME: Find out solution for disable load more in search
    // searchContactsController.onSearchKeywordChanged = (searchKey) {
    //   disableLoadMoreInSearch();
    // };
  }

  void toggleContactsList() {
    isShowContactsNotifier.value = !isShowContactsNotifier.value;
  }

  void goToNewGroupChat() {
    if (!FirstColumnInnerRoutes.instance.goRouteAvailableInFirstColumn()) {
      context.pushInner('innernavigator/newgroup');
    } else {
      context.push('/rooms/newprivatechat/newgroup');
    }
  }

  void onContactAction(
    BuildContext context,
    PresentationContact contact,
  ) async {
    final roomId =
        Matrix.of(context).client.getDirectChatFromUserId(contact.matrixId!);
    if (roomId == null) {
      goToDraftChat(
        context: context,
        path: 'rooms',
        contactPresentationSearch: ContactPresentationSearch(
          contact.matrixId,
          contact.email,
          displayName: contact.displayName,
        ),
      );
    } else {
      context.go('/rooms/$roomId');
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
  void dispose() {
    super.dispose();
    disposeSearchContacts();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) => NewPrivateChatView(this);
}
