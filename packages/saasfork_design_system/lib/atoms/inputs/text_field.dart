import 'package:flutter/material.dart';

class SFTextField extends StatelessWidget {
  final String placeholder;
  final bool isInError;

  const SFTextField({
    required this.placeholder,
    required this.isInError,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextField(
      decoration: InputDecoration(
        hintText: placeholder,
        enabledBorder:
            isInError
                ? theme.inputDecorationTheme.errorBorder
                : theme.inputDecorationTheme.enabledBorder,
        focusedBorder:
            isInError
                ? theme.inputDecorationTheme.focusedErrorBorder
                : theme.inputDecorationTheme.focusedBorder,
      ),
    );
  }
}
