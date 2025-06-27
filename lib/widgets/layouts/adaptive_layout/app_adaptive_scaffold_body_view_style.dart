import 'package:flutter/cupertino.dart';
import 'package:linagora_design_flutter/colors/linagora_state_layer.dart';
import 'package:fluffychat/config/multi_sys_variables/multi_sys_colors.dart';

class AppAdaptiveScaffoldBodyViewStyle {
  static const double elevation = 0.0;

  static const EdgeInsets paddingBottomNavigation = EdgeInsets.only(
    top: 4,
  );

  static BoxDecoration navBarBorder = BoxDecoration(
    color: MultiSysColors.material().surface,
    border: Border(
      top: BorderSide(
        color: LinagoraStateLayer(
          MultiSysColors.material().surfaceTint,
        ).opacityLayer3,
      ),
    ),
  );
}
