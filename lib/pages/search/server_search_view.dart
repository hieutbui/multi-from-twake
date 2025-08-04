import 'package:fluffychat/config/multi_sys_variables/multi_colors.dart';
import 'package:fluffychat/config/multi_sys_variables/multi_typography.dart';
import 'package:fluffychat/pages/chat_list/chat_list_item_title.dart';
import 'package:fluffychat/pages/search/search.dart';
import 'package:fluffychat/pages/search/server_search_view_style.dart';
import 'package:fluffychat/presentation/model/search/presentation_server_side_empty_search.dart';
import 'package:fluffychat/presentation/model/search/presentation_server_side_search.dart';
import 'package:fluffychat/resource/image_paths.dart';
import 'package:fluffychat/utils/extension/build_context_extension.dart';
import 'package:fluffychat/widgets/avatar/avatar.dart';
import 'package:fluffychat/widgets/highlight_text.dart';
import 'package:fluffychat/widgets/matrix.dart';
import 'package:flutter/material.dart' hide SearchController;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:linagora_design_flutter/linagora_design_flutter.dart';
import 'package:matrix/matrix.dart';

class ServerSearchMessagesList extends StatelessWidget {
  final SearchController searchController;

  const ServerSearchMessagesList({
    super.key,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: ValueListenableBuilder(
        valueListenable:
            searchController.serverSearchController.searchResultsNotifier,
        builder: (context, serverSearchNotifier, child) {
          if (serverSearchNotifier is PresentationServerSideEmptySearch) {
            if (searchController.searchContactAndRecentChatController!
                    .recentAndContactsNotifier.value.isEmpty &&
                !(searchController.isSearchMatrixUserId)) {
              return child!;
            }
            return const SizedBox.shrink();
          }

          if (serverSearchNotifier is PresentationServerSideSearch) {
            return ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: serverSearchNotifier.searchResults.length,
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 12),
              itemBuilder: ((context, index) {
                final searchResult =
                    serverSearchNotifier.searchResults[index].result;
                final room = Matrix.of(context).client.getRoomById(
                      searchResult?.roomId ?? '',
                    );
                if (room == null || searchResult == null) {
                  return const SizedBox.shrink();
                }
                final searchWord = searchController.searchWord;
                final event = Event.fromMatrixEvent(searchResult, room);
                final originServerTs = searchResult.originServerTs;

                return TwakeInkWell(
                  onTap: () =>
                      context.goToRoomWithEvent(event.room.id, event.eventId),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: ServerSearchViewStyle.paddingAvatar,
                          child: Avatar(
                            mxContent: room.avatar,
                            name: room.name,
                            size: 40,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ChatListItemTitle(
                                room: room,
                                originServerTs: originServerTs,
                              ),
                              HighlightText(
                                text: searchController.getBodyText(
                                  event,
                                  searchWord,
                                ),
                                searchWord: searchWord,
                                maxLines: 2,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color:
                                      MultiColors.of(context).textMainSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            );
          }

          return const SizedBox();
        },
        child: _EmptySearchWidget(
          value: searchController.searchWord,
        ),
      ),
    );
  }
}

class _EmptySearchWidget extends StatelessWidget {
  const _EmptySearchWidget({
    required this.value,
  });

  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.all(12),
      child: Column(
        children: [
          const SizedBox(
            height: 70,
          ),
          SvgPicture.asset(
            ImagePaths.icEmptySearch,
            width: 85,
            height: 80,
          ),
          const SizedBox(
            height: 32,
          ),
          Text(
            "No result for “$value”",
            style: TextStyle(
              fontSize: MultiMobileTypography.headlineFontSubtitle,
              fontWeight: FontWeight.w600,
              color: MultiColors.of(context).textMainPrimaryDefault,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            "We couldn’t find anything — please try again",
            style: TextStyle(
              fontSize: MultiMobileTypography.bodyFontSubhead,
              fontWeight: FontWeight.w400,
              color: MultiColors.of(context).textMainSecondary,
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          Container(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: 16,
              vertical: 13,
            ),
            decoration: BoxDecoration(
              color: MultiColors.of(context).backgroundSurfacesDefault,
              borderRadius: const BorderRadius.all(Radius.circular(16)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffD9D9D9),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Add new contact",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: MultiColors.of(context).textMainPrimaryDefault,
                        ),
                      ),
                      Text(
                        "Lorem ipsum",
                        style: TextStyle(
                          fontSize: MultiMobileTypography.bodyFontSubhead,
                          fontWeight: FontWeight.w400,
                          color: MultiColors.of(context).textMainPrimaryDefault,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
