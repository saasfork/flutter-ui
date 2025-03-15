import 'package:flutter/material.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';

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
    final inputTheme = theme.inputDecorationTheme;

    // Création d'un style de hint pour l'état d'erreur
    final TextStyle? errorHintStyle = inputTheme.hintStyle?.copyWith(
      color:
          inputTheme.errorBorder is OutlineInputBorder
              ? (inputTheme.errorBorder as OutlineInputBorder).borderSide.color
              : AppColors.red.s300,
    );

    return TextField(
      decoration: InputDecoration(
        hintText: placeholder,
        hintStyle: isInError ? errorHintStyle : inputTheme.hintStyle,
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
