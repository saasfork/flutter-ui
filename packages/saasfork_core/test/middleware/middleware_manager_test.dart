import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/widgets.dart';
import 'package:saasfork_core/middleware/middleware_manager.dart';
import 'package:saasfork_core/middleware/navigation_state.dart';
import 'test_navigation_state.dart';

// Mock de BuildContext pour les tests
class MockBuildContext extends Fake implements BuildContext {}

void main() {
  group('MiddlewareManager Tests', () {
    late TestNavigationState testState;

    setUp(() {
      // Réinitialiser les middlewares globaux avant chaque test
      MiddlewareManager.resetGlobalMiddlewares();

      // Initialiser un état de navigation pour les tests
      testState = TestNavigationState(
        path: '/test',
        params: {'id': '123'},
        queryParams: {'filter': 'active'},
        extra: {'title': 'Test Page'},
      );
    });

    test('registerGlobal devrait ajouter un middleware global', () async {
      bool middlewareCalled = false;

      // Enregistrer un nouveau middleware global de test
      MiddlewareManager.registerGlobal((context, state) {
        middlewareCalled = true;
        return null;
      });

      // Exécuter pour vérifier que le middleware est appelé
      await MiddlewareManager.run(null, testState, null);
      expect(middlewareCalled, isTrue);
    });

    test(
      'run devrait retourner la première redirection des middlewares globaux',
      () async {
        // Enregistrer un middleware qui redirige
        MiddlewareManager.registerGlobal(
          (context, state) => '/global-redirect',
        );

        final result = await MiddlewareManager.run(null, testState, null);
        expect(result, equals('/global-redirect'));
      },
    );

    test(
      'run devrait exécuter les middlewares de route si aucun global ne redirige',
      () async {
        // Middleware de route qui redirige
        bool routeMiddlewareCalled = false;
        final routeMiddlewares = [
          (BuildContext? context, NavigationState state) {
            routeMiddlewareCalled = true;
            return '/route-redirect';
          },
        ];

        final result = await MiddlewareManager.run(
          null,
          testState,
          routeMiddlewares,
        );

        expect(routeMiddlewareCalled, isTrue);
        expect(result, equals('/route-redirect'));
      },
    );

    test(
      'run devrait retourner null si aucun middleware ne redirige',
      () async {
        // Middleware de route qui ne redirige pas
        final routeMiddlewares = [
          (BuildContext? context, NavigationState state) => null,
        ];

        final result = await MiddlewareManager.run(
          null,
          testState,
          routeMiddlewares,
        );
        expect(result, isNull);
      },
    );

    test('run devrait passer le contexte et l\'état aux middlewares', () async {
      BuildContext? receivedContext;
      NavigationState? receivedState;

      // Enregistrer un middleware qui capture le contexte et l'état
      MiddlewareManager.registerGlobal((context, state) {
        receivedContext = context;
        receivedState = state;
        return null;
      });

      final mockContext = MockBuildContext();
      await MiddlewareManager.run(mockContext, testState, null);

      expect(receivedContext, equals(mockContext));
      expect(receivedState, equals(testState));
    });

    test(
      'les middlewares asynchrones devraient fonctionner correctement',
      () async {
        // Middleware qui retourne une Future
        MiddlewareManager.registerGlobal((context, state) async {
          await Future.delayed(Duration(milliseconds: 50));
          return '/async-redirect';
        });

        final result = await MiddlewareManager.run(null, testState, null);
        expect(result, equals('/async-redirect'));
      },
    );
  });
}
