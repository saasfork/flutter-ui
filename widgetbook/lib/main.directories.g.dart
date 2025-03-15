// dart format width=80
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AppGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:widgetbook/widgetbook.dart' as _i1;
import 'package:widgetbook_workspace/atoms/buttons/circular_button.dart' as _i2;
import 'package:widgetbook_workspace/atoms/buttons/icon_button.dart' as _i3;
import 'package:widgetbook_workspace/atoms/buttons/link_button.dart' as _i4;
import 'package:widgetbook_workspace/atoms/buttons/main_button.dart' as _i5;
import 'package:widgetbook_workspace/atoms/buttons/secondary_button.dart'
    as _i6;
import 'package:widgetbook_workspace/atoms/inputs/text_field.dart' as _i7;
import 'package:widgetbook_workspace/foundations/typography.dart' as _i8;
import 'package:widgetbook_workspace/molecules/forms/form_field.dart' as _i9;
import 'package:widgetbook_workspace/organisms/login_form.dart' as _i10;

final directories = <_i1.WidgetbookNode>[
  _i1.WidgetbookFolder(
    name: 'atoms',
    children: [
      _i1.WidgetbookFolder(
        name: 'buttons',
        children: [
          _i1.WidgetbookLeafComponent(
            name: 'SFCircularButton',
            useCase: _i1.WidgetbookUseCase(
              name: 'Default',
              builder: _i2.buildCircularButtonUseCase,
            ),
          ),
          _i1.WidgetbookLeafComponent(
            name: 'SFIconButton',
            useCase: _i1.WidgetbookUseCase(
              name: 'Default',
              builder: _i3.buildIconButtonUseCase,
            ),
          ),
          _i1.WidgetbookLeafComponent(
            name: 'SFLinkButton',
            useCase: _i1.WidgetbookUseCase(
              name: 'Default',
              builder: _i4.buildLinkButtonUseCase,
            ),
          ),
          _i1.WidgetbookLeafComponent(
            name: 'SFMainButton',
            useCase: _i1.WidgetbookUseCase(
              name: 'Default',
              builder: _i5.buildCoolButtonUseCase,
            ),
          ),
          _i1.WidgetbookLeafComponent(
            name: 'SFSecondaryButton',
            useCase: _i1.WidgetbookUseCase(
              name: 'Default',
              builder: _i6.buildCoolButtonUseCase,
            ),
          ),
        ],
      ),
      _i1.WidgetbookFolder(
        name: 'inputs',
        children: [
          _i1.WidgetbookLeafComponent(
            name: 'SFTextField',
            useCase: _i1.WidgetbookUseCase(
              name: 'Default',
              builder: _i7.buildTextFieldUseCase,
            ),
          ),
        ],
      ),
    ],
  ),
  _i1.WidgetbookFolder(
    name: 'foundations',
    children: [
      _i1.WidgetbookLeafComponent(
        name: 'GenericUseCase',
        useCase: _i1.WidgetbookUseCase(
          name: 'Typography Showcase',
          builder: _i8.buildTypographyUseCase,
        ),
      ),
    ],
  ),
  _i1.WidgetbookFolder(
    name: 'molecules',
    children: [
      _i1.WidgetbookFolder(
        name: 'forms',
        children: [
          _i1.WidgetbookLeafComponent(
            name: 'SFFormfield',
            useCase: _i1.WidgetbookUseCase(
              name: 'Default',
              builder: _i9.buildFormFieldUseCase,
            ),
          ),
        ],
      ),
    ],
  ),
  _i1.WidgetbookFolder(
    name: 'organisms',
    children: [
      _i1.WidgetbookFolder(
        name: 'forms',
        children: [
          _i1.WidgetbookLeafComponent(
            name: 'SFLoginForm',
            useCase: _i1.WidgetbookUseCase(
              name: 'Default',
              builder: _i10.buildCoolButtonUseCase,
            ),
          ),
        ],
      ),
    ],
  ),
];
