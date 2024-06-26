import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ithub_flutter_1/blocs/auth_bloc/auth_bloc.dart';
import 'package:ithub_flutter_1/blocs/login_bloc/login_bloc.dart';

import 'package:ithub_flutter_1/services/snack_bar.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailInputController = TextEditingController();
  final TextEditingController passwordInputController = TextEditingController();
  final formKey = GlobalKey<FormState>();


 @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(
            userRepository: context.read<AuthenticationBloc>().userRepository),
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: const Text('Войти'),
              backgroundColor: Theme.of(context).primaryColor,
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Builder(builder: (context) {
                return BlocListener<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state is LoginFailure) {
                      SnackBarService.showSnackBar(
                        context,
                        state.message,
                        true,
                      );
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
                        BlocBuilder<LoginBloc, LoginState>(
                          builder: (context, state) {
                            return TextFormField(
                              autocorrect: false,
                              controller: passwordInputController,
                              obscureText: state.isHiddenPassword,
                              validator: (value) =>
                                  value != null && value.length < 6
                                      ? 'Минимум 6 символов'
                                      : null,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                hintText: 'Введите пароль',
                                suffix: InkWell(
                                  onTap: () {
                                    context.read<LoginBloc>().add(PasswordViewTaped());
                                  },
                                  // onTap: togglePasswordView,
                                  child: Icon(
                                    state.isHiddenPassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: () {
                            context.read<LoginBloc>().add(LoginRequired(
                                emailInputController.text.trim(),
                                passwordInputController.text.trim(),
                                context));
                          },
                          child: const Center(child: Text('Войти')),
                        ),
                        const SizedBox(height: 30),
                        TextButton(
                          onPressed: () =>
                              Navigator.of(context).pushNamed('/signup'),
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
            )));
  }
}