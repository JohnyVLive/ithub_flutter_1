import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ithub_flutter_1/blocs/auth_bloc/auth_bloc.dart';
import 'package:ithub_flutter_1/blocs/login_bloc/login_bloc.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final user = FirebaseAuth.instance.currentUser;

  Future<void> navigateToHome() async{
    final navigator = Navigator.of(context);
    await navigator.pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(
        userRepository: context.read<AuthenticationBloc>().userRepository
      ),
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                ),
              ),
              title: const Text('Аккаунт'),
              backgroundColor: Theme.of(context).primaryColorLight,
              centerTitle: true,
              actions: [
                IconButton(
                  icon: const Icon(Icons.logout),
                  tooltip: 'Выйти',
                  onPressed: () {
                    context.read<LoginBloc>().add(const SignOutRequired());
                    navigateToHome();
                  },
                ),
              ],
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Ваш Email: ${user?.email}'),
                  TextButton(
                    onPressed: () {
                      context.read<LoginBloc>().add(const SignOutRequired());
                      navigateToHome();
                    },
                    child: const Text('Выйти'),
                  ),
                ],
              ),
            ),
          );
        }
      )
    );
  }
}