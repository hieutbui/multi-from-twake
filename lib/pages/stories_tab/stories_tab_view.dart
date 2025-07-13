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
      backgroundColor: Colors.black.withOpacity(0.5),
      appBar: AppBar(
        title: const Text('Stories'),
        flexibleSpace: Container(
          decoration: const ShapeDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.50, -0.00),
              end: Alignment(0.50, 1.00),
              colors: [Color(0xFF0E0F13), Color(0xFF232631)],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
          ),
        ),
        backgroundColor: Colors.black.withOpacity(0.5),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.50, -0.00),
            end: Alignment(0.50, 1.00),
            colors: [
              Color(0xFF0E0F13),
              Color(0xFF191B26),
            ],
          ),
        ),
        child: const Center(
          child: Text('Coming soon...', style: TextStyle(color: Colors.white)),
        ),
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
