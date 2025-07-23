import 'package:dartz/dartz.dart';
import 'package:fluffychat/app_state/failure.dart';
import 'package:fluffychat/app_state/success.dart';
import 'package:fluffychat/config/multi_sys_variables/multi_colors.dart';
import 'package:fluffychat/config/multi_sys_variables/multi_typography.dart';
import 'package:fluffychat/pages/chat_profile_info/chat_profile_info_style.dart';
import 'package:fluffychat/resource/image_paths.dart';
import 'package:fluffychat/utils/string_extension.dart';
import 'package:fluffychat/widgets/avatar/avatar.dart';
import 'package:fluffychat/widgets/avatar/avatar_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:linagora_design_flutter/avatar/round_avatar_style.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:linagora_design_flutter/extensions/string_extension.dart';

class InformationWidget extends StatelessWidget {
  const InformationWidget({
    super.key,
    this.avatarUri,
    this.displayName,
    this.matrixId,
    required this.lookupContactNotifier,
    required this.isDraftInfo,
  });

  final Uri? avatarUri;
  final String? displayName;
  final String? matrixId;
  final ValueNotifier<Either<Failure, Success>> lookupContactNotifier;
  final bool isDraftInfo;

  @override
  Widget build(BuildContext context) {
    final iconColor = MultiColors.of(context).buttonsMainGhostDefault;
    final textMainPrimaryDefaultColor =
        MultiColors.of(context).textMainPrimaryDefault;
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
    return Padding(
      padding: ChatProfileInfoStyle.paddingInformation,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: ChatProfileInfoStyle.iconSize,
                width: ChatProfileInfoStyle.iconSize,
                child: SvgPicture.asset(
                  ImagePaths.icMute,
                  colorFilter: ColorFilter.mode(
                    iconColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              Builder(
                builder: (context) {
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
              SizedBox(
                height: ChatProfileInfoStyle.iconSize,
                width: ChatProfileInfoStyle.iconSize,
                child: Icon(
                  Icons.more_vert,
                  color: iconColor,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 42,
            child: Text(
              displayName ?? "",
              style: TextStyle(
                fontSize: MultiMobileTypography.headlineFontLarge,
                fontWeight: FontWeight.w700,
                color: textMainPrimaryDefaultColor,
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            height: 20,
            child: Text(
              matrixId ?? "",
              style: TextStyle(
                fontSize: MultiMobileTypography.bodyFontBody,
                fontWeight: FontWeight.w400,
                color: MultiColors.of(context).textMainSecondary,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 36,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 29,
                ),
                backgroundColor:
                    MultiColors.of(context).buttonsMainSecondaryDefault,
              ),
              onPressed: () {},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    L10n.of(context)!.sendAMessage,
                    style: TextStyle(
                      fontSize: MultiMobileTypography.buttonFontMedium,
                      fontWeight: FontWeight.w400,
                      color: textMainPrimaryDefaultColor,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  SvgPicture.asset(
                    ImagePaths.icSend,
                    height: 18,
                    width: 18,
                    colorFilter: ColorFilter.mode(
                      textMainPrimaryDefaultColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
