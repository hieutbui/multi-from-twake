import 'package:fluffychat/config/multi_sys_variables/multi_sys_colors.dart';
import 'package:fluffychat/widgets/file_widget/file_tile_widget_style.dart';
import 'package:flutter/material.dart';

class FileErrorTileWidgetStyle extends FileTileWidgetStyle {
  @override
  Color? get fileInfoColor => MultiSysColors.material().error;

  @override
  TextStyle textInformationStyle(BuildContext context) {
    return Theme.of(context).textTheme.bodySmall!.copyWith(
          color: fileInfoColor,
        );
  }

  @override
  TextStyle? textStyle(BuildContext context) {
    return Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: Theme.of(context).colorScheme.error,
        );
  }
}
