import 'package:dartz/dartz.dart';
import 'package:fluffychat/app_state/failure.dart';
import 'package:fluffychat/app_state/success.dart';
import 'package:fluffychat/pages/new_group/new_group_chat_info_style.dart';
import 'package:fluffychat/pages/new_group/new_group_info_controller.dart';
import 'package:fluffychat/presentation/model/presentation_contact.dart';
import 'package:fluffychat/pages/new_group/new_group.dart';
import 'package:fluffychat/pages/new_group/widget/expansion_participants_list.dart';
import 'package:fluffychat/utils/matrix_sdk_extensions/int_extension.dart';
import 'package:fluffychat/widgets/twake_components/twake_fab.dart';
import 'package:fluffychat/widgets/twake_components/twake_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:linagora_design_flutter/colors/linagora_ref_colors.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:photo_manager/photo_manager.dart';

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
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: LayoutBuilder(
          builder: (context, constraint) {
            return ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).viewInsets.bottom,
              ),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: _buildChangeProfileWidget(context),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      L10n.of(context)!.addAPhoto,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    ),
                    FutureBuilder(
                      future: newGroupController.getServerConfig(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final maxMediaSize = snapshot.data!.mUploadSize;
                          return Text(
                            L10n.of(context)!
                                .maxImageSize(maxMediaSize!.bytesToMB()),
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                  color:
                                      LinagoraRefColors.material().neutral[40],
                                ),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                    const SizedBox(height: 32),
                    _buildGroupNameTextFieid(context),
                    const SizedBox(height: 16),
                    Expanded(
                      child: ExpansionParticipantsList(
                        newGroupController: newGroupController,
                        contactsList: contactsList,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
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
        child: ValueListenableBuilder<Either<Failure, Success>?>(
          valueListenable: newGroupController.createRoomStateNotifier,
          builder: (context, value, child) {
            if (newGroupController.isCreatingRoom) {
              return const TwakeFloatingActionButton(
                customIcon: SizedBox(child: CircularProgressIndicator()),
              );
            }
            return TwakeFloatingActionButton(
              icon: Icons.done,
              onTap: () => newGroupController.moveToGroupChatScreen(),
            );
          },
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize:
          Size.fromHeight(NewGroupChatInfoStyle.toolbarHeight(context)),
      child: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: NewGroupChatInfoStyle.toolbarHeight(context),
        title: Row(
          children: [
            TwakeIconButton(
              icon: Icons.arrow_back,
              onTap: () => Navigator.of(context).pop(),
              tooltip: L10n.of(context)!.back,
              paddingAll: 8.0,
              margin: const EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 8.0,
              ),
            ),
            Text(
              L10n.of(context)!.newGroupChat,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
        titleSpacing: 0,
        centerTitle: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.black.withOpacity(0.15)),
              ),
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
          ),
        ),
      ),
    );
  }

  Widget _buildChangeProfileWidget(BuildContext context) {
    return InkWell(
      onTap: () => newGroupController.showImagesPickerAction(context: context),
      customBorder: const CircleBorder(),
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: LinagoraRefColors.material().neutral[80],
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: ValueListenableBuilder(
          valueListenable: newGroupController.avatarNotifier,
          builder: (context, value, child) {
            if (value == null) {
              return child!;
            }
            return ClipOval(
              child: SizedBox.fromSize(
                size: const Size.fromRadius(28),
                child: AssetEntityImage(
                  value,
                  thumbnailSize: const ThumbnailSize(56, 56),
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress != null &&
                        loadingProgress.cumulativeBytesLoaded !=
                            loadingProgress.expectedTotalBytes) {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    }
                    return child;
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Icon(Icons.error_outline),
                    );
                  },
                ),
              ),
            );
          },
          child: Icon(
            Icons.camera_alt_outlined,
            color: Theme.of(context).colorScheme.surface,
          ),
        ),
      ),
    );
  }

  Widget _buildGroupNameTextFieid(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ValueListenableBuilder(
        valueListenable: newGroupController.createRoomStateNotifier,
        builder: (context, value, child) {
          return TextField(
            controller: newGroupController.groupNameTextEditingController,
            focusNode: newGroupController.groupNameFocusNode,
            enabled: !newGroupController.isCreatingRoom,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.shadow),
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
          );
        },
      ),
    );
  }
}
