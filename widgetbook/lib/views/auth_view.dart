import 'package:flutter/material.dart';
import 'package:saasfork_design_system/views/views.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:widgetbook_workspace/generated/l10n.dart';

@widgetbook.UseCase(name: 'Default', type: SFAuthView)
Widget buildAuthViewUseCase(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: SFAuthView(
      additionalData: {
        'label_email': S.current.label_email,
        'placeholder_email': S.current.placeholder_email,
        'error_email_invalid': S.current.error_email_invalid,
        'label_password': S.current.label_password,
        'placeholder_password': S.current.placeholder_password,
        'error_password_length': S.current.error_password_length,
        'login_button': S.current.login_button,
        'auth_not_account': {
          'text': S.current.auth_not_account_text,
          'link': S.current.auth_not_account_link,
        },
        'auth_forgot_password': {'link': S.current.auth_forgot_password_link},
        'auth_already_exists': {
          'text': S.current.auth_already_exists_text,
          'link': S.current.auth_already_exists_link,
        },
      },
    ),
  );
}
