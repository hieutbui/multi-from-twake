import 'package:fluffychat/pages/voice_tab/voice_tab_view.dart';
import 'package:flutter/material.dart';

class VoiceTab extends StatefulWidget {
  final Widget? bottomNavigationBar;

  const VoiceTab({super.key, this.bottomNavigationBar});

  @override
  VoiceTabController createState() => VoiceTabController();
}

class VoiceTabController extends State<VoiceTab> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VoiceTabView(
      controller: this,
      bottomNavigationBar: widget.bottomNavigationBar,
    );
  }
}
