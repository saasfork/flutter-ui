import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saasfork_design_system/foundations/data/profile_form_data.dart';
import 'package:saasfork_design_system/foundations/models/profile_model.dart';
import 'package:saasfork_design_system/views/views.dart';
import 'package:saasfork_firebase_service/saasfork_firebase_service.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final firebaseAuthProvider = Provider.of<SFFirebaseAuthProvider>(context);

    return Scaffold(
      body: Column(
        children: [
          SFProfileView(
            profileModel: ProfileModel(
              email: firebaseAuthProvider.currentUser?.email ?? '',
              username: firebaseAuthProvider.currentUser?.username ?? '',
            ),
            additionalData: ProfileFormData(
              labelUsername: 'Username',
              labelEmail: 'Email',
              placeholderUsername: 'Enter your username',
              placeholderEmail: 'Enter your email',
              errorUsernameRequired: 'Username is required',
              errorEmailInvalid: 'Email is invalid',
              saveButton: 'Save',
              deleteButton: 'Delete',
            ),
            onSubmit: (ProfileModel profileModel) {
              print(profileModel.toMap());
            },
          ),
        ],
      ),
    );
  }
}
