import 'package:flutter/material.dart';
import 'package:saasfork_design_system/atoms/buttons/link_button.dart';
import 'package:saasfork_design_system/foundations/sizes.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: LinkButton)
Widget buildLinkButtonUseCase(BuildContext context) {
  final label = context.knobs.string(
    label: 'Button Label',
    initialValue: 'Cliquez ici',
    description: 'Texte affiché sur le bouton lien',
  );

  final size = context.knobs.list<ComponentSize>(
    label: 'Button Size',
    options: ComponentSize.values,
    initialOption: ComponentSize.md,
    description: 'Taille du bouton lien',
  );

  return Center(child: LinkButton(label: label, size: size, onPressed: () {}));
}
