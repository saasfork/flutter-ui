import 'package:app/constants.dart';
import 'package:app/router/go_router_adapter.dart';
import 'package:app/views/home_view.dart';
import 'package:app/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:saasfork_core/saasfork_core.dart';
import 'package:saasfork_firebase_service/saasfork_firebase_service.dart';

class AppRouter {
  static GoRouter getRouter(BuildContext context) {
    final authProvider = Provider.of<SFFirebaseAuthProvider>(context);
    final isLoggedIn = authProvider.currentUser != null;

    Future<String?> authMiddleware(
      BuildContext? context,
      NavigationState state,
    ) async {
      final isLoggedIn = authProvider.currentUser != null;

      if (!isLoggedIn && state.path != loginPath) return loginPath;
      if (isLoggedIn && state.path == loginPath) return homePath;

      return null;
    }

    return GoRouter(
      initialLocation: isLoggedIn ? homePath : loginPath,
      routes: [
        GoRoute(path: loginPath, builder: (context, state) => LoginView()),
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
