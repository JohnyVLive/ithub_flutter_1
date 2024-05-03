import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ithub_flutter_1/blocs/auth_bloc/auth_bloc.dart';
import 'package:ithub_flutter_1/blocs/login_bloc/login_bloc.dart';

import 'package:ithub_flutter_1/services/snack_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isHiddenPassword = true;
  TextEditingController emailInputController = TextEditingController();
  TextEditingController passwordInputController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool loginRequired = false;
  

  @override
  void dispose() {
    emailInputController.dispose();
    passwordInputController.dispose();

    super.dispose();
  }

  void togglePasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(
        userRepository: context.read<AuthenticationBloc>().userRepository
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Войти'),
          backgroundColor: Theme.of(context).primaryColor,
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Builder(
            builder: (context){
              return BlocListener<LoginBloc, LoginState>(
                listener: (context, state){
                  if(state is LoginSuccess) {
                    setState(() {
                      loginRequired = false;
                      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                    });
                  } else if(state is LoginProcess) {
                    setState(() {
                      loginRequired = true;
                    });
                  } else if(state is LoginFailure) {
                    setState(() {
                      loginRequired = false;
                      SnackBarService.showSnackBar(
                        context,
                        'Неправильный email или пароль. Повторите попытку',
                        true,
                      );
                    });
                  }
                }, 
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      controller: emailInputController,
                      validator: (email) =>
                          email != null && !EmailValidator.validate(email)
                              ? 'Введите правильный Email'
                              : null,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Введите Email',
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      autocorrect: false,
                      controller: passwordInputController,
                      obscureText: isHiddenPassword,
                      validator: (value) => value != null && value.length < 6
                          ? 'Минимум 6 символов'
                          : null,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: 'Введите пароль',
                        suffix: InkWell(
                          onTap: togglePasswordView,
                          child: Icon(
                            isHiddenPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        context.read<LoginBloc>().add(LoginRequired(
                          emailInputController.text.trim(), 
                          passwordInputController.text.trim()
                        ));
                      },
                      child: const Center(child: Text('Войти')),
                    ),
                    const SizedBox(height: 30),
                    TextButton(
                      onPressed: () => Navigator.of(context).pushNamed('/signup'),
                      child: const Text(
                        'Регистрация',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        )
      )
    );
  }
}