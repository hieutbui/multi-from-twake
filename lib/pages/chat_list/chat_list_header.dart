import 'package:fluffychat/config/multi_sys_variables/multi_sys_colors.dart';
import 'package:fluffychat/pages/chat_list/chat_list.dart';
import 'package:fluffychat/pages/chat_list/chat_list_header_style.dart';
import 'package:fluffychat/utils/platform_infos.dart';
import 'package:fluffychat/widgets/context_menu_builder_ios_paste_without_permission.dart';
import 'package:fluffychat/widgets/twake_components/twake_header.dart';
import 'package:flutter/material.dart';
import 'package:linagora_design_flutter/colors/linagora_state_layer.dart';

class ChatListHeader extends StatelessWidget {
  final ChatListController controller;
  final VoidCallback? onOpenSearchPageInMultipleColumns;

  const ChatListHeader({
    super.key,
    required this.controller,
    this.onOpenSearchPageInMultipleColumns,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TwakeHeader(
          onClearSelection: controller.onClickClearSelection,
          client: controller.activeClient,
          selectModeNotifier: controller.selectModeNotifier,
          conversationSelectionNotifier:
              controller.conversationSelectionNotifier,
          onClickAvatar: controller.onClickAvatar,
        ),
        Container(
          color: ChatListHeaderStyle.responsive.isMobile(context)
              ? MultiSysColors.material().background
              : Colors.transparent,
          height: ChatListHeaderStyle.searchBarContainerHeight,
          padding: ChatListHeaderStyle.searchInputPadding,
          child: PlatformInfos.isWeb
              ? _normalModeWidgetWeb(context)
              : _normalModeWidgetsMobile(context),
        ),
        if (ChatListHeaderStyle.responsive.isMobile(context))
          Divider(
            height: ChatListHeaderStyle.dividerHeight,
            thickness: ChatListHeaderStyle.dividerThickness,
            color: LinagoraStateLayer(MultiSysColors.material().surfaceTint)
                .opacityLayer3,
          ),
      ],
    );
  }

  Widget _normalModeWidgetsMobile(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            child: TextField(
              textInputAction: TextInputAction.search,
              enabled: false,
              decoration: ChatListHeaderStyle.searchInputDecoration(context),
            ),
          ),
        ),
      ],
    );
  }

  Widget _normalModeWidgetWeb(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            borderRadius:
                BorderRadius.circular(ChatListHeaderStyle.searchRadiusBorder),
            onTap: onOpenSearchPageInMultipleColumns,
            child: ValueListenableBuilder(
              valueListenable: controller.matrixState.showToMBootstrap,
              builder: (context, value, _) {
                return TextField(
                  textInputAction: TextInputAction.search,
                  contextMenuBuilder: mobileTwakeContextMenuBuilder,
                  enabled: false,
                  decoration:
                      ChatListHeaderStyle.searchInputDecoration(context),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
