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
		on<LoginRequired>((event, emit) async {
			emit(LoginProcess());
      try {
        await _userRepository.signIn(event.email, event.password);
				emit(LoginSuccess());
      } on FirebaseAuthException catch (e) {
				emit(LoginFailure(message: e.code));
			} catch (e) {
				emit(const LoginFailure());
      }
    });
		on<SignOutRequired>((event, emit) async {
			await _userRepository.signOut();
    });
  }
}