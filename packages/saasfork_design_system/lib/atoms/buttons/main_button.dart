import 'package:flutter/material.dart';
import 'package:saasfork_design_system/foundations/sizes.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';

class MainButtonWidget extends StatelessWidget {
  final String label;
  final ComponentSize size;
  final VoidCallback onPressed;

  const MainButtonWidget({
    required this.label,
    required this.onPressed,
    this.size = ComponentSize.md,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: _getButtonStyle(context),
      child: Text(label),
    );
  }

  ButtonStyle? _getButtonStyle(BuildContext context) {
    final theme = Theme.of(context).elevatedButtonTheme.style;

    return theme?.copyWith(
      padding: WidgetStateProperty.all(AppSizes.getPadding(size)),
      textStyle: WidgetStateProperty.all(
        AppTypography.getScaledStyle(AppTypography.buttonText, size),
      ),
    );
  }
}
