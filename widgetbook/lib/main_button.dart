import 'package:flutter/material.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: MainButton)
Widget buildCoolButtonUseCase(BuildContext context) {
  return Center(child: MainButton(label: 'Cool Button', onPressed: () {}));
}
