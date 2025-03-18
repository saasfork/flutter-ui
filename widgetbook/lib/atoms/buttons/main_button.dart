import 'package:flutter/material.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: SFMainButton)
Widget buildMainButtonUseCase(BuildContext context) {
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

  // Utiliser un identifiant plus simple pour les couleurs
  final colorChoice = context.knobs.list<String>(
    label: 'Button Color',
    options: ['Default', 'Green', 'Blue'],
    initialOption: 'Default',
    description: 'Color of the button',
  );

  // Convertir le choix de couleur en Color réelle
  Color? buttonColor;
  if (colorChoice == 'Green') {
    buttonColor = AppColors.green;
  } else if (colorChoice == 'Blue') {
    buttonColor = AppColors.blue;
  }

  return Center(
    child: SFMainButton(
      label: label,
      size: size,
      color: buttonColor, // Passer null pour la couleur par défaut
      onPressed: () {},
    ),
  );
}
