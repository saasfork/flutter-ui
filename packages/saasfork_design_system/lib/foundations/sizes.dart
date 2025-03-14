import 'package:flutter/material.dart';
import 'package:saasfork_design_system/foundations/spacing.dart';

/// Tailles standardisées pour les composants de l'interface utilisateur
enum ComponentSize { xs, sm, md, lg, xl }

/// Classe utilitaire pour gérer les dimensions basées sur les tailles standardisées
class AppSizes {
  /// Convertit une taille de composant en EdgeInsets pour le padding
  static EdgeInsets getPadding(ComponentSize size) {
    switch (size) {
      case ComponentSize.xs:
        return const EdgeInsets.symmetric(
          vertical: AppSpacing.xs,
          horizontal: AppSpacing.sm,
        );
      case ComponentSize.sm:
        return const EdgeInsets.symmetric(
          vertical: AppSpacing.sm,
          horizontal: AppSpacing.md,
        );
      case ComponentSize.md:
        return const EdgeInsets.symmetric(
          vertical: AppSpacing.md,
          horizontal: AppSpacing.lg,
        );
      case ComponentSize.lg:
        return const EdgeInsets.symmetric(
          vertical: AppSpacing.lg,
          horizontal: AppSpacing.xl,
        );
      case ComponentSize.xl:
        return const EdgeInsets.symmetric(
          vertical: AppSpacing.xl,
          horizontal: AppSpacing.xxl,
        );
    }
  }
}
