import 'package:fluffychat/config/multi_sys_variables/multi_colors.dart';
import 'package:fluffychat/config/multi_sys_variables/multi_sys_colors.dart';
import 'package:fluffychat/domain/app_state/contact/get_contacts_state.dart';
import 'package:fluffychat/pages/contacts_tab/empty_contacts_body.dart';
import 'package:fluffychat/pages/new_group/contacts_selection.dart';
import 'package:fluffychat/pages/new_group/contacts_selection_view_style.dart';
import 'package:fluffychat/pages/new_group/widget/contact_item.dart';
import 'package:fluffychat/pages/new_group/widget/contacts_selection_list_style.dart';
import 'package:fluffychat/pages/new_group/widget/selected_participants_list.dart';
import 'package:fluffychat/pages/new_private_chat/widget/loading_contact_widget.dart';
import 'package:fluffychat/pages/new_private_chat/widget/no_contacts_found.dart';
import 'package:fluffychat/presentation/model/contact/get_presentation_contacts_empty.dart';
import 'package:fluffychat/presentation/model/contact/get_presentation_contacts_failure.dart';
import 'package:fluffychat/presentation/model/contact/presentation_contact_success.dart';
import 'package:fluffychat/presentation/model/search/presentation_search.dart';
import 'package:fluffychat/utils/platform_infos.dart';
import 'package:fluffychat/widgets/app_bars/searchable_app_bar.dart';
import 'package:fluffychat/widgets/contacts_warning_banner/contacts_warning_banner_view.dart';
import 'package:fluffychat/widgets/phone_book_loading/phone_book_loading_view.dart';
import 'package:fluffychat/widgets/sliver_expandable_list.dart';
import 'package:fluffychat/widgets/twake_components/twake_text_button.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:linagora_design_flutter/linagora_design_flutter.dart';

class ContactsSelectionView extends StatelessWidget {
  final ContactsSelectionController controller;

  const ContactsSelectionView(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(128),
        child: SearchableAppBar(
          toolbarHeight: ContactsSelectionViewStyle.maxToolbarHeight(context),
          focusNode: controller.searchFocusNode,
          title: controller.getTitle(context),
          hintText: controller.getHintText(context),
          textEditingController: controller.textEditingController,
          openSearchBar: controller.openSearchBar,
          closeSearchBar: controller.closeSearchBar,
          isFullScreen: controller.isFullScreen,
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.50, -0.00),
            end: Alignment(0.50, 1.00),
            colors: [
              Color(0xFF0E0F13),
              Color(0xFF191B26),
            ],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ValueListenableBuilder<bool>(
                valueListenable: controller
                    .selectedContactsMapNotifier.haveSelectedContactsNotifier,
                builder: (context, haveSelectedContact, child) {
                  return child!;
                },
                child: Padding(
                  padding:
                      const EdgeInsetsDirectional.symmetric(horizontal: 12.0),
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: ContactsWarningBannerView(
                          warningBannerNotifier:
                              controller.warningBannerNotifier,
                          closeContactsWarningBanner:
                              controller.closeContactsWarningBanner,
                          goToSettingsForPermissionActions: () => controller
                              .displayContactPermissionDialog(context),
                        ),
                      ),
                      _sliverPhonebookLoading(),
                      SliverToBoxAdapter(
                        child: SelectedParticipantsList(
                          contactsSelectionController: controller,
                        ),
                      ),
                      _sliverRecentContacts(),
                      _sliverOmniUserSearch(),
                      _sliverContactsList(),
                      if (PlatformInfos.isMobile) _sliverPhonebookList(),
                      if (PlatformInfos.isWeb) _sliverAddressBookListOnWeb(),
                    ],
                  ),
                ),
              ),
            ),
            if (!controller.isFullScreen) _webActionButton(context),
          ],
        ),
      ),
      bottomNavigationBar: controller.isFullScreen
          ? ValueListenableBuilder(
              valueListenable: controller
                  .selectedContactsMapNotifier.haveSelectedContactsNotifier,
              builder: (context, haveSelectedContacts, child) {
                if (!haveSelectedContacts) {
                  return const SizedBox.shrink();
                }
                return child!;
              },
              child: Container(
                height: 106,
                padding: const EdgeInsetsDirectional.only(
                  top: 18.0,
                  bottom: 40.0,
                  start: 20.0,
                  end: 20.0,
                ),
                decoration: ShapeDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  shape: const RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1,
                      color: Color(0x4C738C96),
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    _bottomActionButton(
                      context: context,
                      label: 'Reset',
                      onTap: controller
                          .selectedContactsMapNotifier.unselectAllContacts,
                      backgroundColor:
                          MultiColors.of(context).buttonsMainSecondary15Opasity,
                      foregroundColor:
                          Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                    const SizedBox(width: 12),
                    _bottomActionButton(
                      context: context,
                      label: controller.submitText,
                      onTap: () => controller.trySubmit(context),
                      backgroundColor:
                          MultiColors.of(context).buttonsMainPrimaryDefault,
                      foregroundColor:
                          MultiColors.of(context).textReversedPrimary,
                    ),
                  ],
                ),
              ),
            )
          : null,
    );
  }

  Widget _bottomActionButton({
    required BuildContext context,
    required String label,
    required VoidCallback onTap,
    required Color backgroundColor,
    required Color foregroundColor,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          ),
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 13.0),
          child: Text(
            label,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: foregroundColor,
                ),
          ),
        ),
      ),
    );
  }

  Widget _sliverPhonebookLoading() {
    return ValueListenableBuilder(
      valueListenable: controller.contactsManager.progressPhoneBookState,
      builder: (context, progressValue, _) {
        if (progressValue != null) {
          return SliverToBoxAdapter(
            child: PhoneBookLoadingView(progress: progressValue),
          );
        }
        return const SliverToBoxAdapter(
          child: SizedBox.shrink(),
        );
      },
    );
  }

  Widget _sliverRecentContacts() {
    return ValueListenableBuilder(
      valueListenable: controller.presentationContactNotifier,
      builder: (context, state, child) {
        return state.fold(
          (failure) => child!,
          (success) {
            if (success is ContactsLoading) {
              return const SliverToBoxAdapter(
                child: SizedBox(),
              );
            }
            return child!;
          },
        );
      },
      child: ValueListenableBuilder(
        valueListenable: controller.presentationRecentContactNotifier,
        builder: (context, recentContacts, child) {
          if (recentContacts.isEmpty) {
            return child!;
          }
          return SliverExpandableList(
            title: L10n.of(context)!.recent,
            itemCount: recentContacts.length,
            itemBuilder: (context, index) {
              final disabled = controller.disabledContactIds.contains(
                recentContacts[index].directChatMatrixID,
              );
              return ContactItem(
                contact: recentContacts[index].toPresentationContact(),
                selectedContactsMapNotifier:
                    controller.selectedContactsMapNotifier,
                onSelectedContact: controller.onSelectedContact,
                highlightKeyword: controller.textEditingController.text,
                disabled: disabled,
              );
            },
          );
        },
        child: const SliverToBoxAdapter(
          child: SizedBox(),
        ),
      ),
    );
  }

  Widget _sliverOmniUserSearch() {
    return ValueListenableBuilder<List<OmniUserPresentationSearch>>(
      valueListenable:
          controller.omniUserSearchController.omniUserSearchNotifier,
      builder: (context, omniUserSearchResults, child) {
        if (omniUserSearchResults.isEmpty) {
          return const SliverToBoxAdapter(child: SizedBox());
        }
        return SliverExpandableList(
          title: L10n.of(context)!.contactsCount(omniUserSearchResults.length),
          itemCount: omniUserSearchResults.length,
          itemBuilder: (context, index) {
            final omniUser = omniUserSearchResults[index];
            final disabled = controller.disabledContactIds.contains(
              omniUser.matrixUserId,
            );

            return ContactItem(
              contact: omniUser.toPresentationContact(),
              selectedContactsMapNotifier:
                  controller.selectedContactsMapNotifier,
              onSelectedContact: controller.onSelectedContact,
              highlightKeyword: controller.textEditingController.text,
              disabled: disabled,
              paddingTop:
                  index == 0 ? ContactsSelectionListStyle.listPaddingTop : 0,
            );
          },
        );
      },
    );
  }

  Widget _sliverContactsList() {
    final recentContact =
        controller.presentationRecentContactNotifier.value.isEmpty;

    return ValueListenableBuilder(
      valueListenable: controller.presentationContactNotifier,
      builder: (context, state, child) {
        return state.fold(
          (failure) {
            if (PlatformInfos.isMobile) {
              return child!;
            }
            final presentationRecentContact =
                controller.presentationRecentContactNotifier.value;
            if (presentationRecentContact.isNotEmpty) {
              return child!;
            }
            if (PlatformInfos.isWeb) {
              return controller.presentationAddressBookNotifier.value.fold(
                (_) {
                  if (controller.presentationAddressBookNotifier.value
                      .isRight()) {
                    return child!;
                  }
                  if (failure is GetPresentationContactsFailure ||
                      failure is GetPresentationContactsEmpty) {
                    final keyword = controller.textEditingController.text;
                    if (keyword.isEmpty) {
                      return const SliverToBoxAdapter(
                        child: EmptyContactBody(),
                      );
                    } else {
                      return SliverToBoxAdapter(
                        child: Padding(
                          padding: ContactsSelectionListStyle.notFoundPadding,
                          child: NoContactsFound(
                            keyword:
                                controller.textEditingController.text.isEmpty
                                    ? null
                                    : controller.textEditingController.text,
                          ),
                        ),
                      );
                    }
                  }
                  return child!;
                },
                (success) => child!,
              );
            } else {
              return controller.presentationPhonebookContactNotifier.value.fold(
                (_) {
                  if (controller.presentationPhonebookContactNotifier.value
                      .isRight()) {
                    return child!;
                  }
                  if (failure is GetPresentationContactsFailure ||
                      failure is GetPresentationContactsEmpty) {
                    final keyword = controller.textEditingController.text;
                    if (keyword.isEmpty) {
                      return const SliverToBoxAdapter(
                        child: EmptyContactBody(),
                      );
                    } else {
                      return SliverToBoxAdapter(
                        child: Padding(
                          padding: ContactsSelectionListStyle.notFoundPadding,
                          child: NoContactsFound(
                            keyword: controller.textEditingController.text,
                          ),
                        ),
                      );
                    }
                  }
                  return child!;
                },
                (success) => child!,
              );
            }
          },
          (success) {
            if (success is ContactsLoading) {
              return const SliverToBoxAdapter(
                child: LoadingContactWidget(),
              );
            }

            if (success is PresentationExternalContactSuccess &&
                recentContact) {
              if (controller
                  .presentationRecentContactNotifier.value.isNotEmpty) {
                return child!;
              }
              if (PlatformInfos.isWeb) {
                if (controller.presentationAddressBookNotifier.value
                    .isRight()) {
                  return child!;
                }
              } else {
                if (controller.presentationPhonebookContactNotifier.value
                    .isRight()) {
                  return child!;
                }
              }
              return SliverToBoxAdapter(
                child: ContactItem(
                  contact: success.contact,
                  selectedContactsMapNotifier:
                      controller.selectedContactsMapNotifier,
                  onSelectedContact: controller.onSelectedContact,
                  highlightKeyword: controller.textEditingController.text,
                  disabled: false,
                ),
              );
            }

            if (success is PresentationContactsSuccess) {
              final contacts = success.contacts;
              if (contacts.isEmpty &&
                  controller.textEditingController.text.isNotEmpty) {
                return SliverToBoxAdapter(
                  child: Padding(
                    padding: ContactsSelectionListStyle.notFoundPadding,
                    child: NoContactsFound(
                      keyword: controller.textEditingController.text,
                    ),
                  ),
                );
              }
              return SliverExpandableList(
                title: L10n.of(context)!.linagoraContactsCount(contacts.length),
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  final disabled = controller.disabledContactIds.contains(
                    contacts[index].matrixId,
                  );
                  return ContactItem(
                    contact: contacts[index],
                    selectedContactsMapNotifier:
                        controller.selectedContactsMapNotifier,
                    onSelectedContact: controller.onSelectedContact,
                    highlightKeyword: controller.textEditingController.text,
                    disabled: disabled,
                    paddingTop: index == 0
                        ? ContactsSelectionListStyle.listPaddingTop
                        : 0,
                  );
                },
              );
            }

            return child!;
          },
        );
      },
      child: const SliverToBoxAdapter(
        child: SizedBox(),
      ),
    );
  }

  Widget _sliverPhonebookList() {
    return ValueListenableBuilder(
      valueListenable: controller.presentationPhonebookContactNotifier,
      builder: (context, phonebookContactState, child) {
        return phonebookContactState.fold(
          (failure) {
            if (!PlatformInfos.isMobile) {
              return child!;
            }
            final presentationRecentContact =
                controller.presentationRecentContactNotifier.value;
            if (failure is GetPresentationContactsFailure) {
              if (presentationRecentContact.isEmpty) {
                return controller.presentationContactNotifier.value.fold(
                  (failure) {
                    if (failure is GetPresentationContactsFailure ||
                        failure is GetPresentationContactsEmpty) {
                      return SliverToBoxAdapter(
                        child: Padding(
                          padding: ContactsSelectionListStyle.notFoundPadding,
                          child: NoContactsFound(
                            keyword:
                                controller.textEditingController.text.isEmpty
                                    ? null
                                    : controller.textEditingController.text,
                          ),
                        ),
                      );
                    }
                    return child!;
                  },
                  (_) => child!,
                );
              }
            }
            if (failure is GetPresentationContactsEmpty) {
              if (presentationRecentContact.isEmpty) {
                return controller.presentationContactNotifier.value.fold(
                  (failure) {
                    if (failure is GetPresentationContactsFailure ||
                        failure is GetPresentationContactsEmpty) {
                      if (controller.textEditingController.text.isEmpty) {
                        return const SliverToBoxAdapter(
                          child: EmptyContactBody(),
                        );
                      } else {
                        return SliverToBoxAdapter(
                          child: Padding(
                            padding: ContactsSelectionListStyle.notFoundPadding,
                            child: NoContactsFound(
                              keyword: controller.textEditingController.text,
                            ),
                          ),
                        );
                      }
                    }
                    return child!;
                  },
                  (_) => child!,
                );
              }
            }
            return child!;
          },
          (success) {
            if (success is PresentationContactsSuccess) {
              final contacts = success.contacts;
              return SliverExpandableList(
                title: L10n.of(context)!.linagoraContactsCount(contacts.length),
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  if (contacts[index].matrixId != null &&
                      contacts[index].matrixId!.isNotEmpty) {
                    final disabled = controller.disabledContactIds.contains(
                      contacts[index].matrixId,
                    );
                    return ContactItem(
                      contact: contacts[index],
                      selectedContactsMapNotifier:
                          controller.selectedContactsMapNotifier,
                      onSelectedContact: controller.onSelectedContact,
                      highlightKeyword: controller.textEditingController.text,
                      disabled: disabled,
                      paddingTop: index == 0
                          ? ContactsSelectionListStyle.listPaddingTop
                          : 0,
                    );
                  }
                  return const SizedBox();
                },
              );
            }
            return child!;
          },
        );
      },
      child: const SliverToBoxAdapter(
        child: SizedBox(),
      ),
    );
  }

  Widget _sliverAddressBookListOnWeb() {
    return ValueListenableBuilder(
      valueListenable: controller.presentationAddressBookNotifier,
      builder: (context, phonebookContactState, child) {
        return phonebookContactState.fold(
          (failure) {
            if (!PlatformInfos.isMobile) {
              return child!;
            }
            final presentationRecentContact =
                controller.presentationRecentContactNotifier.value;
            if (failure is GetPresentationContactsFailure) {
              if (presentationRecentContact.isEmpty) {
                return controller.presentationContactNotifier.value.fold(
                  (failure) {
                    if (failure is GetPresentationContactsFailure ||
                        failure is GetPresentationContactsEmpty) {
                      return SliverToBoxAdapter(
                        child: Padding(
                          padding: ContactsSelectionListStyle.notFoundPadding,
                          child: NoContactsFound(
                            keyword:
                                controller.textEditingController.text.isEmpty
                                    ? null
                                    : controller.textEditingController.text,
                          ),
                        ),
                      );
                    }
                    return child!;
                  },
                  (_) => child!,
                );
              }
            }
            if (failure is GetPresentationContactsEmpty) {
              if (presentationRecentContact.isEmpty) {
                return controller.presentationContactNotifier.value.fold(
                  (failure) {
                    if (failure is GetPresentationContactsFailure ||
                        failure is GetPresentationContactsEmpty) {
                      if (controller.textEditingController.text.isEmpty) {
                        return const SliverToBoxAdapter(
                          child: EmptyContactBody(),
                        );
                      } else {
                        return SliverToBoxAdapter(
                          child: Padding(
                            padding: ContactsSelectionListStyle.notFoundPadding,
                            child: NoContactsFound(
                              keyword: controller.textEditingController.text,
                            ),
                          ),
                        );
                      }
                    }
                    return child!;
                  },
                  (_) => child!,
                );
              }
            }
            return child!;
          },
          (success) {
            if (success is PresentationContactsSuccess) {
              final contacts = success.contacts;
              return SliverExpandableList(
                title: L10n.of(context)!.linagoraContactsCount(contacts.length),
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  if (contacts[index].matrixId != null &&
                      contacts[index].matrixId!.isNotEmpty) {
                    final disabled = controller.disabledContactIds.contains(
                      contacts[index].matrixId,
                    );
                    return ContactItem(
                      contact: contacts[index],
                      selectedContactsMapNotifier:
                          controller.selectedContactsMapNotifier,
                      onSelectedContact: controller.onSelectedContact,
                      highlightKeyword: controller.textEditingController.text,
                      disabled: disabled,
                      paddingTop: index == 0
                          ? ContactsSelectionListStyle.listPaddingTop
                          : 0,
                    );
                  }
                  return child!;
                },
              );
            }
            return child!;
          },
        );
      },
      child: const SliverToBoxAdapter(
        child: SizedBox(),
      ),
    );
  }

  Widget _webActionButton(BuildContext context) {
    return Padding(
      padding: ContactsSelectionViewStyle.webActionsButtonPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TwakeTextButton(
            onTap: () => Navigator.of(context).pop(),
            message: L10n.of(context)!.cancel,
            borderHover: ContactsSelectionViewStyle.webActionsButtonBorder,
            margin: ContactsSelectionViewStyle.webActionsButtonMargin,
            buttonDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                ContactsSelectionViewStyle.webActionsButtonBorder,
              ),
            ),
            styleMessage: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: MultiSysColors.material().primary,
                ),
          ),
          const SizedBox(width: 8.0),
          ValueListenableBuilder<bool>(
            valueListenable: controller
                .selectedContactsMapNotifier.haveSelectedContactsNotifier,
            builder: (context, haveSelectedContacts, _) {
              return TwakeTextButton(
                onTap: () =>
                    haveSelectedContacts ? controller.trySubmit(context) : null,
                message: L10n.of(context)!.add,
                margin: ContactsSelectionViewStyle.webActionsButtonMargin,
                borderHover: ContactsSelectionViewStyle.webActionsButtonBorder,
                buttonDecoration: BoxDecoration(
                  color: haveSelectedContacts
                      ? MultiSysColors.material().primary
                      : LinagoraStateLayer(
                          MultiSysColors.material().onSurface,
                        ).opacityLayer2,
                  borderRadius: BorderRadius.circular(
                    ContactsSelectionViewStyle.webActionsButtonBorder,
                  ),
                ),
                styleMessage: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: haveSelectedContacts
                          ? MultiSysColors.material().onPrimary
                          : MultiSysColors.material()
                              .inverseSurface
                              .withOpacity(0.6),
                    ),
              );
            },
          ),
        ],
      ),
    );
  }
}
