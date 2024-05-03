import 'package:dartz/dartz.dart';
import 'package:fluffychat/app_state/failure.dart';
import 'package:fluffychat/app_state/success.dart';
import 'package:fluffychat/domain/app_state/contact/lookup_match_contact_state.dart';
import 'package:fluffychat/resource/image_paths.dart';
import 'package:fluffychat/utils/clipboard.dart';
import 'package:fluffychat/utils/string_extension.dart';
import 'package:fluffychat/utils/twake_snackbar.dart';
import 'package:fluffychat/widgets/avatar/avatar.dart';
import 'package:fluffychat/widgets/avatar/avatar_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:linagora_design_flutter/avatar/round_avatar_style.dart';
import 'package:linagora_design_flutter/extensions/string_extension.dart';
import 'package:linagora_design_flutter/linagora_design_flutter.dart';

import 'package:fluffychat/pages/chat_profile_info/chat_profile_info.dart';
import 'package:fluffychat/pages/chat_profile_info/chat_profile_info_style.dart';
import 'package:fluffychat/widgets/matrix.dart';

class ProfileInfoView extends StatelessWidget {
  final ProfileInfoController controller;

  const ProfileInfoView(
    this.controller, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final user = controller.user;
    final contact = controller.widget.contact;
    return Scaffold(
      backgroundColor: LinagoraSysColors.material().onPrimary,
      appBar: AppBar(
        backgroundColor: LinagoraSysColors.material().onPrimary,
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Row(
          children: [
            Padding(
              padding: ChatProfileInfoStyle.backIconPadding,
              child: IconButton(
                onPressed: controller.widget.onBack,
                icon: controller.widget.isInStack
                    ? const Icon(Icons.arrow_back)
                    : const Icon(Icons.close),
              ),
            ),
            Text(
              L10n.of(context)!.contactInfo,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints:
                const BoxConstraints(maxWidth: ChatProfileInfoStyle.maxWidth),
            child: Builder(
              builder: (context) {
                if (contact?.matrixId != null) {
                  return FutureBuilder(
                    future: Matrix.of(context).client.getProfileFromUserId(
                          contact!.matrixId!,
                          getFromRooms: false,
                        ),
                    builder: (context, snapshot) => _Information(
                      avatarUri: snapshot.data?.avatarUrl,
                      displayName:
                          snapshot.data?.displayName ?? contact.displayName,
                      matrixId: contact.matrixId,
                      lookupContactNotifier: controller.lookupContactNotifier,
                      goToProfileShared: controller.goToProfileShared,
                      isDraftInfo: controller.widget.isDraftInfo,
                    ),
                  );
                }
                if (contact != null) {
                  return _Information(
                    displayName: contact.displayName,
                    matrixId: contact.matrixId,
                    lookupContactNotifier: controller.lookupContactNotifier,
                    goToProfileShared: controller.goToProfileShared,
                    isDraftInfo: controller.widget.isDraftInfo,
                  );
                }
                return _Information(
                  avatarUri: user?.avatarUrl,
                  displayName: user?.calcDisplayname(),
                  matrixId: user?.id,
                  lookupContactNotifier: controller.lookupContactNotifier,
                  goToProfileShared: controller.goToProfileShared,
                  isDraftInfo: controller.widget.isDraftInfo,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _Information extends StatelessWidget {

  const _Information({
    Key? key,
    this.avatarUri,
    this.displayName,
    this.matrixId,
    required this.lookupContactNotifier,
    this.goToProfileShared,
    required this.isDraftInfo,
  }) : super(key: key);

  final Uri? avatarUri;
  final String? displayName;
  final String? matrixId;
  final ValueNotifier<Either<Failure, Success>> lookupContactNotifier;
  final Function()? goToProfileShared;
  final bool isDraftInfo;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: ChatProfileInfoStyle.mainPadding,
          child: LayoutBuilder(
            builder: (context, constraints) => Builder(
              builder: (context) {
                final text = displayName?.getShortcutNameForAvatar() ?? '@';
                final placeholder = Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: text.avatarColors,
                      stops: RoundAvatarStyle.defaultGradientStops,
                    ),
                  ),
                  width: ChatProfileInfoStyle.avatarSize,
                  height: ChatProfileInfoStyle.avatarSize,
                  child: Center(
                    child: Text(
                      text,
                      style: TextStyle(
                        fontSize: ChatProfileInfoStyle.avatarFontSize,
                        color: AvatarStyle.defaultTextColor(true),
                        fontFamily: AvatarStyle.fontFamily,
                        fontWeight: AvatarStyle.fontWeight,
                      ),
                    ),
                  ),
                );
                if (avatarUri == null) {
                  return placeholder;
                }
                return Avatar(
                  mxContent: avatarUri,
                  name: displayName,
                  size: ChatProfileInfoStyle.avatarSize,
                  fontSize: ChatProfileInfoStyle.avatarFontSize,
                );
              },
            ),
          ),
        ),
        Padding(
          padding: ChatProfileInfoStyle.mainPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                displayName ?? '',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: LinagoraSysColors.material().onSurface,
                    ),
                maxLines: 2,
              ),
              Container(
                padding: ChatProfileInfoStyle.copiableContainerPadding,
                margin: ChatProfileInfoStyle.copiableContainerMargin,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: LinagoraRefColors.material().neutral[90] ??
                        Colors.black,
                  ),
                  borderRadius:
                      ChatProfileInfoStyle.copiableContainerBorderRadius,
                ),
                child: Column(
                  children: [
                    if (matrixId != null)
                      _CopiableRowWithSvgIcon(
                        iconPath: ImagePaths.icMatrixid,
                        text: matrixId!,
                      ),
                    ValueListenableBuilder(
                      valueListenable: lookupContactNotifier,
                      builder: (context, contact, child) {
                        return contact.fold(
                          (failure) => const SizedBox.shrink(),
                          (success) {
                            if (success is LookupMatchContactSuccess) {
                              return Column(
                                children: [
                                  if (success.contact.email != null) ...{
                                    const SizedBox(
                                      height: ChatProfileInfoStyle.textSpacing,
                                    ),
                                    _CopiableRowWithMaterialIcon(
                                      icon: Icons.alternate_email,
                                      text: success.contact.email!,
                                    ),
                                  },
                                  if (success.contact.phoneNumber != null) ...{
                                    const SizedBox(
                                      height: ChatProfileInfoStyle.textSpacing,
                                    ),
                                    _CopiableRowWithMaterialIcon(
                                      icon: Icons.call,
                                      text: success.contact.phoneNumber!,
                                    ),
                                  },
                                ],
                              );
                            }

                            return const SizedBox.shrink();
                          },
                        );
                      },
                      child: const SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
              if (!isDraftInfo)
                InkWell(
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: goToProfileShared,
                  child: Padding(
                    padding:
                        ChatProfileInfoStyle.titleSharedMediaAndFilesPadding,
                    child: Row(
                      children: [
                        Text(
                          L10n.of(context)!.sharedMediaAndLinks,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const Spacer(),
                        Icon(
                          Icons.arrow_forward,
                          size: 18,
                          color: LinagoraSysColors.material().onSurface,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CopiableRowWithMaterialIcon extends StatelessWidget {
  const _CopiableRowWithMaterialIcon({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(ChatProfileInfoStyle.iconPadding),
          child: Icon(
            icon,
            size: ChatProfileInfoStyle.iconSize,
            color: LinagoraSysColors.material().onSurface,
          ),
        ),
        Expanded(
          child: Padding(
            padding: ChatProfileInfoStyle.textPadding,
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: LinagoraSysColors.material().onSurface,
                  ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.content_copy,
            size: ChatProfileInfoStyle.copyIconSize,
            color: LinagoraRefColors.material().tertiary[40],
          ),
          color: LinagoraRefColors.material().tertiary[40],
          onPressed: () {
            TwakeClipboard.instance.copyText(text);
            TwakeSnackBar.show(context, L10n.of(context)!.copiedToClipboard);
          },
        ),
      ],
    );
  }
}

class _CopiableRowWithSvgIcon extends StatelessWidget {
  const _CopiableRowWithSvgIcon({
    Key? key,
    required this.iconPath,
    required this.text,
  }) : super(key: key);

  final String iconPath;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(ChatProfileInfoStyle.iconPadding),
          child: SvgPicture.asset(
            iconPath,
            width: ChatProfileInfoStyle.iconSize,
            height: ChatProfileInfoStyle.iconSize,
            colorFilter: ColorFilter.mode(
              LinagoraSysColors.material().onSurface,
              BlendMode.srcIn,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: ChatProfileInfoStyle.textPadding,
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: LinagoraSysColors.material().onSurface,
                  ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.content_copy,
            size: ChatProfileInfoStyle.copyIconSize,
            color: LinagoraRefColors.material().tertiary[40],
          ),
          color: LinagoraRefColors.material().tertiary[40],
          focusColor: Theme.of(context).primaryColor,
          onPressed: () {
            TwakeClipboard.instance.copyText(text);
            TwakeSnackBar.show(context, L10n.of(context)!.copiedToClipboard);
          },
        ),
      ],
    );
  }
}
