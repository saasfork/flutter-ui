import 'package:flutter_test/flutter_test.dart';
import 'test_navigation_state.dart';

void main() {
  group('NavigationState Tests', () {
    test(
      'TestNavigationState devrait correctement stocker et retourner les valeurs',
      () {
        final state = TestNavigationState(
          path: '/products/123',
          params: {'id': '123'},
          queryParams: {'sort': 'price', 'order': 'asc'},
          extra: {'title': 'Product Details'},
        );

        expect(state.path, equals('/products/123'));
        expect(state.params, equals({'id': '123'}));
        expect(state.queryParams, equals({'sort': 'price', 'order': 'asc'}));
        expect(state.extra, equals({'title': 'Product Details'}));
      },
    );

    test(
      'TestNavigationState devrait accepter des valeurs par défaut vides',
      () {
        final state = TestNavigationState(path: '/home');

        expect(state.path, equals('/home'));
        expect(state.params, equals({}));
        expect(state.queryParams, equals({}));
        expect(state.extra, equals({}));
      },
    );
  });
}
