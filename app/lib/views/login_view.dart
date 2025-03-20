import 'dart:convert';

import 'package:app/constants.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';
import 'package:saasfork_firebase_service/firebase_auth_provider.dart';

@RoutePage()
class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SFAuthView(
              additionalData: AuthFormData(
                labelEmail: 'Email',
                labelPassword: 'Password',
                placeholderEmail: 'Enter your email',
                placeholderPassword: 'Enter your password',
                errorEmailInvalid: 'Invalid email address',
                errorPasswordLength: 'Password must be at least 6 characters',
                loginButton: 'Login',
                registerButton: 'Register',
                forgotPasswordButton: 'Forgot Password?',
                authNotAccount: LinkTextPair(link: 'Create an account here'),
                authAlreadyExists: LinkTextPair(
                  link: 'Account already exists, login here',
                ),
                authForgotPassword: LinkTextPair(
                  link: 'Forgot your password? Reset it here',
                ),
              ),
              onRegister: (RegisterModel registerModel) async {
                final String email = registerModel.email;
                final String password = registerModel.password;
                await ref.read(authProvider.notifier).register(email, password);

                AutoRouter.of(context).pushPath(homePath);
              },
              onLogin: (LoginModel loginModel) async {
                final String email = loginModel.email;
                final String password = loginModel.password;
                await ref.read(authProvider.notifier).login(email, password);

                AutoRouter.of(context).pushPath(homePath);
              },
            ),
          ),
          Text(JsonEncoder.withIndent('  ').convert(authState.toJson())),
        ],
      ),
    );
  }
}
