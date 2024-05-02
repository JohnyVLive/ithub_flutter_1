import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ithub_flutter_1/blocs/auth_bloc/auth_bloc.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Главная страница'),
        backgroundColor: Theme.of(context).primaryColorLight,
        centerTitle: true,
        actions: [
          BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state){
              if (state.status == AuthenticationStatus.authenticated){
                return IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/account');
                  },
                  icon: const Icon(Icons.person_2_rounded, color: Colors.green),
                );
              } else {
                return IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  icon: const Icon(Icons.lock_person_sharp, color: Colors.red),
                );
              }
            }
          ),
        ],
      ),
      body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state.status == AuthenticationStatus.unauthenticated){
            return const Text('НЕ Авторизован! Если авторизуешься будет много интересного!');
          } else {
            return Center(
            child: 
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.cloud_circle),
                    iconSize: 100,
                    onPressed: () {
                      Navigator.pushNamed(context, '/weather');
                    }, 
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}