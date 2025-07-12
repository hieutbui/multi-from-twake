import 'package:fluffychat/pages/chat_list/chat_list_bottom_navigator_style.dart';
import 'package:fluffychat/presentation/enum/chat_list/chat_list_enum.dart';
import 'package:flutter/material.dart';

typedef ChatListBottomNavigatorBarIcon = Function(ChatListSelectionActions);

class ChatListBottomNavigator extends StatelessWidget {
  final List<Widget> bottomNavigationActionsWidget;

  const ChatListBottomNavigator({
    super.key,
    required this.bottomNavigationActionsWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 94,
      padding: ChatListBottomNavigatorStyle.padding,
      decoration: ShapeDecoration(
        color: Theme.of(context).colorScheme.surface,
        shape: const RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: Color(0x4C738C96),
          ),
        ),
      ),
      child: Row(
        children: bottomNavigationActionsWidget,
      ),
    );
  }
}
