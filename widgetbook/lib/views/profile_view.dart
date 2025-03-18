import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:saasfork_design_system/foundations/data/profile_form_data.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:widgetbook_workspace/generated/l10n.dart';

@widgetbook.UseCase(name: 'Default', type: ProfileView)
Widget buildProfileViewUseCase(BuildContext context) {
  return const ProfileView();
}

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  Map<String, dynamic> values = {};
  bool deleted = false;

  @override
  Widget build(BuildContext context) {
    final profileTextData = ProfileFormData(
      labelUsername: S.current.profile_label_name,
      labelEmail: S.current.label_email,
      placeholderUsername: S.current.profile_placeholder_name,
      placeholderEmail: S.current.placeholder_email,
      errorUsernameRequired: S.current.profile_error_name_required,
      errorEmailInvalid: S.current.error_email_invalid,
      saveButton: S.current.profile_save_button,
      deleteButton: S.current.profile_delete_button,
    );

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: SFProfileView(
                additionalData: profileTextData,
                onSubmit: (p0) {
                  setState(() {
                    values = p0.toMap();
                    deleted = false;
                  });
                },
                onDelete:
                    () => setState(() {
                      values = {};
                      deleted = true;
                    }),
              ),
            ),
          ),

          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (values.isNotEmpty)
                  Text(
                    'Données sauvegardées:',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                if (values.isNotEmpty)
                  Text(
                    JsonEncoder.withIndent('  ').convert(values),
                    style: TextStyle(fontFamily: 'monospace', fontSize: 14),
                  ),
                if (deleted)
                  Text(
                    'Profile deleted',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 14,
                      color: Colors.red,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
