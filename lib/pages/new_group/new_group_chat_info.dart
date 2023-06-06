import 'package:fluffychat/presentation/model/presentation_contact.dart';
import 'package:fluffychat/pages/new_group/new_group.dart';
import 'package:fluffychat/pages/new_group/new_group_info_controller.dart';
import 'package:fluffychat/pages/new_group/widget/expansion_participants_list.dart';
import 'package:fluffychat/widgets/setting_tile.dart';
import 'package:fluffychat/widgets/twake_components/twake_fab.dart';
import 'package:fluffychat/widgets/twake_components/twake_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:linagora_design_flutter/colors/linagora_ref_colors.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';


class NewGroupChatInfo extends StatelessWidget {

  final Set<PresentationContact> contactsList;

  final NewGroupController newGroupController;

  const NewGroupChatInfo({
    super.key,
    required this.contactsList,
    required this.newGroupController,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
        child: Column(
          children: [
            _buildChangeProfileWidget(context),
            const SizedBox(height: 16.0,),
            Text(L10n.of(context)!.addAPhoto,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            Text(L10n.of(context)!.maxImageSize(5),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: LinagoraRefColors.material().neutral[40],
              ),),
            const SizedBox(height: 32,),
            _buildGroupNameTextFieid(context),
            const SizedBox(height: 16,),
            _buildSettings(context),
            Expanded(
              child: ExpansionParticipantsList(contactsList: contactsList,),
            ),
          ],
        ),
      ),
      floatingActionButton: ValueListenableBuilder<bool>(
        valueListenable: newGroupController.haveGroupNameNotifier, 
        builder: (context, value, child) {
          if (!value) {
            return const SizedBox.shrink();
          }
          return child!;
        },
        child: TwakeFloatingActionButton(
          icon: Icons.done,
          onTap: () => newGroupController.moveToGroupChatScreen(),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(64.0),
      child: AppBar(
        toolbarHeight: 64,
        leading: TwakeIconButton(
          icon: Icons.arrow_back,
          onPressed: () => Navigator.of(context).pop(),
          tooltip: L10n.of(context)!.back,
          paddingAll: 8.0,
          margin: const EdgeInsets.symmetric(
            vertical: 12.0,
            horizontal: 8.0,
          ),
        ),
        title: Text(
          L10n.of(context)!.newGroupChat,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        titleSpacing: 0,
        centerTitle: false,
        leadingWidth: 64,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.black.withOpacity(0.15))),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  offset: const Offset(0, 1),
                  blurRadius: 80,
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  offset: const Offset(0, 1),
                  blurRadius: 3,
                  spreadRadius: 0.5,
                ),
              ],
            ),
          )),
      ),
    );
  }

  Widget _buildChangeProfileWidget(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: LinagoraRefColors.material().neutral[80],
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Icon(Icons.camera_alt_outlined,
          color: Theme.of(context).colorScheme.surface,
        ),
      ),
    );
  }

  Widget _buildGroupNameTextFieid(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextField(
        controller: newGroupController.groupNameTextEditingController,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).colorScheme.shadow),
          ),
          labelText: L10n.of(context)!.widgetName,
          labelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontSize: 16,
            letterSpacing: 0.4,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          hintText: L10n.of(context)!.enterGroupName,
          hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
            letterSpacing: -0.15,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          contentPadding: const EdgeInsets.all(16.0),
        ),
      ),
    );
  }

  Widget _buildSettings(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        children: [
          SettingTile(
            key: UniqueKey(),
            leadingIcon: Icons.back_hand_outlined,
            settingTitle: L10n.of(context)!.makeThisGroupPrivate,
            settingDescription: L10n.of(context)!.groupPrivateDescription,
            onSwitchButtonChanged: (valueChanged) 
              => newGroupController.onGroupPrivacyChanged(valueChanged),
            defaultSwitchValue: newGroupController.isGroupPrivate,
          ),
          ValueListenableBuilder<bool>(
            valueListenable: newGroupController.isEnableEEEncryptionNotifier,
            builder: (context, value, child) {
              return SettingTile(
                key: UniqueKey(),
                leadingIcon: Icons.lock_outline,
                settingTitle: L10n.of(context)!.enableE2EEncryption,
                onSwitchButtonChanged: ((valueChanged) => {}),
                isEditable: false,
                defaultSwitchValue: value,
              );
            },
          )
        ],
      ),
    );
  }
}