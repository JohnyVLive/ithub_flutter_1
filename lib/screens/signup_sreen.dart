import 'package:email_validator/email_validator.dart';
import 'package:ithub_flutter_1/models/user_model.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ithub_flutter_1/blocs/auth_bloc/auth_bloc.dart';
import 'package:ithub_flutter_1/blocs/signup_bloc/signup_bloc.dart';

import 'package:ithub_flutter_1/services/snack_bar.dart';


class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final TextEditingController emailInputController = TextEditingController();
  final TextEditingController passwordInputController = TextEditingController();
  final TextEditingController passwordRepeatInputController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpBloc>(
        create: (context) => SignUpBloc(
            userRepository: context.read<AuthenticationBloc>().userRepository),
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: const Text('Зарегистрироваться'),
              backgroundColor: Theme.of(context).primaryColor,
              centerTitle: true,
            ),
            body: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Builder(
                  builder: ((context) {
                    return BlocListener<SignUpBloc, SignUpState>(
                      listener: (context, state) {
                        if (state is SignUpFailure) {
                          SnackBarService.showSnackBar(
                            context,
                            state.message,
                            true,
                          );
                        }
                      },
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              autocorrect: false,
                              controller: emailInputController,
                              validator: (email) => email != null &&
                                      !EmailValidator.validate(email)
                                  ? 'Введите правильный Email'
                                  : null,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Введите Email',
                              ),
                            ),
                            const SizedBox(height: 30),
                            BlocBuilder<SignUpBloc, SignUpState>(
                              builder: (context, state) {
                                return TextFormField(
                                  autocorrect: false,
                                  controller: passwordInputController,
                                  obscureText: state.isHiddenPassword,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) =>
                                      value != null && value.length < 6
                                          ? 'Минимум 6 символов'
                                          : null,
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(),
                                    hintText: 'Введите пароль',
                                    suffix: InkWell(
                                      onTap: () {
                                        context
                                            .read<SignUpBloc>()
                                            .add(PasswordViewTaped());
                                      },
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
                            BlocBuilder<SignUpBloc, SignUpState>(
                              builder: (context, state) {
                                return TextFormField(
                                  autocorrect: false,
                                  controller: passwordRepeatInputController,
                                  obscureText: state.isHiddenPassword,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    if (value != null && value.length < 6) {
                                      return 'Минимум 6 символов';
                                    } else if (value !=
                                        passwordInputController.text.trim()) {
                                      return 'Пароли должны совпадать';
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(),
                                    hintText: 'Введите пароль еще раз',
                                    suffix: InkWell(
                                      onTap: () {
                                        context
                                          .read<SignUpBloc>()
                                          .add(PasswordViewTaped());
                                      },
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
                                if (_formKey.currentState!.validate()) {
                                  MyUser myUser = MyUser.empty;
                                  myUser = myUser.copyWith(
                                    email: emailInputController.text.trim(),
                                    //TODO: Add user name entry. May be..
                                    // name: nameController.text,
                                  );

                                  context.read<SignUpBloc>().add(SignUpRequired(
                                      myUser,
                                      passwordInputController.text.trim(),
                                      context));
                                }
                              },
                              child: const Center(child: Text('Регистрация')),
                            ),
                            const SizedBox(height: 30),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text(
                                'Войти',
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
        )
    );
  }
}

