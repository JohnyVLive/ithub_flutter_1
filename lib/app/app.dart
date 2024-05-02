import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ithub_flutter_1/blocs/auth_bloc/auth_bloc.dart';
import 'package:ithub_flutter_1/repos/user_repo.dart';
import 'package:ithub_flutter_1/services/firebase_stream.dart';

import 'package:ithub_flutter_1/screens/home_screen.dart';
import 'package:ithub_flutter_1/screens/login_screen.dart';
import 'package:ithub_flutter_1/screens/account_screen.dart';
import 'package:ithub_flutter_1/screens/signup_sreen.dart';
import 'package:ithub_flutter_1/screens/weather_screen.dart';

class MyApp extends StatelessWidget {
  final UserRepository userRepository;
  const MyApp(this.userRepository, {super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<AuthenticationBloc>(
      create: (context) => AuthenticationBloc(userRepository: userRepository),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 112, 255, 64)),
          useMaterial3: true,
        ),

        routes: {
          '/': (context) => const FirebaseStream(), // Проверка состояния пользователя.

          '/home': (context) => const HomeScreen(), // Домашняя главная страница

          '/login': (context) => const LoginScreen(), // Страница авторизации
          '/account': (context) => const AccountScreen(), // Страница управления аккаунтом
          '/signup': (context) => const SignUpScreen(), // Страница регистрации

          '/weather': (context) => const WeatherScreen(), // Страница с погодой
        },
      ),
    );

    
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   theme: ThemeData(
    //     colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 112, 255, 64)),
    //     useMaterial3: true,
    //   ),

    //   routes: {

    //     '/': (context) => const FirebaseStream(), // Проверка состояния пользователя.

    //     '/home': (context) => const HomeScreen(), // Домашняя главная страница

    //     '/login': (context) => const LoginScreen(), // Страница авторизации
    //     '/account': (context) => const AccountScreen(), // Страница управления аккаунтом
    //     '/signup': (context) => const SignUpScreen(), // Страница регистрации

    //     '/weather': (context) => const WeatherScreen(), // Страница с погодой
    //   },
    // );
  }
}