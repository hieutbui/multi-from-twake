import 'dart:async';
import 'package:fluffychat/pages/bootstrap/tom_bootstrap_dialog_mobile_view.dart';
import 'package:fluffychat/pages/bootstrap/tom_bootstrap_dialog_web_view.dart';
import 'package:fluffychat/presentation/model/client_login_state_event.dart';
import 'package:fluffychat/utils/responsive/responsive_utils.dart';
import 'package:fluffychat/widgets/layouts/agruments/logged_in_body_args.dart';
import 'package:fluffychat/widgets/layouts/agruments/logged_in_other_account_body_args.dart';
import 'package:fluffychat/widgets/matrix.dart';
import 'package:fluffychat/widgets/twake_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:matrix/matrix.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class InitClientDialog extends StatefulWidget {
  final Future Function() future;
  final bool isNewUserCreateAccount;

  const InitClientDialog({
    super.key,
    required this.future,
    this.isNewUserCreateAccount = false,
  });

  @override
  State<InitClientDialog> createState() => _InitClientDialogState();
}

class _InitClientDialogState extends State<InitClientDialog>
    with TickerProviderStateMixin {
  late AnimationController loadingProgressController;

  Client? _clientFirstLoggedIn;

  Client? _clientAddAnotherAccount;

  StreamSubscription? _clientLoginStateChangedSubscription;

  static const breakpointMobileDialogKey =
      Key('BreakPointMobileInitClientDialog');

  static const breakpointWebAndDesktopDialogKey =
      Key('BreakpointWebAndDesktopKeyInitClientDialog');

  @override
  void initState() {
    _initial();
    _clientLoginStateChangedSubscription =
        Matrix.of(context).onClientLoginStateChanged.stream.listen(
              _listenClientLoginStateChanged,
            );
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        _startLoadingProgress();
        await widget
            .future()
            .then(
              (_) => _handleFunctionOnDone(),
            )
            .onError(
              (error, _) => _handleFunctionOnError(error),
            );
      },
    );

    super.initState();
  }

  void _listenClientLoginStateChanged(ClientLoginStateEvent event) {
    Logs().i(
      'StreamDialogBuilder::_listenClientLoginStateChanged - ${event.multipleAccountLoginType}',
    );
    if (event.multipleAccountLoginType ==
        MultipleAccountLoginType.firstLoggedIn) {
      _clientFirstLoggedIn = event.client;
      return;
    }

    if (event.multipleAccountLoginType ==
        MultipleAccountLoginType.otherAccountLoggedIn) {
      _clientAddAnotherAccount = event.client;
      return;
    }
  }

  void _handleFunctionOnDone() async {
    Logs().i('StreamDialogBuilder::_handleFunctionOnDone');
    Navigator.of(context, rootNavigator: false).pop();
    if (_clientFirstLoggedIn != null) {
      _handleFirstLoggedIn(_clientFirstLoggedIn!);
      return;
    }

    if (_clientAddAnotherAccount != null) {
      _handleAddAnotherAccount(_clientAddAnotherAccount!);
      return;
    }
  }

  void _handleFunctionOnError(Object? error) {
    Logs().e('StreamDialogBuilder::_handleFunctionOnError - $error');
    Navigator.pop(context);
  }

  void _handleFirstLoggedIn(Client client) {
    TwakeApp.router.go(
      '/rooms',
      extra: LoggedInBodyArgs(
        newActiveClient: client,
        isNewUserCreateAccount: widget.isNewUserCreateAccount,
      ),
    );
  }

  void _handleAddAnotherAccount(Client client) {
    TwakeApp.router.go(
      '/rooms',
      extra: LoggedInOtherAccountBodyArgs(
        newActiveClient: client,
      ),
    );
  }

  void _initial() {
    loadingProgressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
  }

  void _startLoadingProgress() {
    loadingProgressController.addListener(() {
      setState(() {});
    });
    loadingProgressController.repeat();
  }

  @override
  void dispose() {
    loadingProgressController.dispose();
    _clientLoginStateChangedSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlotLayout(
      config: <Breakpoint, SlotLayoutConfig>{
        const WidthPlatformBreakpoint(
          end: ResponsiveUtils.maxMobileWidth,
        ): SlotLayout.from(
          key: breakpointMobileDialogKey,
          builder: (_) => TomBootstrapDialogMobileView(
            description: L10n.of(context)!.backingUpYourMessage,
          ),
        ),
        const WidthPlatformBreakpoint(
          begin: ResponsiveUtils.minTabletWidth,
        ): SlotLayout.from(
          key: breakpointWebAndDesktopDialogKey,
          builder: (_) => TomBootstrapDialogWebView(
            description: L10n.of(context)!.backingUpYourMessage,
          ),
        ),
      },
    );
  }
}
