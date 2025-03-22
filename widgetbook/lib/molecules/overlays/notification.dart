import 'package:flutter/material.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: SFNotification)
Widget buildNotificationUseCase(BuildContext context) {
  final title = context.knobs.string(
    label: 'Title',
    initialValue: 'Success',
    description: 'Text displayed in the notification',
  );

  final message = context.knobs.string(
    label: 'Message',
    initialValue:
        'Successfully saved! Anyone with a link can now view this file.',
    description: 'Text displayed in the notification',
  );

  final icon = context.knobs.list<IconData>(
    label: 'Icon',
    options: [
      Icons.check_circle_outline_rounded,
      Icons.error_outline_outlined,
      Icons.info_outline_rounded,
      Icons.warning_amber_rounded,
    ],
    initialOption: Icons.check_circle_outline_rounded,
    labelBuilder: (IconData icon) {
      if (icon == Icons.check_circle_outline_rounded) return 'Check Circle';
      if (icon == Icons.error_outline_outlined) return 'Error';
      if (icon == Icons.info_outline_rounded) return 'Info';
      if (icon == Icons.warning_amber_rounded) return 'Warning';
      return 'Unknown';
    },
  );

  final iconColor = context.knobs.list<String>(
    label: 'Couleurs',
    options: ['Succes', 'Danger', 'Warning', 'Info'],
    initialOption: 'Succes',
    description: 'Couleur du bouton en mode sombre',
  );

  Color getLightColor() {
    switch (iconColor) {
      case 'Succes':
        return AppColors.success;
      case 'Danger':
        return AppColors.danger;
      case 'Warning':
        return AppColors.warning;
      case 'Info':
      default:
        return AppColors.info;
    }
  }

  final lightColor = getLightColor();

  return Center(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SFMainButton(
          label: 'Générique notification',
          onPressed: () {
            context.showNotification(
              SFNotification(
                title: title,
                message: message,
                icon: icon,
                iconColor: lightColor,
                onClose: () => debugPrint("close"),
              ),
            );
          },
        ),
        SFMainButton(
          label: 'Success notification',
          onPressed: () {
            context.showSuccess(message: 'Successfully saved!');
          },
        ),
      ],
    ),
  );
}
