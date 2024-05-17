import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ithub_flutter_1/models/user_model.dart';
import 'package:ithub_flutter_1/repos/user_repo.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
	final UserRepository _userRepository;

  SignUpBloc({
		required UserRepository userRepository
	}) : _userRepository = userRepository,
		super(const SignUpInitial(isHiddenPassword: true)) {
      on<SignUpRequired>(_signUp);
      on<PasswordViewTaped>(_togglePasswordView);
    }
    
    
  Future<void> _signUp(event, emit) async {
    emit(const SignUpProcess(isHiddenPassword: true));

    try {
      MyUser user = await _userRepository.signUp(event.user, event.password);
      await _userRepository.setUserData(user);

      emit(SignUpSuccess(isHiddenPassword: state.isHiddenPassword));
      if (state == SignUpSuccess(isHiddenPassword: state.isHiddenPassword)){
          Navigator.pushNamedAndRemoveUntil(event.context, '/', (route) => false);
      }

    } on FirebaseException catch (e) {
      if (e.code == 'email-already-in-use') {
        emit(SignUpFailure(
          message: 'Такой Email уже используется, повторите попытку с использованием другого Email',
          isHiddenPassword: state.isHiddenPassword
        ));
      } else {
        emit(const SignUpFailure(
          message: 'Неизвестная ошибка! Попробуйте еще раз или обратитесь в поддержку.',
          isHiddenPassword: true
        ));
      }
    }
  }

  Future<void> _togglePasswordView(event, emit) async{
    state.isHiddenPassword 
      ? emit(const PasswordStatusShow(isHiddenPassword: false))
      : emit(const PasswordStatusHide(isHiddenPassword: true));
  }
}