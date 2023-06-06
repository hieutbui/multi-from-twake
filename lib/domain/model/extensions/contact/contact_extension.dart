
import 'package:fluffychat/domain/model/contact/contact.dart';
import 'package:fluffychat/presentation/model/presentation_contact.dart';

extension ContactExtension on Contact {
  Set<PresentationContact> toPresentationContacts() {
    final listContacts = emails?.map((email) => PresentationContact(
      email: email,
      displayName: displayName,
      matrixId: matrixId,
      status: status,
    ),);

    return listContacts?.toSet() ?? {};
  }
}