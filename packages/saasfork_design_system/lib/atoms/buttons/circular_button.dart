import 'package:flutter/material.dart';
import 'package:saasfork_design_system/foundations/sizes.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';

class SFCircularButton extends StatelessWidget {
  final IconData icon;
  final ComponentSize size;
  final VoidCallback onPressed;
  final Color? iconColor;

  const SFCircularButton({
    required this.icon,
    required this.onPressed,
    this.size = ComponentSize.md,
    this.iconColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Utiliser SizedBox pour garantir une taille exacte
    return SizedBox(
      width: _getButtonDimension(),
      height: _getButtonDimension(),
      child: ElevatedButton(
        onPressed: onPressed,
        style: _getButtonStyle(context),
        child: Icon(
          icon,
          color: iconColor ?? Colors.white,
          size: _getIconSize(),
        ),
      ),
    );
  }

  ButtonStyle? _getButtonStyle(BuildContext context) {
    final theme = Theme.of(context).elevatedButtonTheme.style;

    return theme?.copyWith(
      padding: WidgetStateProperty.all(EdgeInsets.zero),
      shape: WidgetStateProperty.all(const CircleBorder()),
      // Assurer que la taille est fixe et ne dépend pas du contenu
      minimumSize: WidgetStateProperty.all(Size.square(_getButtonDimension())),
      fixedSize: WidgetStateProperty.all(Size.square(_getButtonDimension())),
      maximumSize: WidgetStateProperty.all(Size.square(_getButtonDimension())),
    );
  }

  // Méthode pour obtenir la dimension du bouton en fonction de sa taille
  double _getButtonDimension() {
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

  // Méthode pour obtenir la taille de l'icône en fonction de la taille du bouton
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
