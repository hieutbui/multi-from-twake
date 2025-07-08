import 'package:fluffychat/pages/chat/chat_input_row_style.dart';
import 'package:flutter/material.dart';

typedef OnTapEmojiAction = void Function();

class ChatInputRowMobile extends StatelessWidget {
  const ChatInputRowMobile({
    super.key,
    required this.inputBar,
  });

  final Widget inputBar;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: ChatInputRowStyle.chatInputRowHeight,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: inputBar,
          ),
        ],
      ),
    );
  }
}
