part of 'login_bloc.dart';


class LoginState extends Equatable{
  const LoginState({required this.isHiddenPassword});
  final bool isHiddenPassword;
  
  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {
  const LoginInitial({required super.isHiddenPassword});
}

class LoginSuccess extends LoginState {
  const LoginSuccess({required super.isHiddenPassword});
}

class LoginFailure extends LoginState {
	final String? message;

	const LoginFailure({this.message, required super.isHiddenPassword});
}

class LoginProcess extends LoginState {
  const LoginProcess({required super.isHiddenPassword});
}

class PasswordStatusShow extends LoginState{
  const PasswordStatusShow({required super.isHiddenPassword});
}

class PasswordStatusHide extends LoginState{
  const PasswordStatusHide({required super.isHiddenPassword});
}