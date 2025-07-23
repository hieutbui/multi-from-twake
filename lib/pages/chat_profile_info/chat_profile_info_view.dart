import 'package:dartz/dartz.dart';
import 'package:fluffychat/app_state/failure.dart';
import 'package:fluffychat/app_state/success.dart';
import 'package:fluffychat/config/multi_sys_variables/multi_colors.dart';
import 'package:fluffychat/config/multi_sys_variables/multi_typography.dart';
import 'package:fluffychat/domain/app_state/contact/lookup_match_contact_state.dart';
import 'package:fluffychat/pages/chat_details/chat_details_view_style.dart';
import 'package:fluffychat/pages/chat_profile_info/chat_profile_info.dart';
import 'package:fluffychat/pages/chat_profile_info/chat_profile_info_style.dart';
import 'package:fluffychat/pages/chat_profile_info/widgets/information_widget.dart';
import 'package:fluffychat/widgets/gradient_bottom_border_container.dart';
import 'package:fluffychat/widgets/matrix.dart';
import 'package:flutter/material.dart';

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
          onPressed: controller.onPressBack,
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
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20.0),
                          ),
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
                                    InformationWidget(
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
                              return InformationWidget(
                                displayName: contact.displayName,
                                matrixId: contact.matrixId,
                                lookupContactNotifier:
                                    controller.lookupContactNotifier,
                                isDraftInfo: controller.widget.isDraftInfo,
                              );
                            }
                            return InformationWidget(
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
                GradientBottomBorderContainer(
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
                      children: controller.getTabBarViewList(),
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
