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
            backgroundColor:
                MultiColors.of(context).buttonsMainSecondary15Opasity,
          ),
          iconSize: 18,
          constraints: BoxConstraints.tight(const Size.square(28)),
          padding: const EdgeInsets.all(0),
          icon: Icon(
            Icons.arrow_back,
            color: MultiColors.of(context).textMainPrimaryDefault,
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
                    const MultiLightColors().backgroundPageDefault,
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
                          color:
                              MultiColors.of(context).backgroundSurfacesDefault,
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
                                  subtitle: contact.matrixId,
                                  onTapMenuAction: (tapDownDetails) =>
                                      controller.handleAppbarMenuAction(
                                    context,
                                    tapDownDetails,
                                  ),
                                ),
                              );
                            }
                            if (contact != null) {
                              return InformationWidget(
                                displayName: contact.displayName,
                                subtitle: contact.matrixId,
                                onTapMenuAction: (tapDownDetails) =>
                                    controller.handleAppbarMenuAction(
                                  context,
                                  tapDownDetails,
                                ),
                              );
                            }
                            return InformationWidget(
                              avatarUri: user?.avatarUrl,
                              displayName: user?.calcDisplayname(),
                              subtitle: user?.id,
                              onTapMenuAction: (tapDownDetails) =>
                                  controller.handleAppbarMenuAction(
                                context,
                                tapDownDetails,
                              ),
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
                      MultiColors.of(context).backgroundSurfacesDefault,
                  child: TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    labelColor: MultiColors.of(context).textMainPrimaryDefault,
                    unselectedLabelColor:
                        MultiColors.of(context).textMainSecondary,
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
