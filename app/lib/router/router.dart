import 'package:app/constants.dart';
import 'package:app/router/go_router_adapter.dart';
import 'package:app/views/home_view.dart';
import 'package:app/views/login_view.dart';
import 'package:app/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:saasfork_core/saasfork_core.dart';
import 'package:saasfork_firebase_service/saasfork_firebase_service.dart';

class AppRouter {
  // Routes accessibles sans authentification
  static final List<String> _publicRoutes = [loginPath];

  // Routes accessibles avec authentification
  static final List<String> _privateRoutes = [homePath, profilePath];

  static GoRouter getRouter(BuildContext context) {
    final authProvider = Provider.of<SFFirebaseAuthProvider>(context);

    Future<String?> authMiddleware(
      BuildContext? context,
      NavigationState state,
    ) async {
      final authState = authProvider.autState;
      final currentPath = state.path;
      final isAuthenticated = authState?.isAuthenticated ?? false;

      // if (authState?.state == AuthState.updating) {
      //   // Ignorer les redirections pendant les mises à jour
      //   return null;
      // }

      /// Je suis authentifié et j'accède à une route privée
      if (isAuthenticated && _privateRoutes.contains(currentPath)) {
        return null;
      }

      /// Je ne suis pas authentifié et j'accède à une route privée
      if (!isAuthenticated && !_publicRoutes.contains(currentPath)) {
        return loginPath;
      }

      /// Je suis authentifié et j'accède à une route public
      if (isAuthenticated && _publicRoutes.contains(currentPath)) {
        return homePath;
      }

      return null;
    }

    return GoRouter(
      routes: [
        GoRoute(path: loginPath, builder: (context, state) => LoginView()),
        GoRoute(path: profilePath, builder: (context, state) => ProfileView()),
        GoRoute(path: homePath, builder: (context, state) => HomeView()),
      ],
      redirect: (context, state) async {
        final navigationState = GoRouterStateAdapter(state);
        final routeMiddlewares = [authMiddleware];

        return await MiddlewareManager.run(
          context,
          navigationState,
          routeMiddlewares,
        );
      },
    );
  }
}
