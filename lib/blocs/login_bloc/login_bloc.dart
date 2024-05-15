import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ithub_flutter_1/repos/user_repo.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
	final UserRepository _userRepository;
	
  LoginBloc({
		required UserRepository userRepository
	}) : _userRepository = userRepository,
		super(LoginInitial()) {
      on<LoginRequired>(_login);
      on<SignOutRequired>(_signOut);
      on<PasswordViewRequired>(_togglePasswordView);
    }

    Future<void> _login(event, emit) async {
      emit(LoginProcess());
      try {
        await _userRepository.signIn(event.email, event.password);

				emit(
          LoginSuccess(),
        );

        if (state == LoginSuccess()){
          Navigator.pushNamedAndRemoveUntil(event.context, '/', (route) => false);
        }

      } 
      on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-credential') {
          emit(const LoginFailure(message: 'Неправильный email или пароль. Повторите попытку'));
        }
			} 
    }

    Future<void> _signOut(event, emit) async {
      await _userRepository.signOut();
    }


    void _togglePasswordView(event, emit){
      emit (
        PasswordStatus.isHiddenPassword = !PasswordStatus.isHiddenPassword
      );
    }
}