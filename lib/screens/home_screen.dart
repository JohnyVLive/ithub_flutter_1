import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ithub_flutter_1/screens/login_screen.dart';
import 'package:ithub_flutter_1/screens/account_screen.dart';
// import 'package:ithub_flutter_1/screens/weather_screen.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Главная страница'),
        backgroundColor: Theme.of(context).primaryColorLight,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              if (user == null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AccountScreen()),
                );
              }
            },
            icon: (user == null)
              ? const Icon(Icons.lock_person_sharp, color: Colors.red) 
              : const Icon(Icons.person_2_rounded, color: Colors.green),
          ),
        ],
      ),
      body: (user == null) 
        ? const Text('НЕ Авторизован! Если авторизуешься будет много интересного!')
        //TODO: Добавить возможность выбирать приложения. Иконки приложений..
        : Center(
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
        ),
    );
  }
}