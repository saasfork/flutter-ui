import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saasfork_design_system/foundations/models/profile_model.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';
import 'package:saasfork_firebase_service/saasfork_firebase_service.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final firebaseAuthProvider = Provider.of<SFFirebaseAuthProvider>(context);

    const profileFormData = ProfileFormData(
      labelUsername: 'Username',
      labelEmail: 'Email',
      placeholderUsername: 'Enter your username',
      placeholderEmail: 'Enter your email',
      errorUsernameRequired: 'Username is required',
      errorEmailInvalid: 'Email is invalid',
      saveButton: 'Save',
      logoutButton: 'Logout',
      deleteButton: 'Delete',
    );

    return Scaffold(
      body: Column(
        children: [
          SFProfileView(
            profileModel: ProfileModel(
              email: firebaseAuthProvider.autState?.user?.email ?? '',
              username: firebaseAuthProvider.autState?.user?.username ?? '',
            ),
            additionalData: profileFormData,
            onSubmit: (ProfileModel profileModel) async {
              await firebaseAuthProvider.updateUserProfile(
                username: profileModel.username,
                email: profileModel.email,
              );
            },
            children: [
              SFMainButton(
                label: profileFormData.logoutButton,
                onPressed: () {
                  firebaseAuthProvider.signOut();
                },
                color: AppColors.orange,
              ),
              SFMainButton(
                label: profileFormData.deleteButton,
                onPressed:
                    () => showDialog(
                      context: context,
                      builder:
                          (context) => SFDialog(
                            title: 'Êtes-vous sûr ?',
                            message:
                                'Êtes-vous sûr de vouloir supprimer votre compte ?',
                            onCancel: () => Navigator.of(context).pop(),
                            onDeactivate: () async {
                              await firebaseAuthProvider.deleteUserAccount();
                            },
                          ),
                    ),
                color: AppColors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
