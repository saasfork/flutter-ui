import 'package:flutter/material.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';

class SFLoginForm extends StatelessWidget {
  final ComponentSize size;
  final double spacing;

  const SFLoginForm({
    super.key,
    this.size = ComponentSize.md,
    this.spacing = AppSpacing.sm,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: spacing,
      children: [
        SFFormfield(
          label: 'Email',
          input: SFTextField(placeholder: 'Enter your email', size: size),
        ),
        SFFormfield(
          label: 'Password',
          input: SFPasswordField(
            placeholder: 'Enter your password',
            size: size,
          ),
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
