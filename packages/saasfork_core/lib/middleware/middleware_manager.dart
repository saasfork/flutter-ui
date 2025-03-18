import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:saasfork_core/middleware/navigation_state.dart';

/// Définition générique d'un middleware pour la navigation
typedef GenericRouterMiddleware =
    FutureOr<String?> Function(BuildContext? context, NavigationState state);

/// Gestionnaire générique de middlewares pour la navigation
class MiddlewareManager {
  static final List<GenericRouterMiddleware> _globalMiddlewares = [];

  /// Enregistre un middleware global
  static void registerGlobal(GenericRouterMiddleware middleware) {
    _globalMiddlewares.add(middleware);
  }

  /// Réinitialise tous les middlewares globaux (utile pour les tests)
  static void resetGlobalMiddlewares() {
    _globalMiddlewares.clear();
  }

  /// Exécute tous les middlewares dans l'ordre
  static Future<String?> run(
    BuildContext? context,
    NavigationState state,
    List<GenericRouterMiddleware>? routeMiddlewares,
  ) async {
    // Exécuter middlewares globaux
    for (final middleware in _globalMiddlewares) {
      final redirect = await middleware(context, state);
      if (redirect != null) return redirect;
    }

    // Exécuter middlewares de route
    if (routeMiddlewares != null) {
      for (final middleware in routeMiddlewares) {
        final redirect = await middleware(context, state);
        if (redirect != null) return redirect;
      }
    }

    return null;
  }
}
