import 'package:fluffychat/presentation/model/contact/presentation_contact.dart';
import 'package:flutter/material.dart';

class NewGroupMemberManager {
  final ValueNotifier<Set<PresentationContact>> selectedContacts =
      ValueNotifier<Set<PresentationContact>>({});

  void setSelectedContactsList(Set<PresentationContact> contacts) {
    // Create a new Set to ensure the reference changes
    selectedContacts.value = Set<PresentationContact>.from(contacts);
  }

  void addSelectedContact(PresentationContact contact) {
    // Create a new Set with existing elements + new contact
    final updatedSet = Set<PresentationContact>.from(selectedContacts.value);
    updatedSet.add(contact);
    selectedContacts.value = updatedSet;
  }

  void removeSelectedContact(PresentationContact contact) {
    // Create a new Set without the removed contact
    final updatedSet = Set<PresentationContact>.from(selectedContacts.value);
    updatedSet.remove(contact);
    selectedContacts.value = updatedSet;
  }

  void clearSelectedContacts() {
    // Assign an empty Set
    selectedContacts.value = {};
  }
}
