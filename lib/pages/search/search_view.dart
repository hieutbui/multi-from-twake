import 'package:fluffychat/config/multi_sys_variables/multi_colors.dart';
import 'package:fluffychat/pages/dialer/pip/dismiss_keyboard.dart';
import 'package:fluffychat/pages/search/recent_item_widget.dart';
import 'package:fluffychat/pages/search/search.dart';
import 'package:fluffychat/pages/search/search_external_contact.dart';
import 'package:fluffychat/pages/search/search_view_style.dart';
import 'package:fluffychat/pages/search/server_search_view.dart';
import 'package:fluffychat/presentation/model/search/presentation_server_side_empty_search.dart';
import 'package:fluffychat/presentation/model/search/presentation_server_side_search.dart';
import 'package:fluffychat/widgets/context_menu_builder_ios_paste_without_permission.dart';
import 'package:fluffychat/widgets/twake_components/twake_icon_button.dart';
import 'package:fluffychat/widgets/twake_components/twake_loading/center_loading_indicator.dart';
import 'package:flutter/material.dart' hide SearchController;
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:gradient_borders/input_borders/gradient_outline_input_border.dart';
import 'package:linagora_design_flutter/colors/linagora_ref_colors.dart';

class SearchView extends StatelessWidget {
  final SearchController searchController;

  const SearchView(this.searchController, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(SearchViewStyle.toolbarHeightSearch),
        child: _buildAppBarSearch(context, searchController),
      ),
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
        child: CustomScrollView(
          physics: const ClampingScrollPhysics(),
          controller: searchController.scrollController,
          slivers: [
            _RecentChatAndContactsHeader(searchController: searchController),
            _recentChatsOrContactsWidget(),
            ValueListenableBuilder(
              valueListenable:
                  searchController.serverSearchController.searchResultsNotifier,
              builder: ((context, searchResults, child) {
                if (searchResults is PresentationServerSideEmptySearch) {
                  return child!;
                }

                if (searchResults is PresentationServerSideSearch) {
                  if (searchResults.searchResults.isEmpty) {
                    return child!;
                  }
                  return _SearchHeader(
                    header: L10n.of(context)!.messages,
                    searchController: searchController,
                    needShowMore: false,
                  );
                }
                return child!;
              }),
              child: _EmptySliverBox(),
            ),
            ServerSearchMessagesList(searchController: searchController),
            ValueListenableBuilder(
              valueListenable:
                  searchController.serverSearchController.isLoadingMoreNotifier,
              builder: (context, isLoadingMore, _) {
                return SliverToBoxAdapter(
                  child: isLoadingMore
                      ? const CenterLoadingIndicator()
                      : const SizedBox(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _recentChatsOrContactsWidget() {
    return SliverToBoxAdapter(
      child: ValueListenableBuilder(
        valueListenable: searchController.searchContactAndRecentChatController!
            .isShowChatsAndContactsNotifier,
        builder: (context, isShowMore, _) {
          return ValueListenableBuilder(
            valueListenable: searchController
                .searchContactAndRecentChatController!
                .recentAndContactsNotifier,
            builder: (context, contacts, emptyChild) {
              if (contacts.isEmpty) {
                final keyword = searchController.textEditingController.text;
                if (searchController.isSearchMatrixUserId) {
                  return SearchExternalContactWidget(
                    keyword: keyword,
                    searchController: searchController,
                  );
                }
                return emptyChild!;
              }

              if (searchController.isShowMore) {
                return const SizedBox.shrink();
              }

              return ListView.builder(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 12),
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  return RecentItemWidget(
                    highlightKeyword:
                        searchController.textEditingController.text,
                    presentationSearch: contacts[index],
                    client: searchController.client,
                    key: Key('chat_recent_${contacts[index].id}'),
                    onTap: () {
                      searchController.onSearchItemTap(contacts[index]);
                    },
                  );
                },
              );
            },
            child: const SizedBox(),
          );
        },
      ),
    );
  }

  Widget _buildAppBarSearch(BuildContext context, SearchController controller) {
    return AppBar(
      toolbarHeight: SearchViewStyle.toolbarHeightSearch,
      backgroundColor: Colors.black.withOpacity(0.5),
      automaticallyImplyLeading: false,
      flexibleSpace: Container(
        decoration: const ShapeDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.50, -0.00),
            end: Alignment(0.50, 1.00),
            colors: [Color(0xFF0E0F13), Color(0xFF232631)],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
          ),
        ),
        child: Container(
          margin: EdgeInsetsDirectional.only(
            top: 12 + MediaQuery.of(context).padding.top,
          ),
          padding: const EdgeInsetsDirectional.only(
            start: 20,
            end: 20,
            bottom: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController.textEditingController,
                      onTapOutside: (event) {
                        dismissKeyboard(context);
                      },
                      textInputAction: TextInputAction.search,
                      contextMenuBuilder: mobileTwakeContextMenuBuilder,
                      enabled: true,
                      autofocus: true,
                      decoration: InputDecoration(
                        filled: true,
                        contentPadding: SearchViewStyle.contentPaddingAppBar,
                        fillColor: Theme.of(context).colorScheme.surface,
                        border: GradientOutlineInputBorder(
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xFF738C96).withOpacity(0.0),
                              const Color(0xFF738C96),
                            ],
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                          ),
                          width: 1.0,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12.0)),
                        ),
                        hintText: L10n.of(context)!.search,
                        hintStyle: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                              color: LinagoraRefColors.material().neutral[60],
                            ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        prefixIcon: Icon(
                          Icons.search_outlined,
                          size: SearchViewStyle.searchIconSize,
                          color: LinagoraRefColors.material().neutral[60],
                        ),
                        suffixIcon: ValueListenableBuilder(
                          valueListenable:
                              searchController.textEditingController,
                          builder: (context, value, child) {
                            return value.text.isNotEmpty
                                ? child!
                                : const SizedBox.shrink();
                          },
                          child: TwakeIconButton(
                            tooltip: L10n.of(context)!.close,
                            icon: Icons.close,
                            onTap: searchController.textEditingController.clear,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Cancel",
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: MultiColors.of(context).textMainAccent,
                              ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size(double.infinity, 6),
        child: Container(
          color: Theme.of(context).colorScheme.surfaceTint.withOpacity(0.08),
          height: 1,
        ),
      ),
    );
  }
}

class _RecentChatAndContactsHeader extends StatelessWidget {
  const _RecentChatAndContactsHeader({
    required this.searchController,
  });

  final SearchController searchController;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: searchController.textEditingController,
      builder: ((context, value, _) {
        final searchTerm = value.text;
        return ValueListenableBuilder(
          valueListenable: searchController
              .searchContactAndRecentChatController!.recentAndContactsNotifier,
          builder: (context, contacts, _) {
            if (searchTerm.isNotEmpty && contacts.isEmpty) {
              return _EmptySliverBox();
            }
            return _SearchHeader(
              searchController: searchController,
              header:
                  searchTerm.isEmpty ? L10n.of(context)!.recent : "Contacts",
              needShowMore: value.text.isNotEmpty,
            );
          },
        );
      }),
    );
  }
}

class _SearchHeader extends StatelessWidget {
  final String header;

  final SearchController searchController;

  final bool needShowMore;

  const _SearchHeader({
    required this.header,
    required this.searchController,
    this.needShowMore = true,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      toolbarHeight: SearchViewStyle.toolbarHeightOfSliverAppBar,
      flexibleSpace: FlexibleSpaceBar(
        title: _chatsHeaders(
          context,
          header,
          needShowMore: needShowMore,
        ),
        titlePadding: SearchViewStyle.appbarPadding,
      ),
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false,
      pinned: true,
    );
  }

  Widget _chatsHeaders(
    BuildContext context,
    String headerText, {
    bool needShowMore = true,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsetsDirectional.symmetric(
        horizontal: 12,
      ),
      padding: SearchViewStyle.paddingRecentChatsHeaders,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.all(
          Radius.circular(4),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              headerText,
              style: SearchViewStyle.headerTextStyle(context),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptySliverBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: SizedBox.shrink(),
    );
  }
}
