import 'package:saasfork_firebase_service/models/user_model.dart';

class AuthResultModel {
  final bool success;
  final UserModel? user;
  final String? error;

  AuthResultModel({required this.success, this.user, this.error});
}
