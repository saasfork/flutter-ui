import 'package:flutter/material.dart';
import 'package:saasfork_design_system/foundations/sizes.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(AppColors.indigo),
        foregroundColor: WidgetStateProperty.all(Colors.white),
        padding: WidgetStateProperty.all(AppSizes.getPadding(ComponentSize.md)),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.sm),
            side: BorderSide(color: AppColors.indigo.s600, width: 1),
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
            side: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        padding: WidgetStateProperty.all(AppSizes.getPadding(ComponentSize.md)),
        textStyle: WidgetStateProperty.all(AppTypography.buttonText),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.hovered)) {
            return AppColors.gray.s900;
          }
          return AppColors.gray;
        }),
        backgroundColor: WidgetStateProperty.all(Colors.transparent),
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        splashFactory: NoSplash.splashFactory,
        side: WidgetStateProperty.all(BorderSide.none),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.grey.s900,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(AppColors.indigo.s400),
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
        foregroundColor: WidgetStateProperty.all(Colors.white),
        backgroundColor: WidgetStateProperty.all(AppColors.grey.s800),
        padding: WidgetStateProperty.all(AppSizes.getPadding(ComponentSize.md)),
        textStyle: WidgetStateProperty.all(AppTypography.buttonText),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.sm),
            side: BorderSide.none,
          ),
        ),
        side: WidgetStateProperty.all(BorderSide.none),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        padding: WidgetStateProperty.all(AppSizes.getPadding(ComponentSize.md)),
        textStyle: WidgetStateProperty.all(AppTypography.buttonText),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.hovered)) {
            return AppColors.gray.s50;
          }
          return AppColors.gray.s200;
        }),
        backgroundColor: WidgetStateProperty.all(Colors.transparent),
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        splashFactory: NoSplash.splashFactory,
        side: WidgetStateProperty.all(BorderSide.none),
      ),
    ),
  );
}
