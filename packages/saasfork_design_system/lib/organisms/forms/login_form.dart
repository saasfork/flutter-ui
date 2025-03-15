import 'package:flutter/material.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';

class SFLoginForm extends StatelessWidget {
  final ComponentSize size;
  final double spacing;

  const SFLoginForm({
    super.key,
    this.size = ComponentSize.md,
    this.spacing = AppSpacing.md,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: spacing,
      children: [
        SFFormfield(
          label: 'Username',
          input: SFTextField(placeholder: 'Enter your username', size: size),
          hintMessage: 'Please provide your username',
        ),
        SFFormfield(
          label: 'Password',
          input: SFTextField(placeholder: 'Enter your password', size: size),
        ),
        SFMainButton(
          label: 'Login',
          onPressed: () => print("cocou"),
          size: size,
        ),
      ],
    );
  }
}
