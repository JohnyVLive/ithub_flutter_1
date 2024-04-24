import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ithub_flutter_1/firebase_options.dart';

import 'package:ithub_flutter_1/app/app.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  runApp(const MyApp());
}

