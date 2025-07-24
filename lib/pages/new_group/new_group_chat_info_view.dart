import 'package:dartz/dartz.dart';
import 'package:fluffychat/app_state/failure.dart';
import 'package:fluffychat/app_state/success.dart';
import 'package:fluffychat/config/app_config.dart';
import 'package:fluffychat/config/multi_sys_variables/multi_colors.dart';
import 'package:fluffychat/config/multi_sys_variables/multi_typography.dart';
import 'package:fluffychat/pages/new_group/new_group_chat_info.dart';
import 'package:fluffychat/pages/new_group/new_group_chat_info_style.dart';
import 'package:fluffychat/pages/new_group/widget/expansion_participants_list.dart';
import 'package:fluffychat/presentation/model/pick_avatar_state.dart';
import 'package:fluffychat/utils/matrix_sdk_extensions/int_extension.dart';
import 'package:fluffychat/widgets/context_menu_builder_ios_paste_without_permission.dart';
import 'package:fluffychat/widgets/stream_image_view.dart';
import 'package:fluffychat/widgets/twake_components/twake_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:linagora_design_flutter/linagora_design_flutter.dart';
import 'package:matrix/matrix.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';

class NewGroupChatInfoView extends StatelessWidget {
  final NewGroupChatInfoController newGroupInfoController;

  const NewGroupChatInfoView(
    this.newGroupInfoController, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      appBar: _buildAppBar(context),
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
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Padding(
                        padding: NewGroupChatInfoStyle.profilePadding,
                        child: _buildChangeProfileWidget(context),
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        L10n.of(context)!.addAPhoto,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                      ),
                      Text(
                        L10n.of(context)!.maxImageSize(
                          AppConfig.defaultMaxUploadAvtarSizeInBytes
                              .bytesToMBInt(),
                        ),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: LinagoraRefColors.material().neutral[40],
                            ),
                      ),
                      const SizedBox(height: 32),
                      _buildGroupNameTextField(context),
                      const SizedBox(height: 16),
                      _EncryptionSettingTile(
                        enableEncryptionNotifier:
                            newGroupInfoController.enableEncryptionNotifier,
                        onChanged: (value) {
                          newGroupInfoController.toggleEnableEncryption();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: Padding(
            padding: NewGroupChatInfoStyle.padding,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: ExpansionParticipantsList(
                    contactsList: newGroupInfoController.contactsList ?? {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: ValueListenableBuilder<bool>(
        valueListenable: newGroupInfoController.haveGroupNameNotifier,
        builder: (context, value, child) {
          if (!value) {
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
          child: ValueListenableBuilder<Either<Failure, Success>>(
            valueListenable: newGroupInfoController.createRoomStateNotifier,
            builder: (context, value, child) {
              return InkWell(
                onTap: newGroupInfoController.onTapNext,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.light
                        ? MultiLightColors.buttonsMainPrimaryDefault
                        : MultiDarkColors.buttonsMainPrimaryDefault,
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                  ),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 13.0),
                  child: newGroupInfoController.isCreatingRoom
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                          ),
                        )
                      : Text(
                          'Next',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? MultiLightColors.textReversedPrimary
                                        : MultiDarkColors.textReversedPrimary,
                                  ),
                        ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(
        NewGroupChatInfoStyle.toolbarHeight,
      ),
      child: AppBar(
        backgroundColor: Colors.black.withOpacity(0.5),
        automaticallyImplyLeading: false,
        toolbarHeight: NewGroupChatInfoStyle.toolbarHeight,
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
        title: Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Row(
            children: [
              _buildBackButton(context),
              Expanded(
                child: Text(
                  'New group',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontSize: MultiMobileTypography.headlineFontSmall,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                ),
              ),
              const SizedBox(
                width: 64.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChangeProfileWidget(BuildContext context) {
    return InkWell(
      onTap: () =>
          newGroupInfoController.showImagesPickerAction(context: context),
      customBorder: const CircleBorder(),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.51,
        height: MediaQuery.of(context).size.height * 0.24,
        decoration: BoxDecoration(
          color: LinagoraRefColors.material().neutral[80],
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: NewGroupChatInfoStyle.responsive.isMobile(context)
            ? _AvatarForMobileBuilder(
                avatarMobileNotifier:
                    newGroupInfoController.avatarAssetEntityNotifier,
              )
            : _AvatarForWebBuilder(
                avatarWebNotifier: newGroupInfoController.pickAvatarUIState,
                onImageLoaded: newGroupInfoController.updateAvatarFilePicker,
              ),
      ),
    );
  }

  Widget _buildGroupNameTextField(BuildContext context) {
    return Padding(
      padding: NewGroupChatInfoStyle.groupNameTextFieldPadding,
      child: ValueListenableBuilder(
        valueListenable: newGroupInfoController.createRoomStateNotifier,
        builder: (context, value, child) {
          return ValueListenableBuilder(
            valueListenable:
                newGroupInfoController.groupNameTextEditingController,
            builder: (context, value, _) {
              return TextField(
                controller:
                    newGroupInfoController.groupNameTextEditingController,
                focusNode: newGroupInfoController.groupNameFocusNode,
                enabled: !newGroupInfoController.isCreatingRoom,
                decoration: InputDecoration(
                  labelText: L10n.of(context)!.groupName,
                  hintText: L10n.of(context)!.enterGroupName,
                ),
                contextMenuBuilder: mobileTwakeContextMenuBuilder,
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) => Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 12.0),
        child: TwakeIconButton(
          tooltip: L10n.of(context)!.back,
          icon: Icons.arrow_back,
          size: 16.0,
          onTap: () => Navigator.of(context).pop(),
          margin: const EdgeInsets.symmetric(vertical: 12.0),
          buttonDecoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.light
                ? MultiLightColors.buttonsMainSecondary15Opasity
                : MultiDarkColors.buttonsMainSecondary15Opasity,
            shape: BoxShape.circle,
          ),
        ),
      );
}

class _AvatarForMobileBuilder extends StatelessWidget {
  final ValueNotifier<AssetEntity?> avatarMobileNotifier;

  const _AvatarForMobileBuilder({
    required this.avatarMobileNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: avatarMobileNotifier,
      builder: (context, value, child) {
        if (value == null) {
          return child!;
        }
        return ClipOval(
          child: SizedBox.fromSize(
            size: Size.infinite,
            child: AssetEntityImage(
              value,
              thumbnailSize: ThumbnailSize(
                (MediaQuery.of(context).size.width * 0.51).toInt(),
                (MediaQuery.of(context).size.height * 0.24).toInt(),
              ),
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
        color: Theme.of(context).colorScheme.onPrimaryContainer,
        size: 32,
      ),
    );
  }
}

class _AvatarForWebBuilder extends StatelessWidget {
  final ValueNotifier<Either<Failure, Success>> avatarWebNotifier;
  final Function(MatrixFile) onImageLoaded;

  const _AvatarForWebBuilder({
    required this.avatarWebNotifier,
    required this.onImageLoaded,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: avatarWebNotifier,
      builder: (context, uiState, child) => uiState.fold(
        (failure) {
          if (failure is GetAvatarBigSizeUIStateFailure) {
            return child!;
          }
          return const SizedBox();
        },
        (success) {
          if (success is GetAvatarOnWebUIStateSuccess) {
            if (success.matrixFile?.readStream == null) {
              return child!;
            }
            return ClipOval(
              child: SizedBox.fromSize(
                size: const Size.fromRadius(
                  NewGroupChatInfoStyle.avatarRadiusForWeb,
                ),
                child: StreamImageViewer(
                  matrixFile: success.matrixFile!,
                  onImageLoaded: onImageLoaded,
                ),
              ),
            );
          }
          return child!;
        },
      ),
      child: Icon(
        Icons.camera_alt_outlined,
        color: Theme.of(context).colorScheme.surface,
      ),
    );
  }
}

class _EncryptionSettingTile extends StatelessWidget {
  final ValueNotifier<bool> enableEncryptionNotifier;

  final ValueChanged<bool?>? onChanged;

  const _EncryptionSettingTile({
    required this.enableEncryptionNotifier,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, bottom: 8.0, right: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Icon(
              Icons.lock,
            ),
          ),
          const SizedBox(
            width: 8.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    L10n.of(context)!.enableEncryption,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          letterSpacing: 0.15,
                        ),
                  ),
                ),
                const SizedBox(height: 4.0),
                ValueListenableBuilder<bool>(
                  valueListenable: enableEncryptionNotifier,
                  builder: (context, isEnable, child) {
                    return Column(
                      children: [
                        Text(
                          L10n.of(context)!.encryptionMessage,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                letterSpacing: 0.4,
                                color: LinagoraRefColors.material().neutral[40],
                              ),
                        ),
                        AnimatedSize(
                          alignment: Alignment.topCenter,
                          duration: const Duration(milliseconds: 50),
                          child: isEnable
                              ? Text(
                                  L10n.of(context)!.encryptionWarning,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        letterSpacing: 0.4,
                                        color:
                                            Theme.of(context).colorScheme.error,
                                      ),
                                )
                              : const SizedBox.shrink(),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          ValueListenableBuilder<bool>(
            valueListenable: enableEncryptionNotifier,
            builder: (context, isEnable, child) {
              return Checkbox(
                value: isEnable,
                onChanged: (value) => onChanged?.call(value),
              );
            },
          ),
        ],
      ),
    );
  }
}
