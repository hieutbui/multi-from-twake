import 'package:fluffychat/pages/new_group/contacts_selection.dart';
import 'package:flutter/material.dart';

class NewFolder extends StatefulWidget {
  const NewFolder({super.key});

  @override
  NewFolderController createState() => NewFolderController();
}

class NewFolderController extends ContactsSelectionController<NewFolder> {
  @override
  String getHintText(BuildContext context) {
    return "Search";
  }

  @override
  String getTitle(BuildContext context) {
    return "New Folder";
  }

  @override
  String get submitText => "Add Chat";

  @override
  void onSubmit() {}

  @override
  void onSelectedContact() {
    textEditingController.selection = TextSelection(
      baseOffset: 0,
      extentOffset: textEditingController.text.length,
    );
  }
}
