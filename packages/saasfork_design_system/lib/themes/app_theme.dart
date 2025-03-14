import 'package:flutter/material.dart';
import 'package:saasfork_design_system/foundations/sizes.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(AppColors.primary),
        foregroundColor: WidgetStateProperty.all(Colors.white),
        padding: WidgetStateProperty.all(AppSizes.getPadding(ComponentSize.md)),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.sm),
          ),
        ),
        textStyle: WidgetStateProperty.all(AppTypography.buttonText),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(Colors.black),
        backgroundColor: WidgetStateProperty.all(Colors.white),
        padding: WidgetStateProperty.all(AppSizes.getPadding(ComponentSize.md)),
        textStyle: WidgetStateProperty.all(AppTypography.buttonText),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.sm),
          ),
        ),
      ),
    ),
  );
}
