import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: SFRegisterForm)
Widget buildRegisterFormUseCase(BuildContext context) {
  return RegisterFormUseCase();
}

class RegisterFormUseCase extends StatefulWidget {
  const RegisterFormUseCase({super.key});

  @override
  State<RegisterFormUseCase> createState() => _RegisterFormUseCaseState();
}

class _RegisterFormUseCaseState extends State<RegisterFormUseCase> {
  Map<String, dynamic> values = {};

  @override
  Widget build(BuildContext context) {
    final size = context.knobs.list<ComponentSize>(
      label: 'Button Size',
      options: ComponentSize.values,
      initialOption: ComponentSize.md,
      description: 'Size of the button',
    );

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          SFRegisterForm(
            size: size,
            onSubmit: (value) {
              setState(() {
                values = value;
              });
            },
          ),

          if (values.isNotEmpty)
            Column(
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
        ],
      ),
    );
  }
}
