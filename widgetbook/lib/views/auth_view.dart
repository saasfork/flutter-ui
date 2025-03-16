import 'package:flutter/material.dart';
import 'package:saasfork_design_system/views/views.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: SFAuthView)
Widget buildAuthViewUseCase(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: const SFAuthView(),
  );
}
