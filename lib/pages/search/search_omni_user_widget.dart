import 'package:fluffychat/config/multi_sys_variables/multi_typography.dart';
import 'package:fluffychat/pages/search/recent_item_widget_style.dart';
import 'package:fluffychat/presentation/extensions/search/presentation_search_extensions.dart';
import 'package:fluffychat/presentation/model/search/presentation_search.dart';
import 'package:fluffychat/utils/string_extension.dart';
import 'package:fluffychat/widgets/avatar/avatar.dart';
import 'package:fluffychat/widgets/highlight_text.dart';
import 'package:fluffychat/widgets/twake_components/twake_chip.dart';
import 'package:flutter/material.dart';
import 'package:linagora_design_flutter/linagora_design_flutter.dart';
import 'package:matrix/matrix.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class SearchOmniUserWidget extends StatelessWidget {
  final String keyword;
  final OmniUserPresentationSearch omniUser;
  final Client client;
  final void Function()? onTap;

  const SearchOmniUserWidget({
    super.key,
    required this.keyword,
    required this.omniUser,
    required this.client,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TwakeInkWell(
      onTap: onTap,
      child: SizedBox(
        height: RecentItemStyle.recentItemHeight,
        child: TwakeListItem(
          height: RecentItemStyle.recentItemHeight,
          child: Padding(
            padding: RecentItemStyle.paddingRecentItem,
            child: _OmniUserInformation(
              omniUser: omniUser,
              client: client,
              keyword: keyword,
            ),
          ),
        ),
      ),
    );
  }
}

class _OmniUserInformation extends StatelessWidget {
  final OmniUserPresentationSearch omniUser;
  final Client client;
  final String keyword;

  const _OmniUserInformation({
    required this.omniUser,
    required this.client,
    required this.keyword,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FutureBuilder<Profile?>(
          future: omniUser.getProfile(client),
          builder: (context, snapshot) {
            return Avatar(
              mxContent: snapshot.data?.avatarUrl,
              name: omniUser.displayName,
              size: 40,
            );
          },
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: _SearchHighlightText(
                      text: omniUser.displayName ?? '',
                      searchWord: keyword,
                      style: TextStyle(
                        fontSize: MultiMobileTypography.bodyFontBody,
                        fontFamily: MultiFonts.sfProDisplay,
                        fontWeight: FontWeight.w500,
                        height: 1.29,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                  if (omniUser.matrixUserId.isCurrentMatrixId(context)) ...[
                    const SizedBox(width: 8.0),
                    TwakeChip(
                      text: L10n.of(context)!.owner,
                      textColor: Theme.of(context).colorScheme.primary,
                    ),
                  ],
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SearchHighlightText(
                    text: omniUser.matrixUserId,
                    searchWord: keyword,
                    style: TextStyle(
                      fontSize: MultiMobileTypography.bodyLineHeighSubhead,
                      fontFamily: MultiFonts.sfPro,
                      fontWeight: FontWeight.w400,
                      height: 1.20,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      letterSpacing: -0.24,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SearchHighlightText extends StatelessWidget {
  final String text;
  final String? searchWord;
  final TextStyle? style;

  const _SearchHighlightText({
    required this.text,
    this.searchWord,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return HighlightText(
      text: text,
      style: style,
      searchWord: searchWord,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      softWrap: false,
    );
  }
}
