part of 'signup_bloc.dart';

sealed class SignUpState extends Equatable {
  const SignUpState();
  
  @override
  List<Object> get props => [];
}

final class SignUpInitial extends SignUpState {}

class SignUpSuccess extends SignUpState {}

class SignUpFailure extends SignUpState {

  // const SignUpFailure(String string);
  // static String? error;

  // static getError<String>(){
  //   return error;
  // }
}

class SignUpProcess extends SignUpState {}
