import 'package:fluffychat/domain/model/app_grid/linagora_applications.dart';
import 'package:fluffychat/pages/app_grid/app_grid_dashboard_item.dart';
import 'package:fluffychat/pages/app_grid/app_grid_dashboard_overlay_style.dart';
import 'package:flutter/material.dart';

class AppGridDashboardOverlay extends StatelessWidget {
  final LinagoraApplications _linagoraApplications;

  const AppGridDashboardOverlay(this._linagoraApplications, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: AppGridDashboardOverlayStyle.margin,
      width: AppGridDashboardOverlayStyle.widthAppGrid(_linagoraApplications),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(
          AppGridDashboardOverlayStyle.borderRadius,
        ),
      ),
      padding: AppGridDashboardOverlayStyle.padding,
      child: Wrap(
        children: _linagoraApplications.apps
            .map((app) => AppGridDashboardItem(app))
            .toList(),
      ),
    );
  }
}
