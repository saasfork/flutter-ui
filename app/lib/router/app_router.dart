import 'package:app/constants.dart';
import 'package:app/views/home_view.dart';
import 'package:app/views/login_view.dart';
import 'package:app/views/profile_view.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saasfork_firebase_service/saasfork_firebase_service.dart';

part 'app_router.gr.dart';

/// Garde pour protéger les routes qui nécessitent une authentification
class AuthGuard extends AutoRouteGuard {
  final WidgetRef ref;

  AuthGuard(this.ref);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    debugPrint('AuthGuard checking route: ${resolver.route.name}');
    final isAuthenticated = ref.read(authProvider).isAuthenticated;

    if (isAuthenticated) {
      resolver.next(true);
      return;
    }

    // Utiliser le type généré avec redirect
    resolver.redirectUntil(LoginRoute());
  }
}

/// Garde pour empêcher les utilisateurs authentifiés d'accéder à certaines routes
class UnauthenticatedGuard extends AutoRouteGuard {
  final WidgetRef ref;

  UnauthenticatedGuard(this.ref);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    debugPrint('UnauthenticatedGuard checking route: ${resolver.route.name}');
    final isAuthenticated = ref.read(authProvider).isAuthenticated;

    if (!isAuthenticated) {
      resolver.next(true);
      return;
    }

    // Utiliser le type généré avec redirect
    resolver.redirectUntil(HomeRoute());
  }
}

@AutoRouterConfig(replaceInRouteName: 'View,Route')
class AppRouter extends RootStackRouter {
  final WidgetRef ref;

  AppRouter(this.ref);

  @override
  RouteType get defaultRouteType => RouteType.adaptive(); // Adaptatif pour supporter iOS/Android/Web

  @override
  List<AutoRoute> get routes => [
    // Route publique (uniquement pour utilisateurs NON connectés)
    AutoRoute(
      path: loginPath,
      page: LoginRoute.page,
      guards: [UnauthenticatedGuard(ref)],
    ),

    // Route initiale et routes privées (uniquement pour utilisateurs connectés)
    AutoRoute(
      path: homePath,
      page: HomeRoute.page,
      initial: true,
      guards: [AuthGuard(ref)],
    ),

    // Organisation par fonctionnalité
    profileRoutes,
  ];

  // Routes liées au profil regroupées
  AutoRoute get profileRoutes => AutoRoute(
    path: profilePath,
    page: ProfileRoute.page,
    guards: [AuthGuard(ref)],
  );
}
