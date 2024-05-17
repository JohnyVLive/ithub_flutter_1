part of 'signup_bloc.dart';

sealed class SignUpState extends Equatable {
  const SignUpState({required this.isHiddenPassword});
  final bool isHiddenPassword;
  
  @override
  List<Object> get props => [];
}

final class SignUpInitial extends SignUpState {
  const SignUpInitial({required super.isHiddenPassword});
}

class SignUpSuccess extends SignUpState {
  const SignUpSuccess({required super.isHiddenPassword});
}


class SignUpFailure extends SignUpState {
  final String? message;
	const SignUpFailure({required this.message, required super.isHiddenPassword});
}

class SignUpProcess extends SignUpState {
  const SignUpProcess({required super.isHiddenPassword});
}

class PasswordStatusShow extends SignUpState{
  const PasswordStatusShow({required super.isHiddenPassword});
}

class PasswordStatusHide extends SignUpState{
  const PasswordStatusHide({required super.isHiddenPassword});
}
