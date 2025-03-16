import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:widgetbook_workspace/generated/l10n.dart';

@widgetbook.UseCase(name: 'Default', type: SFAuthView)
Widget buildAuthViewUseCase(BuildContext context) {
  return AuthView();
}

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  Map<String, dynamic> values = {};

  @override
  Widget build(BuildContext context) {
    final authTextData = AuthFormData(
      labelEmail: S.current.label_email,
      placeholderEmail: S.current.placeholder_email,
      errorEmailInvalid: S.current.error_email_invalid,
      labelPassword: S.current.label_password,
      placeholderPassword: S.current.placeholder_password,
      errorPasswordLength: S.current.error_password_length,
      loginButton: S.current.login_button,
      registerButton: S.current.register_button,
      forgotPasswordButton: S.current.forgot_password_button,
      authNotAccount: LinkTextPair(
        text: S.current.auth_not_account_text,
        link: S.current.auth_not_account_link,
      ),
      authForgotPassword: LinkTextPair(
        link: S.current.auth_forgot_password_link,
      ),
      authAlreadyExists: LinkTextPair(
        text: S.current.auth_already_exists_text,
        link: S.current.auth_already_exists_link,
      ),
    );

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SFAuthView(
              additionalData: authTextData,
              onLogin: (LoginModel loginValues) {
                setState(() {
                  values = loginValues.toMap();
                });
              },
              onRegister: (RegisterModel registerValues) {
                setState(() {
                  values = registerValues.toMap();
                });
              },
              onForgotPassword: (ForgotPasswordModel forgotPasswordValues) {
                setState(() {
                  values = forgotPasswordValues.toMap();
                });
              },
            ),
          ),
          if (values.isNotEmpty)
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Submitted Values:',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    JsonEncoder.withIndent('  ').convert(values),
                    style: TextStyle(fontFamily: 'monospace', fontSize: 14),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
