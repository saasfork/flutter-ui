import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';
import 'package:saasfork_firebase_service/firebase_auth_provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    final firebaseAuthProvider = Provider.of<SFFirebaseAuthProvider>(context);

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
                await firebaseAuthProvider.register(email, password);
              },
            ),
          ),
          Text(
            JsonEncoder.withIndent(
              '  ',
            ).convert(firebaseAuthProvider.currentUser?.toJson()),
          ),
        ],
      ),
    );
  }
}
