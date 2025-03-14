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
import 'package:widgetbook_workspace/atoms/buttons/main_button.dart' as _i4;
import 'package:widgetbook_workspace/atoms/buttons/secondary_button.dart'
    as _i5;

final directories = <_i1.WidgetbookNode>[
  _i1.WidgetbookFolder(
    name: 'atoms',
    children: [
      _i1.WidgetbookFolder(
        name: 'buttons',
        children: [
          _i1.WidgetbookLeafComponent(
            name: 'CircularButtonWidget',
            useCase: _i1.WidgetbookUseCase(
              name: 'Default',
              builder: _i2.buildCircularButtonUseCase,
            ),
          ),
          _i1.WidgetbookLeafComponent(
            name: 'IconButtonWidget',
            useCase: _i1.WidgetbookUseCase(
              name: 'Default',
              builder: _i3.buildIconButtonUseCase,
            ),
          ),
          _i1.WidgetbookLeafComponent(
            name: 'MainButtonWidget',
            useCase: _i1.WidgetbookUseCase(
              name: 'Default',
              builder: _i4.buildCoolButtonUseCase,
            ),
          ),
          _i1.WidgetbookLeafComponent(
            name: 'SecondaryButtonWidget',
            useCase: _i1.WidgetbookUseCase(
              name: 'Default',
              builder: _i5.buildCoolButtonUseCase,
            ),
          ),
        ],
      ),
    ],
  ),
];
