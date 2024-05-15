part of 'login_bloc.dart';


class LoginState extends Equatable{
  const LoginState({required this.isHiddenPassword});
  final bool isHiddenPassword;
  
  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {
  LoginInitial({required super.isHiddenPassword});
}

class LoginSuccess extends LoginState {
  LoginSuccess({required super.isHiddenPassword});
}

class LoginFailure extends LoginState {
	final String? message;

	const LoginFailure({this.message, required super.isHiddenPassword});
}

class LoginProcess extends LoginState {
  LoginProcess({required super.isHiddenPassword});
}

class PasswordStatus extends LoginState{
  PasswordStatus({required super.isHiddenPassword});
}