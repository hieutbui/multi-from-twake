import 'dart:math' as math;
import 'package:dartz/dartz.dart';
import 'package:fluffychat/app_state/failure.dart';
import 'package:fluffychat/app_state/success.dart';
import 'package:fluffychat/config/multi_sys_variables/multi_colors.dart';
import 'package:fluffychat/config/multi_sys_variables/multi_typography.dart';
import 'package:fluffychat/domain/app_state/contact/lookup_match_contact_state.dart';
import 'package:fluffychat/pages/chat_details/chat_details_page_view/chat_details_page_enum.dart';
import 'package:fluffychat/pages/chat_details/chat_details_view_style.dart';
import 'package:fluffychat/pages/chat_profile_info/chat_profile_info.dart';
import 'package:fluffychat/pages/chat_profile_info/chat_profile_info_style.dart';
import 'package:fluffychat/resource/image_paths.dart';
import 'package:fluffychat/utils/string_extension.dart';
import 'package:fluffychat/widgets/avatar/avatar.dart';
import 'package:fluffychat/widgets/avatar/avatar_style.dart';
import 'package:fluffychat/widgets/matrix.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:linagora_design_flutter/avatar/round_avatar_style.dart';
import 'package:linagora_design_flutter/extensions/string_extension.dart';

class ChatProfileInfoView extends StatelessWidget {
  final ChatProfileInfoController controller;

  const ChatProfileInfoView(
    this.controller, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final user = controller.user;
    final contact = controller.widget.contact;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          style: IconButton.styleFrom(
            backgroundColor: Theme.of(context).brightness == Brightness.dark
                ? MultiDarkColors.buttonsMainSecondary15Opasity
                : MultiLightColors.buttonsMainSecondary15Opasity,
          ),
          iconSize: 18,
          constraints: BoxConstraints.tight(const Size.square(28)),
          padding: const EdgeInsets.all(0),
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).brightness == Brightness.dark
                ? MultiDarkColors.textMainPrimaryDefault
                : MultiLightColors.textMainPrimaryDefault,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: Theme.of(context).brightness == Brightness.dark
                ? const [
                    Color(0xFF0E0F13),
                    Color(0xFF191B26),
                  ]
                : [
                    MultiLightColors.backgroundPageDefault,
                  ],
          ),
        ),
        padding: ChatProfileInfoStyle.mainPadding,
        child: NestedScrollView(
          physics: controller.getScrollPhysics(),
          key: controller.nestedScrollViewState,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: ValueListenableBuilder(
                  valueListenable: controller.lookupContactNotifier,
                  builder: (context, lookupContact, child) {
                    return SliverAppBar(
                      backgroundColor: Colors.transparent,
                      flexibleSpace: Container(
                        margin: EdgeInsets.only(
                          top: MediaQuery.of(context).padding.top,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? MultiDarkColors.backgroundSurfacesDefault
                              : MultiLightColors.backgroundSurfacesDefault,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      toolbarHeight: _getToolbarHeight(lookupContact),
                      title: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: ChatProfileInfoStyle.maxWidth,
                          maxHeight: _getToolbarHeight(lookupContact),
                        ),
                        child: Builder(
                          builder: (context) {
                            if (contact?.matrixId != null) {
                              return FutureBuilder(
                                future: Matrix.of(context)
                                    .client
                                    .getProfileFromUserId(
                                      contact!.matrixId!,
                                      getFromRooms: false,
                                    ),
                                builder: (context, snapshot) =>
                                    _InformationWidget(
                                  avatarUri: snapshot.data?.avatarUrl,
                                  displayName: snapshot.data?.displayName ??
                                      contact.displayName,
                                  matrixId: contact.matrixId,
                                  lookupContactNotifier:
                                      controller.lookupContactNotifier,
                                  isDraftInfo: controller.widget.isDraftInfo,
                                ),
                              );
                            }
                            if (contact != null) {
                              return _InformationWidget(
                                displayName: contact.displayName,
                                matrixId: contact.matrixId,
                                lookupContactNotifier:
                                    controller.lookupContactNotifier,
                                isDraftInfo: controller.widget.isDraftInfo,
                              );
                            }
                            return _InformationWidget(
                              avatarUri: user?.avatarUrl,
                              displayName: user?.calcDisplayname(),
                              matrixId: user?.id,
                              lookupContactNotifier:
                                  controller.lookupContactNotifier,
                              isDraftInfo: controller.widget.isDraftInfo,
                            );
                          },
                        ),
                      ),
                      automaticallyImplyLeading: false,
                      pinned: true,
                      floating: true,
                      forceElevated: innerBoxIsScrolled,
                      bottom: const PreferredSize(
                        preferredSize: Size.fromHeight(0),
                        child: SizedBox.shrink(),
                      ),
                    );
                  },
                ),
              ),
            ];
          },
          body: Container(
            margin: EdgeInsets.only(top: kToolbarHeight + statusBarHeight + 4),
            child: Column(
              children: [
                _GradientBottomBorderContainer(
                  borderRadius:
                      MultiMobileRoundnessAndPaddings.paddingCardsLarge,
                  backgroundColor:
                      Theme.of(context).brightness == Brightness.dark
                          ? MultiDarkColors.backgroundSurfacesDefault
                          : MultiLightColors.backgroundSurfacesDefault,
                  child: TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    labelColor: Theme.of(context).brightness == Brightness.dark
                        ? MultiDarkColors.textMainPrimaryDefault
                        : MultiLightColors.textMainPrimaryDefault,
                    unselectedLabelColor:
                        Theme.of(context).brightness == Brightness.dark
                            ? MultiDarkColors.textMainSecondary
                            : MultiLightColors.textMainSecondary,
                    dividerColor: Colors.transparent,
                    tabs: controller.tabList.map((page) {
                      return Tab(
                        child: Text(
                          page.getTitle(context),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                        ),
                      );
                    }).toList(),
                    controller: controller.tabController,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Expanded(
                  child: Container(
                    width: ChatDetailViewStyle.chatDetailsPageViewWebWidth,
                    color: Colors.transparent,
                    child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: controller.tabController,
                      children:
                          controller.sharedPages().asMap().entries.map((page) {
                        final index = page.key;
                        final value = page.value;
                        if (index == ChatDetailsPage.info.index) {
                          return const _InfoTabView();
                        }
                        return value.child;
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double _getToolbarHeight(Either<Failure, Success> lookupContact) =>
      lookupContact.fold(
        (failure) => ChatDetailViewStyle.minToolbarHeightSliverAppBar,
        (success) {
          if (success is LookupContactsLoading) {
            return ChatDetailViewStyle.mediumToolbarHeightSliverAppBar;
          }
          if (success is LookupMatchContactSuccess) {
            if (success.contact.emails != null &&
                success.contact.phoneNumbers != null) {
              return ChatDetailViewStyle.maxToolbarHeightSliverAppBar;
            }

            if (success.contact.emails != null ||
                success.contact.phoneNumbers != null) {
              return ChatDetailViewStyle.mediumToolbarHeightSliverAppBar;
            }

            return ChatDetailViewStyle.maxToolbarHeightSliverAppBar;
          }
          return ChatDetailViewStyle.minToolbarHeightSliverAppBar;
        },
      );
}

class _InformationWidget extends StatelessWidget {
  const _InformationWidget({
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
    final iconColor = Theme.of(context).brightness == Brightness.dark
        ? MultiDarkColors.buttonsMainGhostDefault
        : MultiLightColors.buttonsMainGhostDefault;
    final textMainPrimaryDefaultColor =
        Theme.of(context).brightness == Brightness.dark
            ? MultiDarkColors.textMainPrimaryDefault
            : MultiLightColors.textMainPrimaryDefault;
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
                color: Theme.of(context).brightness == Brightness.dark
                    ? MultiDarkColors.textMainSecondary
                    : MultiLightColors.textMainSecondary,
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
                backgroundColor: Theme.of(context).brightness == Brightness.dark
                    ? MultiDarkColors.buttonsMainSecondaryDefault
                    : MultiLightColors.buttonsMainSecondaryDefault,
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

class _InfoTabView extends StatelessWidget {
  const _InfoTabView();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: ChatProfileInfoStyle.paddingInformation,
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? MultiDarkColors.backgroundSurfacesDefault
                  : MultiLightColors.backgroundSurfacesDefault,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,

              // TODO: Remove dummy data
              children: [
                const _InfoCardWidget(
                  label: "Phone number",
                  value: "+33 (732) 37238",
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const _InfoCardWidget(
                      label: "Birthday Date",
                      value: "12 Aug 1900",
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? MultiDarkColors.supportiveColorsPinkMain
                            : MultiLightColors.supportiveColorsPinkMain,
                        borderRadius: BorderRadius.circular(
                          MultiMobileRoundnessAndPaddings.roundnessTags,
                        ),
                      ),
                      child: Text(
                        "In 12 days 🎉",
                        style: TextStyle(
                          fontSize: MultiMobileTypography.buttonFontSmall,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? MultiDarkColors.supportiveColorsPinkContrast
                              : MultiLightColors.supportiveColorsPinkContrast,
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
                    const _InfoCardWidget(
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
                  color: Theme.of(context).brightness == Brightness.dark
                      ? MultiDarkColors.backgroundSurfacesDefault
                      : MultiLightColors.backgroundSurfacesDefault,
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
                  color: Theme.of(context).brightness == Brightness.dark
                      ? MultiDarkColors.backgroundSurfacesDefault
                      : MultiLightColors.backgroundSurfacesDefault,
                  borderRadius: BorderRadius.circular(20),
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
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? MultiDarkColors.textMainPrimaryDefault
                                  : MultiLightColors.textMainPrimaryDefault,
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
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? MultiDarkColors.textMainSecondary
                                  : MultiLightColors.textMainSecondary,
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
              backgroundColor: Theme.of(context).brightness == Brightness.dark
                  ? MultiDarkColors.buttonsMainSecondaryDefault
                  : MultiLightColors.buttonsMainSecondaryDefault,
            ),
            onPressed: () {},
            child: Text(
              "Report and bloc",
              style: TextStyle(
                fontSize: MultiMobileTypography.buttonFontLarge,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).brightness == Brightness.dark
                    ? MultiDarkColors.textMainError
                    : MultiLightColors.textMainError,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoCardWidget extends StatelessWidget {
  const _InfoCardWidget({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: MultiMobileTypography.captionFontCaption2,
            fontWeight: FontWeight.w400,
            color: Theme.of(context).brightness == Brightness.dark
                ? MultiDarkColors.textMainTertiaryDisabled
                : MultiLightColors.textMainTertiaryDisabled,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: MultiMobileTypography.bodyFontBody,
            fontWeight: FontWeight.w400,
            color: Theme.of(context).brightness == Brightness.dark
                ? MultiDarkColors.textMainPrimaryDefault
                : MultiLightColors.textMainPrimaryDefault,
          ),
        ),
      ],
    );
  }
}

class _GradientBottomBorderContainer extends StatelessWidget {
  final Widget child;
  final double borderWidth;
  final double borderRadius;
  final Gradient gradient;
  final double cutMargin;
  final Color backgroundColor;

  const _GradientBottomBorderContainer({
    super.key,
    required this.child,
    this.borderWidth = 3.0,
    this.borderRadius = 12.0,
    this.cutMargin = 2.0,
    this.backgroundColor = Colors.transparent,
    this.gradient = const LinearGradient(
      colors: [
        Color.fromRGBO(115, 140, 150, 0.3),
        Color.fromRGBO(115, 140, 150, 0.0),
      ],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: _GradientBottomBorderPainter(
        borderWidth: borderWidth,
        borderRadius: borderRadius,
        gradient: gradient,
        cutMargin: cutMargin,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: DecoratedBox(
          decoration: BoxDecoration(color: backgroundColor),
          child: child,
        ),
      ),
    );
  }
}

class _GradientBottomBorderPainter extends CustomPainter {
  final double borderWidth;
  final double borderRadius;
  final Gradient gradient;
  final double cutMargin;

  const _GradientBottomBorderPainter({
    required this.borderWidth,
    required this.borderRadius,
    required this.gradient,
    required this.cutMargin,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double r =
        math.min(borderRadius, math.min(size.width, size.height) / 2);

    final RRect outer =
        RRect.fromRectAndRadius(Offset.zero & size, Radius.circular(r));

    canvas.save();
    canvas.clipRRect(outer);
    final double clipHeight = r + borderWidth;
    canvas.clipRect(
      Rect.fromLTWH(
        cutMargin.clamp(0.0, size.width / 2),
        size.height - clipHeight,
        (size.width - 2 * cutMargin).clamp(0.0, size.width),
        clipHeight,
      ),
    );

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth
      ..shader = gradient.createShader(
        Rect.fromLTWH(
          cutMargin.clamp(0.0, size.width / 2),
          size.height - clipHeight,
          (size.width - 2 * cutMargin).clamp(0.0, size.width),
          clipHeight,
        ),
      )
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.round;

    canvas.drawRRect(outer, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _GradientBottomBorderPainter oldDelegate) {
    return oldDelegate.borderWidth != borderWidth ||
        oldDelegate.borderRadius != borderRadius ||
        oldDelegate.gradient != gradient ||
        oldDelegate.cutMargin != cutMargin;
  }
}
