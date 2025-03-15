import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: SFLoginForm)
Widget buildCoolButtonUseCase(BuildContext context) {
  return LoginFormUseCase();
}

class LoginFormUseCase extends StatefulWidget {
  const LoginFormUseCase({super.key});

  @override
  State<LoginFormUseCase> createState() => _LoginFormUseCaseState();
}

class _LoginFormUseCaseState extends State<LoginFormUseCase> {
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
          SFLoginForm(
            size: size,
            onSubmit: (value) {
              setState(() {
                values = value;
              });
            },
          ),

          // render values
          if (values.isNotEmpty)
            Text(
              'Submitted Values: ${JsonEncoder.withIndent('  ').convert(values)}',
              style: TextStyle(fontSize: 22),
            ),
        ],
      ),
    );
  }
}
