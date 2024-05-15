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
		super(LoginInitial(isHiddenPassword: true)) {
      on<LoginRequired>(_login);
      on<SignOutRequired>(_signOut);
      on<PasswordViewTaped>(_togglePasswordView);
    }

    Future<void> _login(event, emit) async {
      emit(LoginProcess(isHiddenPassword: true));
      try {
        await _userRepository.signIn(event.email, event.password);

				emit(
          LoginSuccess(isHiddenPassword: true)
        );

        if (state == LoginSuccess(isHiddenPassword: true)){
          Navigator.pushNamedAndRemoveUntil(event.context, '/', (route) => false);
        }

      } 
      on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-credential') {
          emit(const LoginFailure(message: 'Неправильный email или пароль. Повторите попытку', isHiddenPassword: true));
        }
			} 
    }

    Future<void> _signOut(event, emit) async {
      await _userRepository.signOut();
    }

    Future<void> _togglePasswordView(event, emit) async{
      if (state.isHiddenPassword){
        emit(PasswordStatus(isHiddenPassword: false));
        print(state.isHiddenPassword);
      } else {
        emit(PasswordStatus(isHiddenPassword: true));
        print(state.isHiddenPassword);
      }

      // emit(LoginInitial(isHiddenPassword: !state.isHiddenPassword));
      print(state.isHiddenPassword);

    }
}