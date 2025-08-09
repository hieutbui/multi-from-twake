import 'package:fluffychat/widgets/layouts/agruments/app_adaptive_scaffold_body_args.dart';

class LoggedInBodyArgs extends AbsAppAdaptiveScaffoldBodyArgs {
  const LoggedInBodyArgs({
    required super.newActiveClient,
    super.isNewUserCreateAccount,
  });

  @override
  List<Object?> get props => [
        newActiveClient,
        isNewUserCreateAccount,
      ];
}
