import 'package:flutter/material.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: MainButton)
Widget buildCoolButtonUseCase(BuildContext context) {
  final label = context.knobs.string(
    label: 'Button Label',
    initialValue: 'Action',
    description: 'Text displayed on the button',
  );

  return Center(child: MainButton(label: label, onPressed: () {}));
}
