import 'package:equatable/equatable.dart';

class RegistrationNicknameArgs with EquatableMixin {
  final String email;
  final String password;
  final String displayName;

  const RegistrationNicknameArgs({
    required this.email,
    required this.password,
    required this.displayName,
  });

  @override
  List<Object?> get props => [email, password, displayName];
}
