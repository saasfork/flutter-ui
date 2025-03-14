import 'package:flutter/material.dart';
import 'package:saasfork_design_system/foundations/sizes.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: MainButtonWidget)
Widget buildCoolButtonUseCase(BuildContext context) {
  final label = context.knobs.string(
    label: 'Button Label',
    initialValue: 'Action',
    description: 'Text displayed on the button',
  );

  final size = context.knobs.list<ComponentSize>(
    label: 'Button Size',
    options: ComponentSize.values,
    initialOption: ComponentSize.md,
    description: 'Size of the button',
  );

  return Center(
    child: MainButtonWidget(label: label, size: size, onPressed: () {}),
  );
}
