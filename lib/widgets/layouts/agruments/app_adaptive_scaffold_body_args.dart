import 'package:equatable/equatable.dart';
import 'package:matrix/matrix.dart';

abstract class AbsAppAdaptiveScaffoldBodyArgs with EquatableMixin {
  final Client? newActiveClient;
  final bool isNewUserCreateAccount;

  const AbsAppAdaptiveScaffoldBodyArgs({
    required this.newActiveClient,
    this.isNewUserCreateAccount = false,
  });
  @override
  List<Object?> get props => [
        newActiveClient,
        isNewUserCreateAccount,
      ];
}
