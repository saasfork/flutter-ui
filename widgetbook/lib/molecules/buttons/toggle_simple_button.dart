import 'package:flutter/material.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: SFToggleSimpleButton)
Widget buildToggleSimpleButtonUseCase(BuildContext context) {
  final initialValue = context.knobs.boolean(
    label: 'Mode sombre',
    initialValue: false,
    description:
        'État initial du toggle (activé = mode sombre, désactivé = mode clair)',
  );

  // Options simples pour les couleurs
  final lightModeColorOption = context.knobs.list<String>(
    label: 'Couleur mode clair',
    options: ['Jaune', 'Orange', 'Bleu ciel'],
    initialOption: 'Jaune',
    description: 'Couleur du bouton en mode clair',
  );

  final darkModeColorOption = context.knobs.list<String>(
    label: 'Couleur mode sombre',
    options: ['Indigo', 'Violet', 'Bleu foncé'],
    initialOption: 'Indigo',
    description: 'Couleur du bouton en mode sombre',
  );

  final size = context.knobs.list<ComponentSize>(
    label: 'Button Size',
    options: ComponentSize.values,
    initialOption: ComponentSize.md,
    description: 'Size of the button',
  );

  // Convertir les options en couleurs réelles
  Color getLightColor() {
    switch (lightModeColorOption) {
      case 'Orange':
        return Colors.orange;
      case 'Bleu ciel':
        return Colors.lightBlue;
      case 'Jaune':
      default:
        return Colors.amber;
    }
  }

  Color getDarkColor() {
    switch (darkModeColorOption) {
      case 'Violet':
        return Colors.deepPurple;
      case 'Bleu foncé':
        return Colors.blueGrey;
      case 'Indigo':
      default:
        return Colors.indigo;
    }
  }

  return Center(
    child: SFToggleSimpleButton(
      initialValue: initialValue,
      lightModeColor: getLightColor(),
      darkModeColor: getDarkColor(),
      size: size,
      onToggle: (isDarkMode) {
        // Rien à faire dans le widgetbook, juste pour démonstration
      },
    ),
  );
}
