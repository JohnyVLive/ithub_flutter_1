part of 'login_bloc.dart';

class LoginState extends Equatable{
  const LoginState();
  
  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
	final String? message;

	const LoginFailure({this.message});
}

class LoginProcess extends LoginState {}

class PasswordStatus extends LoginState{
  static bool isHiddenPassword = true;

}