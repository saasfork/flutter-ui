import 'package:go_router/go_router.dart';
import 'package:saasfork_core/saasfork_core.dart';

class GoRouterStateAdapter implements NavigationState {
  final GoRouterState _state;

  GoRouterStateAdapter(this._state);

  @override
  String get path => _state.matchedLocation;

  @override
  Map<String, String> get params => _state.pathParameters;

  @override
  Map<String, String> get queryParams => _state.pathParameters;

  @override
  Map<String, dynamic> get extra => {
        if (_state.extra != null) 'extra': _state.extra,
        'name': _state.name,
        'fullpath': _state.fullPath,
      };
}