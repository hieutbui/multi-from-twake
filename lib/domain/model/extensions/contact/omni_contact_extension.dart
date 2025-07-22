import 'package:fluffychat/domain/model/contact/contact.dart';
import 'package:fluffychat/domain/model/contact/omni_contact.dart';

extension OmniContactExtension on OmniContact {
  Contact toContact() {
    return Contact(
      id: matrixUserId,
      emails: const {},
      displayName: displayName,
    );
  }
}
