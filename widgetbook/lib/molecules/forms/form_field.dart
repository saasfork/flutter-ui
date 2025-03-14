import 'package:flutter/material.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: SFFormfield)
Widget buildFormFieldUseCase(BuildContext context) {
  final label = context.knobs.string(
    label: 'Label',
    initialValue: 'Enter text here',
    description: 'Text displayed as label in the form field',
  );

  final hintMessage = context.knobs.string(
    label: 'Hint',
    initialValue: 'Type something...',
    description: 'Text displayed as hint in the form field',
  );

  final errorMessage = context.knobs.string(
    label: 'Error Message',
    initialValue: 'This field is required',
    description: 'Message displayed when there is an error',
  );

  final placeholder = context.knobs.string(
    label: 'Placeholder',
    initialValue: 'Enter text here',
    description: 'Text displayed as placeholder in the form field',
  );

  final isRequired = context.knobs.boolean(
    label: 'Is Required',
    initialValue: false,
    description: 'Indicates if the field is required',
  );

  return Center(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: SFFormfield(
        label: label,
        input: SFTextField(
          placeholder: placeholder,
          isInError: errorMessage.isNotEmpty,
        ),
        hintMessage: hintMessage,
        errorMessage: errorMessage,
        isRequired: isRequired,
      ),
    ),
  );
}
