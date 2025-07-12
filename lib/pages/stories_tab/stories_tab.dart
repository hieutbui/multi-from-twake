import 'package:fluffychat/pages/stories_tab/stories_tab_view.dart';
import 'package:flutter/material.dart';

class StoriesTab extends StatefulWidget {
  final Widget? bottomNavigationBar;

  const StoriesTab({
    super.key,
    this.bottomNavigationBar,
  });

  @override
  State<StatefulWidget> createState() => StoriesTabController();
}

class StoriesTabController extends State<StoriesTab> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => StoriesTabView(
        controller: this,
        bottomNavigationBar: widget.bottomNavigationBar,
      );
}
