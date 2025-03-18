import 'package:saasfork_core/middleware/navigation_state.dart';

/// Une implémentation concrète de NavigationState pour les tests
class TestNavigationState implements NavigationState {
  @override
  final String path;

  @override
  final Map<String, String> params;

  @override
  final Map<String, String> queryParams;

  @override
  final Map<String, dynamic> extra;

  TestNavigationState({
    required this.path,
    this.params = const {},
    this.queryParams = const {},
    this.extra = const {},
  });
}
