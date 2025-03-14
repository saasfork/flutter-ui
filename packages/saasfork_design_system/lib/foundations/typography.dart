import 'package:flutter/material.dart';
import 'package:saasfork_design_system/foundations/sizes.dart';

class AppTypography {
  static const TextStyle headline1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle bodyText = TextStyle(
    fontSize: 16,
    color: Colors.black87,
  );
  static const TextStyle buttonText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  /// Ajuste un style de texte en fonction de la taille du composant
  static TextStyle getScaledStyle(TextStyle baseStyle, ComponentSize size) {
    final scaleFactor = _getFontScaleFactor(size);
    return baseStyle.copyWith(
      fontSize:
          baseStyle.fontSize != null ? baseStyle.fontSize! * scaleFactor : null,
    );
  }

  /// Facteurs d'échelle pour les polices selon la taille du composant
  static double _getFontScaleFactor(ComponentSize size) {
    switch (size) {
      case ComponentSize.xs:
        return 0.8;
      case ComponentSize.sm:
        return 0.9;
      case ComponentSize.md:
        return 1.0;
      case ComponentSize.lg:
        return 1.2;
      case ComponentSize.xl:
        return 1.4;
    }
  }
}
