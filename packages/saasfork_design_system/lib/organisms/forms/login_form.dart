import 'package:flutter/material.dart';
import 'package:saasfork_design_system/atoms/atoms.dart';
import 'package:saasfork_design_system/molecules/molecules.dart';

class SFLoginForm extends StatelessWidget {
  const SFLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SFFormfield(
          label: 'Username',
          input: SFTextField(placeholder: 'Enter your username'),
        ),
        SFFormfield(
          label: 'Password',
          input: SFTextField(placeholder: 'Enter your password'),
        ),
        SFMainButton(label: 'Login', onPressed: () => print("cocou")),
      ],
    );
  }
}
