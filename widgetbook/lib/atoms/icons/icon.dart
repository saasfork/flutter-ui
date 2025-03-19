import 'package:flutter/material.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: SFIcon)
Widget buildIconUseCase(BuildContext context) {
  final iconOptions = {
    'star': Icons.star,
    'home': Icons.home,
    'settings': Icons.settings,
    'favorite': Icons.favorite,
    'person': Icons.person,
  };

  final selectedIcon = context.knobs.list<String>(
    label: 'Icon',
    options: iconOptions.keys.toList(),
    initialOption: 'star',
    description: 'Type of icon to display',
  );

  final size = context.knobs.list<ComponentSize>(
    label: 'Button Size',
    options: ComponentSize.values,
    initialOption: ComponentSize.md,
    description: 'Size of the button',
  );

  final colorChoice = context.knobs.list<String>(
    label: 'Icon Color',
    options: ['Default', 'Green', 'Blue', 'Red', 'Black'],
    initialOption: 'Default',
    description: 'Color of the icon',
  );

  // Convertir le choix de couleur en Color réelle
  Color? iconColor;
  switch (colorChoice) {
    case 'Green':
      iconColor = AppColors.green;
      break;
    case 'Blue':
      iconColor = AppColors.blue;
      break;
    case 'Red':
      iconColor = Colors.red;
      break;
    case 'Black':
      iconColor = Colors.black;
      break;
    default:
      iconColor = null;
  }

  return Center(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SFIcon(
          icon: iconOptions[selectedIcon]!,
          size: size,
          color: iconColor,
          iconType: SFIconType.transparent,
        ),
        SFIcon(
          icon: iconOptions[selectedIcon]!,
          size: size,
          color: iconColor,
          iconType: SFIconType.rounded,
        ),
        SFIcon(
          icon: iconOptions[selectedIcon]!,
          size: size,
          color: iconColor,
          iconType: SFIconType.square,
        ),
      ],
    ),
  );
}
