part of 'login_bloc.dart';

sealed class LoginEvent {
  const LoginEvent();

  // @override
  // List<Object> get props => [];
}

class LoginRequired extends LoginEvent{
	final String email;
	final String password;
  final BuildContext context;

  const LoginRequired(this.email, this.password, this.context);
}

class SignOutRequired extends LoginEvent{
	const SignOutRequired();
}

class PasswordViewRequired extends LoginEvent{

}