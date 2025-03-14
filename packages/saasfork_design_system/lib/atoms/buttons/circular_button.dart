import 'package:flutter/material.dart';
import 'package:saasfork_design_system/foundations/sizes.dart';

class SFCircularButton extends StatelessWidget {
  final IconData icon;
  final ComponentSize size;
  final VoidCallback onPressed;

  const SFCircularButton({
    required this.icon,
    required this.onPressed,
    this.size = ComponentSize.md,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: _getButtonStyle(context),
      child: Icon(icon, size: _getIconSize()),
    );
  }

  ButtonStyle? _getButtonStyle(BuildContext context) {
    final theme = Theme.of(context).elevatedButtonTheme.style;

    return theme?.copyWith(
      padding: WidgetStateProperty.all(EdgeInsets.zero),
      shape: WidgetStateProperty.all(CircleBorder()),
      minimumSize: WidgetStateProperty.all(Size.square(_getButtonSize())),
    );
  }

  double _getButtonSize() {
    switch (size) {
      case ComponentSize.xs:
        return 32.0;
      case ComponentSize.sm:
        return 40.0;
      case ComponentSize.md:
        return 48.0;
      case ComponentSize.lg:
        return 56.0;
      case ComponentSize.xl:
        return 64.0;
    }
  }

  double _getIconSize() {
    switch (size) {
      case ComponentSize.xs:
        return 16.0;
      case ComponentSize.sm:
        return 20.0;
      case ComponentSize.md:
        return 24.0;
      case ComponentSize.lg:
        return 28.0;
      case ComponentSize.xl:
        return 32.0;
    }
  }
}
