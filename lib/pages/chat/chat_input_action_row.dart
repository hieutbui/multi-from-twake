import 'package:fluffychat/config/multi_sys_variables/multi_colors.dart';
import 'package:fluffychat/config/multi_sys_variables/multi_typography.dart';
import 'package:fluffychat/pages/chat/chat_input_row_send_btn.dart';
import 'package:fluffychat/resource/image_paths.dart';
import 'package:fluffychat/widgets/twake_components/twake_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChatInputActionRow extends StatelessWidget {
  final ValueNotifier<String> inputText;
  final OnTapIconButtonCallbackAction onTapEmoji;
  final OnTapIconButtonCallbackAction onTapAttach;
  final OnTapIconButtonCallbackAction onTapSnooze;
  final OnTapIconButtonCallbackAction onTapSend;
  final OnTapIconButtonCallbackAction onTapAI;

  const ChatInputActionRow({
    super.key,
    required this.inputText,
    required this.onTapEmoji,
    required this.onTapAttach,
    required this.onTapSnooze,
    required this.onTapSend,
    required this.onTapAI,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        _buildAIButton(context, inputText.value.isNotEmpty, onTapAI),
        const SizedBox(width: 8.0),
        TwakeIconButton(
          imagePath: ImagePaths.icEmoji,
          tooltip: 'Emoji',
          onTap: onTapEmoji,
          size: 24.0,
        ),
        TwakeIconButton(
          imagePath: ImagePaths.icAttach,
          tooltip: 'Attach',
          onTap: onTapAttach,
          size: 24.0,
        ),
        const Spacer(),
        TwakeIconButton(
          imagePath: ImagePaths.icClockSnooze,
          tooltip: 'Snooze',
          onTap: onTapSnooze,
          size: 24.0,
        ),
        ChatInputRowSendBtn(
          inputText: inputText,
          onTap: onTapSend,
        ),
      ],
    );
  }

  //TODO: Have to clear condition
  Widget _buildAIButton(
    BuildContext context,
    bool isAIActive,
    OnTapIconButtonCallbackAction onTapAI,
  ) {
    // return !isAIActive
    //     ? Material(
    //         color: Theme.of(context).brightness == Brightness.light
    //             ? MultiLightColors.buttonsMainSecondaryDefault
    //             : MultiDarkColors.buttonsMainSecondaryDefault,
    //         borderRadius: const BorderRadius.all(
    //           Radius.circular(
    //               MultiMobileRoundnessAndPaddings.roundnessButtonsSmall),
    //         ),
    //         child: InkWell(
    //           //TODO: Handle AI button
    //           onTap: () {},
    //           enableFeedback: isAIActive,
    //           child: Padding(
    //             padding: const EdgeInsets.only(
    //               left: 28.0,
    //               right: 20.0,
    //               top: 5.0,
    //               bottom: 5.0,
    //             ),
    //             child: Row(
    //               children: <Widget>[
    //                 Text(
    //                   'AI help',
    //                   style: Theme.of(context).textTheme.titleSmall?.copyWith(
    //                         color: Theme.of(context)
    //                             .colorScheme
    //                             .onPrimaryContainer,
    //                       ),
    //                 ),
    //                 const SizedBox(width: 8),
    //                 SvgPicture.asset(ImagePaths.icStartAI),
    //               ],
    //             ),
    //           ),
    //         ),
    //       )
    //     : TwakeIconButton(
    //         imagePath: ImagePaths.icStartAIActive,
    //         size: 24.0,
    //         tooltip: 'AI help',
    //         onTap: () {},
    //       );
    return Material(
      color: MultiColors.of(context).buttonsMainSecondaryDefault,
      borderRadius: const BorderRadius.all(
        Radius.circular(MultiMobileRoundnessAndPaddings.roundnessButtonsSmall),
      ),
      child: InkWell(
        //TODO: Handle AI button
        onTap: onTapAI,
        enableFeedback: isAIActive,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 28.0,
            right: 20.0,
            top: 5.0,
            bottom: 5.0,
          ),
          child: Row(
            children: <Widget>[
              Text(
                'AI help',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
              ),
              const SizedBox(width: 8),
              SvgPicture.asset(ImagePaths.icStartAI),
            ],
          ),
        ),
      ),
    );
  }
}
