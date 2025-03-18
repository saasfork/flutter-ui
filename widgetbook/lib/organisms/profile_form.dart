import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: SFProfileForm)
Widget buildProfileFormUseCase(BuildContext context) {
  return ProfileFormUseCase();
}

class ProfileFormUseCase extends StatefulWidget {
  const ProfileFormUseCase({super.key});

  @override
  State<ProfileFormUseCase> createState() => _ProfileFormUseCaseState();
}

class _ProfileFormUseCaseState extends State<ProfileFormUseCase> {
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
          SFProfileForm(
            size: size,
            onSubmit: (value) {
              setState(() {
                values = value;
              });
            },
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (values.isNotEmpty)
                Text(
                  'Submitted Values:',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              if (values.isNotEmpty)
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
