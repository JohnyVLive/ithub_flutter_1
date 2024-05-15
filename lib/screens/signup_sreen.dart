import 'package:email_validator/email_validator.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:ithub_flutter_1/models/user_model.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ithub_flutter_1/blocs/auth_bloc/auth_bloc.dart';
import 'package:ithub_flutter_1/blocs/signup_bloc/signup_bloc.dart';

import 'package:ithub_flutter_1/services/snack_bar.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {
  bool isHiddenPassword = true;
  TextEditingController emailInputController = TextEditingController();
  TextEditingController passwordInputController = TextEditingController();
  TextEditingController passwordRepeatInputController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // @override
  // void dispose() {
  //   emailInputController.dispose();
  //   passwordInputController.dispose();
  //   passwordRepeatInputController.dispose();

  //   super.dispose();
  // }

  void togglePasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }

  Future<void> navigateToHome() async{
    final navigator = Navigator.of(context);
    await navigator.pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }

  // void signUp() async {
  //   final navigator = Navigator.of(context);

  //   final isValid = _formKey.currentState!.validate();
  //   if (!isValid) return;

  //   if (passwordInputController.text !=
  //       passwordRepeatInputController.text) {
  //     SnackBarService.showSnackBar(
  //       context,
  //       'Пароли должны совпадать',
  //       true,
  //     );
  //     return;
  //   }

  //   try {
  //     await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //       email: emailInputController.text.trim(),
  //       password: passwordInputController.text.trim(),
  //     );
  //   } on FirebaseAuthException catch (e) {
  //     print(e.code);

  //     if (e.code == 'email-already-in-use') {
  //       SnackBarService.showSnackBar(
  //         context,
  //         'Такой Email уже используется, повторите попытку с использованием другого Email',
  //         true,
  //       );
  //       return;
  //     } else {
  //       SnackBarService.showSnackBar(
  //         context,
  //         'Неизвестная ошибка! Попробуйте еще раз или обратитесь в поддержку.',
  //         true,
  //       );
  //     }
  //   }

  //   navigator.pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpBloc>(
      create: (context) => SignUpBloc(
        userRepository: context.read<AuthenticationBloc>().userRepository
      ),
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
                  if(state is SignUpSuccess) {
                    navigateToHome();
                    // setState(() {
                    //   navigateToHome();
                    // });
                  } else if(state is SignUpProcess) {
                    setState(() {
                    });
                  }  else if(state is SignUpFailure) {
                    // SignUpFailure.getError();

                    SnackBarService.showSnackBar(
                      context,
                      // SignUpFailure.getError(),
                      'Такой Email уже используется, повторите попытку с использованием другого Email',
                      true,
                    );  
                    return;
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
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) => value != null && value.length < 6
                            ? 'Минимум 6 символов'
                            : null,
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
                      TextFormField(
                        autocorrect: false,
                        controller: passwordRepeatInputController,
                        obscureText: isHiddenPassword,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value != null && value.length < 6) {
                            return 'Минимум 6 символов';
                          } else if (value != passwordInputController.text.trim()) {
                            return 'Пароли должны совпадать';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: 'Введите пароль еще раз',
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
                          if (_formKey.currentState!.validate()) {
                            MyUser myUser = MyUser.empty;
                            myUser = myUser.copyWith(
                              email: emailInputController.text.trim(),
                              //TODO: Add user name entry. May be..
                              // name: nameController.text,
                            );
                            setState(() {
                              context.read<SignUpBloc>().add(
                                SignUpRequired(
                                  myUser,
                                  passwordInputController.text.trim()
                                )
                              );
                            });																			
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
            }
          ),
        )
      )
    ));
  }
}