import 'package:app/constants.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saasfork_design_system/foundations/models/profile_model.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';
import 'package:saasfork_firebase_service/saasfork_firebase_service.dart';

@RoutePage()
class ProfileView extends ConsumerWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

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
              email: authState.user?.email ?? '',
              username: authState.user?.username ?? '',
            ),
            additionalData: profileFormData,
            onSubmit: (ProfileModel profileModel) async {
              await ref
                  .read(authProvider.notifier)
                  .updateUserProfile(
                    username: profileModel.username,
                    email: profileModel.email,
                  );
            },
            children: [
              SFMainButton(
                label: profileFormData.logoutButton,
                onPressed: () async {
                  await ref.read(authProvider.notifier).signOut();

                  AutoRouter.of(context).pushPath(loginPath);
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
                              await ref
                                  .read(authProvider.notifier)
                                  .deleteUserAccount();

                              AutoRouter.of(context).pushPath(loginPath);
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
