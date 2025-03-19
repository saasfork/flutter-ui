import 'package:flutter/material.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: SFDialog)
Widget buildDialogUseCase(BuildContext context) {
  final title = context.knobs.string(
    label: 'Title',
    initialValue: 'Deactivate account?',
    description: 'Text displayed as title in the dialog',
  );

  final message = context.knobs.string(
    label: 'Message',
    initialValue:
        'Are you sure you want to deactivate your account? This action cannot be undone.',
    description: 'Text displayed as message in the dialog',
  );

  final additionalData = DialogData(
    desactivateButton: 'Deactivate',
    activateButton: 'Activate',
  );

  return Center(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: SFMainButton(
        label: "Click Me",
        onPressed: () {
          showDialog(
            context: context,
            builder:
                (context) => SFDialog(
                  title: title,
                  message: message,
                  icon: Icons.warning_amber_rounded,
                  width: 400,
                  onCancel: () => Navigator.of(context).pop(),
                  onDeactivate: () => Navigator.of(context).pop(),
                  additionalData: additionalData.toMap(),
                ),
          );
        },
      ),
    ),
  );
}
