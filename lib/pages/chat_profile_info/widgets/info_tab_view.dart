import 'package:fluffychat/config/multi_sys_variables/multi_colors.dart';
import 'package:fluffychat/config/multi_sys_variables/multi_typography.dart';
import 'package:fluffychat/pages/chat_profile_info/chat_profile_info_style.dart';
import 'package:fluffychat/pages/chat_profile_info/widgets/info_card_widget.dart';
import 'package:fluffychat/resource/image_paths.dart';
import 'package:fluffychat/widgets/avatar/avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InfoTabView extends StatelessWidget {
  const InfoTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: ChatProfileInfoStyle.paddingInformation,
            decoration: BoxDecoration(
              color: MultiColors.of(context).backgroundSurfacesDefault,
              borderRadius: const BorderRadius.all(
                Radius.circular(20.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,

              // TODO: Remove dummy data
              children: [
                const InfoCardWidget(
                  label: "Phone number",
                  value: "+33 (732) 37238",
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const InfoCardWidget(
                      label: "Birthday Date",
                      value: "12 Aug 1900",
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: MultiColors.of(context).supportiveColorsPinkMain,
                        borderRadius: BorderRadius.circular(
                          MultiMobileRoundnessAndPaddings.roundnessTags,
                        ),
                      ),
                      child: Text(
                        "In 12 days 🎉",
                        style: TextStyle(
                          fontSize: MultiMobileTypography.buttonFontSmall,
                          fontWeight: FontWeight.w400,
                          color: MultiColors.of(context)
                              .supportiveColorsPinkContrast,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const InfoCardWidget(
                      label: "Nickname",
                      value: "@NDkcbsHJH",
                    ),
                    SvgPicture.asset(ImagePaths.icQrCode),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10, left: 24.5, right: 24.5),
                height: 66,
                decoration: BoxDecoration(
                  color: MultiColors.of(context).backgroundSurfacesDefault,
                  borderRadius: BorderRadius.circular(
                    MultiMobileRoundnessAndPaddings
                        .roundnessCardsSmallDropdowns,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 13,
                ),
                decoration: BoxDecoration(
                  color: MultiColors.of(context).backgroundSurfacesDefault,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x66000000),
                      offset: Offset(0, 8),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // TODO: Remove dummy data
                    Avatar(
                      mxContent: Uri.parse("https://picsum.photos/200"),
                      name: "test",
                      size: 40,
                      fontSize: ChatProfileInfoStyle.avatarFontSize,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                          child: Text(
                            "Group chat",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: MultiColors.of(context)
                                  .textMainPrimaryDefault,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        SizedBox(
                          height: 16,
                          child: Text(
                            "12 members",
                            style: TextStyle(
                              fontSize: MultiMobileTypography.bodyFontSubhead,
                              fontWeight: FontWeight.w400,
                              color: MultiColors.of(context).textMainSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  MultiColors.of(context).buttonsMainSecondaryDefault,
            ),
            onPressed: () {},
            child: Text(
              "Report and block",
              style: TextStyle(
                fontSize: MultiMobileTypography.buttonFontLarge,
                fontWeight: FontWeight.w500,
                color: MultiColors.of(context).textMainError,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
