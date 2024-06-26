import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ithub_flutter_1/repos/user_repo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;
	late final StreamSubscription<User?> _userSubscription;

	AuthenticationBloc({
		required this.userRepository
	}) : super(const AuthenticationState.unknown()) {
    _userSubscription = userRepository.user.listen((user) {
			add(AuthenticationUserChanged(user));
		});
		on<AuthenticationUserChanged>((event, emit) {
			if(event.user != null) {
				emit(AuthenticationState.authenticated(event.user!));
			} else {
				emit(const AuthenticationState.unauthenticated());
			}
		});
  }
	
	@override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
