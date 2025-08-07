import 'package:fluffychat/config/first_column_inner_routes.dart';
import 'package:fluffychat/di/global/get_it_initializer.dart';
import 'package:fluffychat/domain/new_group_member_manger/new_group_member_manager.dart';
import 'package:fluffychat/pages/new_group/contacts_selection.dart';
import 'package:fluffychat/utils/extension/build_context_extension.dart';
import 'package:fluffychat/utils/responsive/responsive_utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NewGroup extends StatefulWidget {
  const NewGroup({super.key});

  @override
  NewGroupController createState() => NewGroupController();
}

class NewGroupController extends ContactsSelectionController<NewGroup> {
  final responsiveUtils = getIt.get<ResponsiveUtils>();
  final contactSelectionManager = getIt.get<NewGroupMemberManager>();

  @override
  void initState() {
    // Sync from local selection to manager
    selectedContactsMapNotifier.addListener(_syncContactsWithManager);

    // Sync from manager to local selection
    contactSelectionManager.selectedContacts.addListener(_syncFromManager);

    super.initState();
  }

  @override
  void dispose() {
    // Remove both listeners
    selectedContactsMapNotifier.removeListener(_syncContactsWithManager);
    contactSelectionManager.selectedContacts.removeListener(_syncFromManager);
    super.dispose();
  }

  @override
  String getTitle(BuildContext context) {
    return 'New group';
  }

  @override
  String getHintText(BuildContext context) {
    return 'Search';
  }

  @override
  void onSubmit() {
    moveToNewGroupInfoScreen();
  }

  // Sync from local selection to manager
  void _syncContactsWithManager() {
    contactSelectionManager.setSelectedContactsList(contactsList.toSet());
  }

  // Sync from manager to local selection
  void _syncFromManager() {
    // Prevent circular updates
    selectedContactsMapNotifier.removeListener(_syncContactsWithManager);

    try {
      // Clear current selections
      selectedContactsMapNotifier.unselectAllContacts();

      // Update with selections from manager
      for (final contact in contactSelectionManager.selectedContacts.value) {
        if (!mounted) return;

        selectedContactsMapNotifier.onContactTileTap(context, contact);
      }
    } finally {
      // Re-attach the listener
      selectedContactsMapNotifier.addListener(_syncContactsWithManager);
    }
  }

  void moveToNewGroupInfoScreen() async {
    if (!FirstColumnInnerRoutes.instance.goRouteAvailableInFirstColumn()) {
      context.pushInner('innernavigator/newgroupchatinfo');
    } else {
      context.push('/rooms/newprivatechat/newgroup/newgroupinfo');
    }
  }
}
