import 'package:app/views/home_view.dart';
import 'package:app/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:saasfork_firebase_service/saasfork_firebase_service.dart';

class AppRouter {
  static GoRouter getRouter(BuildContext context) {
    final authProvider = Provider.of<SFFirebaseAuthProvider>(context);
    final isLoggedIn = authProvider.currentUser != null;

    return GoRouter(
      initialLocation: isLoggedIn ? '/' : '/login',
      routes: [
        GoRoute(path: '/login', builder: (context, state) => LoginView()),
        GoRoute(path: '/', builder: (context, state) => HomeView()),
      ],
      redirect: (context, state) {
        final authProvider = Provider.of<SFFirebaseAuthProvider>(context);
        final isLoggedIn = authProvider.currentUser != null;
        final loggingIn = state.matchedLocation == '/login';

        if (!isLoggedIn && !loggingIn) return '/login';
        if (isLoggedIn && loggingIn) return '/';
        return null;
      },
    );
  }
}
