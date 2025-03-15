import 'package:flutter/material.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: SFCircularButton)
Widget buildCircularButtonUseCase(BuildContext context) {
  final Map<String, IconData> iconOptions = {
    'Add': Icons.add,
    'Remove': Icons.remove,
    'Check': Icons.check,
    'Edit': Icons.edit,
    'Delete': Icons.delete,
  };

  final String selectedIconKey = context.knobs.list<String>(
    label: 'Icon',
    options: iconOptions.keys.toList(),
    initialOption: 'Add',
    description: 'Icon displayed on the button',
  );

  final IconData selectedIcon = iconOptions[selectedIconKey]!;

  final size = context.knobs.list<ComponentSize>(
    label: 'Button Size',
    options: ComponentSize.values,
    initialOption: ComponentSize.md,
    description: 'Size of the button',
  );

  return Center(
    child: SFCircularButton(icon: selectedIcon, size: size, onPressed: () {}),
  );
}
