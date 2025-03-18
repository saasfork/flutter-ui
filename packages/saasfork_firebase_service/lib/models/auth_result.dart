import 'dart:convert';

import 'package:saasfork_core/models/user_model.dart';

class AuthResultModel {
  final bool success;
  final UserModel? user;
  final String? error;

  AuthResultModel({required this.success, this.user, this.error});

  AuthResultModel copyWith({bool? success, UserModel? user, String? error}) {
    return AuthResultModel(
      success: success ?? this.success,
      user: user ?? this.user,
      error: error ?? this.error,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'success': success,
      'user': user?.toMap(),
      'error': error,
    };
  }

  factory AuthResultModel.fromMap(Map<String, dynamic> map) {
    return AuthResultModel(
      success: map['success'] as bool,
      user:
          map['user'] != null
              ? UserModel.fromMap(map['user'] as Map<String, dynamic>)
              : null,
      error: map['error'] != null ? map['error'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthResultModel.fromJson(String source) =>
      AuthResultModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'AuthResultModel(success: $success, user: $user, error: $error)';

  @override
  bool operator ==(covariant AuthResultModel other) {
    if (identical(this, other)) return true;

    return other.success == success &&
        other.user == user &&
        other.error == error;
  }

  @override
  int get hashCode => success.hashCode ^ user.hashCode ^ error.hashCode;
}
