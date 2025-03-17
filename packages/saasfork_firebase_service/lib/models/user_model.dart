class UserModel {
  String uid;
  String? email;

  UserModel({required this.uid, this.email});

  Map<String, dynamic> toJson() {
    return {'uid': uid, 'email': email};
  }
}
