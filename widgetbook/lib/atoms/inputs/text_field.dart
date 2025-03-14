import 'package:flutter/material.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: SFTextField)
Widget buildTextFieldUseCase(BuildContext context) {
  final placeholder = context.knobs.string(
    label: 'Placeholder',
    initialValue: 'Enter text here',
    description: 'Text displayed as placeholder in the text field',
  );

  final isInError = context.knobs.boolean(
    label: 'Is In Error',
    initialValue: false,
    description: 'Indicates if the field is in an error state',
  );

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 30),
    child: Center(
      child: SFTextField(placeholder: placeholder, isInError: isInError),
    ),
  );
}
