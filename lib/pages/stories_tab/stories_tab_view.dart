import 'package:fluffychat/pages/stories_tab/stories_tab.dart';
import 'package:flutter/material.dart';

class StoriesTabView extends StatelessWidget {
  final StoriesTabController controller;
  final Widget? bottomNavigationBar;

  const StoriesTabView({
    super.key,
    required this.controller,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Coming soon...', style: TextStyle(color: Colors.black)),
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
