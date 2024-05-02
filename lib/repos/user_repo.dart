import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';

abstract class UserRepository {
	Stream<User?> get user;

  Future<void> signIn(String email, String password);

	Future<MyUser> signUp(MyUser myUser, String password);

	Future<void> setUserData(MyUser user);

	Future<void> logOut();
}