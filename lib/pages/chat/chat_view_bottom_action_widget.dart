import 'package:fluffychat/pages/chat_list/chat_list_bottom_navigator_style.dart';
import 'package:flutter/material.dart';

class ChatViewBottomActionWidget extends StatelessWidget {
  final List<Widget> actions;

  const ChatViewBottomActionWidget({
    super.key,
    required this.actions,
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
        children: actions,
      ),
    );
  }
}
