import 'package:flutter/material.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

class GenericUseCase {}

@widgetbook.UseCase(name: 'Typography Showcase', type: GenericUseCase)
Widget buildTypographyUseCase(BuildContext context) {
  // Construire la liste de tous les styles de typographie
  return Padding(
    padding: const EdgeInsets.all(16),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCategoryTitle('Display Styles'),
          _buildTextStyleItem('displayLarge', AppTypography.displayLarge),
          _buildTextStyleItem('displayMedium', AppTypography.displayMedium),
          _buildTextStyleItem('displaySmall', AppTypography.displaySmall),

          const SizedBox(height: 24),
          _buildCategoryTitle('Headline Styles'),
          _buildTextStyleItem('headlineLarge', AppTypography.headlineLarge),
          _buildTextStyleItem('headlineMedium', AppTypography.headlineMedium),
          _buildTextStyleItem('headlineSmall', AppTypography.headlineSmall),

          const SizedBox(height: 24),
          _buildCategoryTitle('Title Styles'),
          _buildTextStyleItem('titleLarge', AppTypography.titleLarge),
          _buildTextStyleItem('titleMedium', AppTypography.titleMedium),
          _buildTextStyleItem('titleSmall', AppTypography.titleSmall),

          const SizedBox(height: 24),
          _buildCategoryTitle('Body Styles'),
          _buildTextStyleItem('bodyLarge', AppTypography.bodyLarge),
          _buildTextStyleItem('bodyMedium', AppTypography.bodyMedium),
          _buildTextStyleItem('bodySmall', AppTypography.bodySmall),

          const SizedBox(height: 24),
          _buildCategoryTitle('Label Styles'),
          _buildTextStyleItem('labelLarge', AppTypography.labelLarge),
          _buildTextStyleItem('labelMedium', AppTypography.labelMedium),
          _buildTextStyleItem('labelSmall', AppTypography.labelSmall),

          const SizedBox(height: 24),
          _buildCategoryTitle('Scaled Styles (bodyLarge)'),
          _buildScaledTextItem(
            'XS Size',
            AppTypography.getScaledStyle(
              AppTypography.bodyLarge,
              ComponentSize.xs,
            ),
          ),
          _buildScaledTextItem(
            'SM Size',
            AppTypography.getScaledStyle(
              AppTypography.bodyLarge,
              ComponentSize.sm,
            ),
          ),
          _buildScaledTextItem(
            'MD Size',
            AppTypography.getScaledStyle(
              AppTypography.bodyLarge,
              ComponentSize.md,
            ),
          ),
          _buildScaledTextItem(
            'LG Size',
            AppTypography.getScaledStyle(
              AppTypography.bodyLarge,
              ComponentSize.lg,
            ),
          ),
          _buildScaledTextItem(
            'XL Size',
            AppTypography.getScaledStyle(
              AppTypography.bodyLarge,
              ComponentSize.xl,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildCategoryTitle(String title) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: Text(
      title,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
  );
}

Widget _buildTextStyleItem(String name, TextStyle style) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name, style: AppTypography.labelMedium),
        const SizedBox(height: 4),
        Text('The quick brown fox jumps over the lazy dog.', style: style),
        const SizedBox(height: 4),
        Text(
          'fontSize: ${style.fontSize}, weight: ${style.fontWeight}, height: ${style.height}, letterSpacing: ${style.letterSpacing}',
          style: AppTypography.bodySmall,
        ),
        const Divider(),
      ],
    ),
  );
}

Widget _buildScaledTextItem(String name, TextStyle style) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name, style: AppTypography.labelMedium),
        const SizedBox(height: 4),
        Text('The quick brown fox jumps over the lazy dog.', style: style),
        const SizedBox(height: 4),
        Text('fontSize: ${style.fontSize}', style: AppTypography.bodySmall),
        const Divider(),
      ],
    ),
  );
}
