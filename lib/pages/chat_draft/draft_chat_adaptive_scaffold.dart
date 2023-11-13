import 'package:fluffychat/pages/profile_info/profile_info.dart';
import 'package:fluffychat/pages/chat_draft/draft_chat.dart';
import 'package:fluffychat/presentation/enum/chat/right_column_type_enum.dart';
import 'package:fluffychat/presentation/model/presentation_contact.dart';
import 'package:fluffychat/presentation/model/presentation_contact_constant.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:fluffychat/pages/chat_adaptive_scaffold/chat_adaptive_scaffold_builder.dart';

class DraftChatAdaptiveScaffold extends StatelessWidget {
  final GoRouterState state;

  const DraftChatAdaptiveScaffold({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChatAdaptiveScaffoldBuilder(
      bodyBuilder: (controller) => DraftChat(
        contact: _contact,
        onChangeRightColumnType: controller.setRightColumnType,
      ),
      rightBuilder: (
        controller, {
        required bool isInStack,
        required RightColumnType type,
      }) {
        return Navigator(
          initialRoute: type.initialRoute,
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case RightColumnRouteNames.profileInfo:
                return MaterialPageRoute(
                  builder: (_) => ProfileInfo(
                    onBack: controller.hideRightColumn,
                    contact: _contact,
                    isInStack: isInStack,
                  ),
                );
            }
            return MaterialPageRoute(builder: (_) => const SizedBox());
          },
        );
      },
    );
  }

  PresentationContact get _contact {
    final extra = state.extra as Map<String, String>;
    if (extra.isNotEmpty) {
      return PresentationContact(
        matrixId: extra[PresentationContactConstant.receiverId],
        email: extra[PresentationContactConstant.email],
        displayName: extra[PresentationContactConstant.displayName],
      );
    } else {
      return const PresentationContact().presentationContactEmpty;
    }
  }
}
