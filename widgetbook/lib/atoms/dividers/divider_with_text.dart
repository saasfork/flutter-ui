import 'package:flutter/material.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: SFDividerWithText)
Widget buildDividerWithTextUseCase(BuildContext context) {
  final text = context.knobs.string(
    label: 'Divider Text',
    initialValue: 'Divider',
    description: 'Text displayed in the divider',
  );

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 30),
    child: Center(child: SFDividerWithText(text: text)),
  );
}
