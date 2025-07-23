import 'package:fluffychat/config/multi_sys_variables/multi_colors.dart';
import 'package:fluffychat/config/multi_sys_variables/multi_typography.dart';
import 'package:flutter/material.dart';

class InfoCardWidget extends StatelessWidget {
  const InfoCardWidget({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: MultiMobileTypography.captionFontCaption2,
            fontWeight: FontWeight.w400,
            color: MultiColors.of(context).textMainTertiaryDisabled,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: MultiMobileTypography.bodyFontBody,
            fontWeight: FontWeight.w400,
            color: MultiColors.of(context).textMainPrimaryDefault,
          ),
        ),
      ],
    );
  }
}
