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

  final Map<String, Color?> iconColorOptions = {
    'Default': null,
    'Rouge': AppColors.red,
    'Vert': AppColors.green,
  };

  final String selectedIconColorKey = context.knobs.list<String>(
    label: 'Icon Color',
    options: iconColorOptions.keys.toList(),
    initialOption: 'Default',
    description: 'Color of the icon',
  );

  // Liste de couleurs prédéfinies pour l'arrière-plan
  final Map<String, Color?> backgroundColorOptions = {
    'Default': null,
    'Rouge': AppColors.red,
    'Vert': AppColors.green,
  };

  final String selectedBackgroundColorKey = context.knobs.list<String>(
    label: 'Background Color',
    options: backgroundColorOptions.keys.toList(),
    initialOption: 'Default',
    description: 'Background color of the button',
  );

  final Color? backgroundColor =
      backgroundColorOptions[selectedBackgroundColorKey];

  final Color? iconColor = iconColorOptions[selectedIconColorKey];

  return Center(
    child: SFCircularButton(
      icon: selectedIcon,
      size: size,
      onPressed: () {},
      iconColor: iconColor,
      backgroundColor: backgroundColor,
    ),
  );
}
