import 'package:matrix/matrix.dart';

extension BacsicEventExtension on BasicEvent {
  Map<String, Object?> formatContentForwards() {
    if (content['m.relates_to'] != null) {
      content.remove('m.relates_to');
    }

    // Add a custom field to mark this as forwarded
    content['m.multi.forwarded'] = true;

    return content;
  }
}
