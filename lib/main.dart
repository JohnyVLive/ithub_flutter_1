import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ithub_flutter_1/firebase_options.dart';

import 'package:ithub_flutter_1/app/app.dart';
import 'package:ithub_flutter_1/repos/firebase_user_repo.dart';
import 'package:ithub_flutter_1/simple_bloc_observer.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp(FirebaseUserRepo()));
}

