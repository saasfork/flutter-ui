import 'package:flutter/material.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: TextFieldWidget)
Widget buildTextFieldUseCase(BuildContext context) {
  final placeholder = context.knobs.string(
    label: 'Placeholder',
    initialValue: 'Enter text here',
    description: 'Text displayed as placeholder in the text field',
  );

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 30),
    child: Center(child: TextFieldWidget(placeholder: placeholder)),
  );
}
