import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:saasfork_design_system/views/views.dart';
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SFAuthView(
              additionalData: {
                'label_email': S.current.label_email,
                'placeholder_email': S.current.placeholder_email,
                'error_email_invalid': S.current.error_email_invalid,
                'label_password': S.current.label_password,
                'placeholder_password': S.current.placeholder_password,
                'error_password_length': S.current.error_password_length,
                'login_button': S.current.login_button,
                'register_button': S.current.register_button,
                'forgot_password_button': S.current.forgot_password_button,
                'auth_not_account': {
                  'text': S.current.auth_not_account_text,
                  'link': S.current.auth_not_account_link,
                },
                'auth_forgot_password': {
                  'link': S.current.auth_forgot_password_link,
                },
                'auth_already_exists': {
                  'text': S.current.auth_already_exists_text,
                  'link': S.current.auth_already_exists_link,
                },
              },
              onLogin: (Map<String, dynamic> loginValues) {
                setState(() {
                  values = loginValues;
                });
              },
              onRegister: (Map<String, dynamic> registerValues) {
                setState(() {
                  values = registerValues;
                });
              },
              onForgotPassword: (Map<String, dynamic> registerValues) {
                setState(() {
                  values = registerValues;
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
