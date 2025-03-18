import 'package:flutter/material.dart';
import 'package:saasfork_design_system/foundations/data/profile_form_data.dart';
import 'package:saasfork_design_system/foundations/models/profile_model.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';

class SFProfileView extends StatelessWidget {
  final ProfileFormData additionalData;
  final ProfileModel? profileModel;
  final Function(ProfileModel) onSubmit;
  final Function()? onDelete;

  const SFProfileView({
    super.key,
    required this.additionalData,
    required this.onSubmit,
    this.onDelete,
    this.profileModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: AppSpacing.lg,
      children: [
        SFProfileForm(
          additionalData: additionalData.toMap(),
          profileModel: profileModel,
          onSubmit: (profileData) {
            final typedValues = ProfileModel.fromMap(profileData);
            onSubmit(typedValues);
          },
        ),
        if (onDelete != null)
          SFMainButton(
            label: additionalData.deleteButton,
            onPressed: onDelete!,
            color: AppColors.red,
          ),
      ],
    );
  }
}
