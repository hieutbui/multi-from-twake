import 'package:fluffychat/config/multi_sys_variables/multi_colors.dart';
import 'package:fluffychat/config/multi_sys_variables/multi_typography.dart';
import 'package:fluffychat/pages/new_chat_or_group/new_chat_or_group.dart';
import 'package:fluffychat/pages/new_chat_or_group/widget/create_new_chat_or_group_button.dart';
import 'package:fluffychat/pages/new_private_chat/new_private_chat_style.dart';
import 'package:fluffychat/pages/new_private_chat/widget/expansion_list.dart';
import 'package:fluffychat/widgets/contacts_warning_banner/contacts_warning_banner_view.dart';
import 'package:fluffychat/widgets/phone_book_loading/phone_book_loading_view.dart';
import 'package:fluffychat/widgets/twake_components/twake_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class NewChatOrGroupView extends StatelessWidget {
  final NewChatOrGroupController controller;

  const NewChatOrGroupView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const ShapeDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.50, -0.00),
              end: Alignment(0.50, 1.00),
              colors: [
                Color(0xFF0E0F13),
                Color(0xFF232631),
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
          ),
        ),
        backgroundColor: Colors.black.withOpacity(0.5),
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Row(
            children: [
              _buildBackButton(context),
              Expanded(
                child: Text(
                  'New chat or group',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontSize: MultiMobileTypography.headlineFontSmall,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                ),
              ),
              const SizedBox(
                width: 48.0,
              ),
            ],
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsetsDirectional.only(
          top: 12.0,
          start: 12.0,
          end: 12.0,
        ),
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
            CreateNewChatOrGroupButton(
              title: 'Create new group',
              subTitle: 'Lorem ipsum',
              onTap: () => controller.goToNewGroupChat(context),
            ),
            const SizedBox(height: 12.0),
            CreateNewChatOrGroupButton(
              title: 'Create new channel',
              subTitle: 'Lorem ipsum',
              onTap: () {},
            ),
            const SizedBox(height: 12.0),
            CreateNewChatOrGroupButton(
              title: 'Add new contact',
              subTitle: 'Lorem ipsum',
              onTap: () {},
            ),
            Padding(
              padding: NewPrivateChatStyle.paddingWarningBanner,
              child: ContactsWarningBannerView(
                warningBannerNotifier: controller.warningBannerNotifier,
                closeContactsWarningBanner:
                    controller.closeContactsWarningBanner,
                goToSettingsForPermissionActions: () =>
                    controller.displayContactPermissionDialog(context),
                isShowMargin: false,
              ),
            ),
            _phonebookLoading(),
            Expanded(
              child: ExpansionList(
                client: controller.client,
                presentationRecentContactNotifier:
                    controller.presentationRecentContactNotifier,
                presentationContactsNotifier:
                    controller.presentationContactNotifier,
                presentationPhonebookContactNotifier:
                    controller.presentationPhonebookContactNotifier,
                presentationAddressBookNotifier:
                    controller.presentationAddressBookNotifier,
                goToNewGroupChat: () => controller.goToNewGroupChat(context),
                onContactTap: controller.onContactAction,
                onExternalContactTap: controller.onExternalContactAction,
                textEditingController: controller.textEditingController,
                warningBannerNotifier: controller.warningBannerNotifier,
                closeContactsWarningBanner:
                    controller.closeContactsWarningBanner,
                goToSettingsForPermissionActions: () =>
                    controller.displayContactPermissionDialog(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) => Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 12.0),
        child: TwakeIconButton(
          tooltip: L10n.of(context)!.back,
          icon: Icons.arrow_back,
          size: 16.0,
          onTap: controller.onBackPress,
          margin: const EdgeInsets.symmetric(vertical: 12.0),
          buttonDecoration: BoxDecoration(
            color: MultiColors.of(context).buttonsMainSecondary15Opasity,
            shape: BoxShape.circle,
          ),
        ),
      );

  Widget _phonebookLoading() {
    return ValueListenableBuilder(
      valueListenable: controller.contactsManager.progressPhoneBookState,
      builder: (context, progressValue, _) {
        if (progressValue != null) {
          return PhoneBookLoadingView(progress: progressValue);
        }
        return const SizedBox.shrink();
      },
    );
  }
}
