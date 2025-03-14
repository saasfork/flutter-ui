import 'package:flutter/material.dart';
import 'package:saasfork_design_system/foundations/sizes.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';

class SecondaryButton extends StatelessWidget {
  final String label;
  final ComponentSize size;
  final VoidCallback onPressed;

  const SecondaryButton({
    required this.label,
    required this.onPressed,
    this.size = ComponentSize.md,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: _getButtonStyle(context),
      child: Text(label),
    );
  }

  ButtonStyle? _getButtonStyle(BuildContext context) {
    final theme = Theme.of(context).outlinedButtonTheme.style;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return theme?.copyWith(
      padding: WidgetStateProperty.all(AppSizes.getPadding(size)),
      textStyle: WidgetStateProperty.all(
        AppTypography.getScaledStyle(AppTypography.buttonText, size),
      ),
      side: WidgetStateProperty.all(
        isDarkMode ? BorderSide.none : BorderSide(color: Colors.grey.shade400),
      ),
    );
  }
}
