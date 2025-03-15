import 'package:flutter/material.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: SFIconButton)
Widget buildIconButtonUseCase(BuildContext context) {
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

  final iconPosition = context.knobs.list<IconPosition>(
    label: 'Icon Position',
    options: IconPosition.values,
    initialOption: IconPosition.start,
    description: 'Position of the icon',
  );

  return Center(
    child: SFIconButton(
      label: label,
      icon: Icons.add,
      onPressed: () {},
      size: size,
      iconPosition: iconPosition,
    ),
  );
}
