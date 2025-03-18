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
import 'package:widgetbook_workspace/atoms/buttons/icon_secondary_button.dart'
    as _i7;
import 'package:widgetbook_workspace/atoms/buttons/link_button.dart' as _i4;
import 'package:widgetbook_workspace/atoms/buttons/main_button.dart' as _i5;
import 'package:widgetbook_workspace/atoms/buttons/secondary_button.dart'
    as _i6;
import 'package:widgetbook_workspace/atoms/dividers/divider_with_text.dart'
    as _i8;
import 'package:widgetbook_workspace/atoms/inputs/text_field.dart' as _i9;
import 'package:widgetbook_workspace/foundations/typography.dart' as _i10;
import 'package:widgetbook_workspace/molecules/forms/form_field.dart' as _i11;
import 'package:widgetbook_workspace/organisms/forgot_password_form.dart'
    as _i12;
import 'package:widgetbook_workspace/organisms/login_form.dart' as _i13;
import 'package:widgetbook_workspace/organisms/profile_form.dart' as _i14;
import 'package:widgetbook_workspace/organisms/register_form.dart' as _i15;
import 'package:widgetbook_workspace/views/auth_view.dart' as _i17;
import 'package:widgetbook_workspace/views/profile_view.dart' as _i16;

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
              builder: _i5.buildMainButtonUseCase,
            ),
          ),
          _i1.WidgetbookLeafComponent(
            name: 'SFSecondaryButton',
            useCase: _i1.WidgetbookUseCase(
              name: 'Default',
              builder: _i6.buildSecondaryButtonUseCase,
            ),
          ),
          _i1.WidgetbookLeafComponent(
            name: 'SFSecondaryIconButton',
            useCase: _i1.WidgetbookUseCase(
              name: 'Default',
              builder: _i7.buildIconSecondaryButtonUseCase,
            ),
          ),
        ],
      ),
      _i1.WidgetbookFolder(
        name: 'dividers',
        children: [
          _i1.WidgetbookLeafComponent(
            name: 'SFDividerWithText',
            useCase: _i1.WidgetbookUseCase(
              name: 'Default',
              builder: _i8.buildDividerWithTextUseCase,
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
              builder: _i9.buildTextFieldUseCase,
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
        name: 'TypographyUseCase',
        useCase: _i1.WidgetbookUseCase(
          name: 'Typography Showcase',
          builder: _i10.buildTypographyUseCase,
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
              builder: _i11.buildFormFieldUseCase,
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
            name: 'SFForgotPasswordForm',
            useCase: _i1.WidgetbookUseCase(
              name: 'Default',
              builder: _i12.buildForgotPasswordFormUseCase,
            ),
          ),
          _i1.WidgetbookLeafComponent(
            name: 'SFLoginForm',
            useCase: _i1.WidgetbookUseCase(
              name: 'Default',
              builder: _i13.buildLoginFormUseCase,
            ),
          ),
          _i1.WidgetbookLeafComponent(
            name: 'SFProfileForm',
            useCase: _i1.WidgetbookUseCase(
              name: 'Default',
              builder: _i14.buildProfileFormUseCase,
            ),
          ),
          _i1.WidgetbookLeafComponent(
            name: 'SFRegisterForm',
            useCase: _i1.WidgetbookUseCase(
              name: 'Default',
              builder: _i15.buildRegisterFormUseCase,
            ),
          ),
        ],
      ),
    ],
  ),
  _i1.WidgetbookFolder(
    name: 'views',
    children: [
      _i1.WidgetbookLeafComponent(
        name: 'ProfileView',
        useCase: _i1.WidgetbookUseCase(
          name: 'Default',
          builder: _i16.buildProfileViewUseCase,
        ),
      ),
      _i1.WidgetbookLeafComponent(
        name: 'SFAuthView',
        useCase: _i1.WidgetbookUseCase(
          name: 'Default',
          builder: _i17.buildAuthViewUseCase,
        ),
      ),
    ],
  ),
];
