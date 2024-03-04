import 'dart:ui' as ui;

import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/cupertino.dart' as cupertino;
import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart';

class EasyDevTheme extends InheritedWidget {
  const EasyDevTheme({
    super.key,
    this.lightThemeData,
    this.darkThemeData,
    this.usePlatformBrightness = false,
    this.brightness = Brightness.light,
    required super.child,
  }) : assert(
          lightThemeData != null || darkThemeData != null,
          'App should contain at least one theme',
        );

  final EasyDevThemeData? lightThemeData;

  final EasyDevThemeData? darkThemeData;

  final bool usePlatformBrightness;

  final Brightness brightness;

  static EasyDevThemeData of(BuildContext context) {
    EasyDevTheme? theme = context.dependOnInheritedWidgetOfExactType<EasyDevTheme>();
    if (theme == null) {
      if (context.findAncestorWidgetOfExactType<material.Theme>() != null) {
        final materialTheme = material.Theme.of(context);

        return resolveMaterialTheme(materialTheme);
      } else if (context.findAncestorWidgetOfExactType<cupertino.CupertinoTheme>() != null) {
        final cupertinoTheme = cupertino.CupertinoTheme.of(context);

        return resolveCupertinoTheme(cupertinoTheme);
      }
    }
    assert(theme != null, 'No EasyDevTheme, Theme or CupertinoTheme found in context');
    if (theme!.usePlatformBrightness) {
      final platformBrightness = MediaQuery.of(context).platformBrightness;
      if (platformBrightness == ui.Brightness.dark) {
        return theme.darkThemeData ?? theme.lightThemeData!;
      }
      return theme.lightThemeData ?? theme.darkThemeData!;
    }
    if (theme.brightness == Brightness.dark) {
      return theme.darkThemeData ?? theme.lightThemeData!;
    }
    return theme.lightThemeData ?? theme.darkThemeData!;
  }

  @override
  bool updateShouldNotify(EasyDevTheme oldWidget) =>
      lightThemeData != oldWidget.lightThemeData ||
      darkThemeData != oldWidget.darkThemeData ||
      usePlatformBrightness != oldWidget.usePlatformBrightness ||
      brightness != oldWidget.brightness;
}

extension EasyDevThemeExtension on BuildContext {
  EasyDevThemeData get easyDevTheme => EasyDevTheme.of(this);
}

EasyDevThemeData resolveMaterialTheme(material.ThemeData materialTheme) {
  return EasyDevThemeData(
    brightness:
        materialTheme.brightness == material.Brightness.dark ? Brightness.dark : Brightness.light,
    colorPalette: ColorPalette(
      primarySwatch: ColorSwatch(
        materialTheme.colorScheme.primary.value,
        {
          500: materialTheme.colorScheme.primary,
        },
      ),
      secondarySwatch: ColorSwatch(
        materialTheme.colorScheme.secondary.value,
        {
          500: materialTheme.colorScheme.secondary,
        },
      ),
      tertiarySwatch: ColorSwatch(
        materialTheme.colorScheme.tertiary.value,
        {
          500: materialTheme.colorScheme.tertiary,
        },
      ),
      errorSwatch: ColorSwatch(
        materialTheme.colorScheme.error.value,
        {
          500: materialTheme.colorScheme.error,
        },
      ),
      greySwatch: GreySwatch(
        surfaceColor: materialTheme.colorScheme.surface,
        onSurfaceColor: materialTheme.colorScheme.onSurface,
        greyColor: materialTheme.brightness == cupertino.Brightness.dark
            ? darkThemeGrey400
            : lightThemeGrey400,
      ),
    ),
    typography: TextTheme(
      body1Style: materialTheme.textTheme.bodyLarge,
      body2Style: materialTheme.textTheme.bodyMedium,
      body3Style: materialTheme.textTheme.bodySmall,
      heading1Style: materialTheme.textTheme.headlineLarge,
      heading2Style: materialTheme.textTheme.headlineMedium,
      heading3Style: materialTheme.textTheme.headlineSmall,
      heading4Style: materialTheme.textTheme.titleLarge,
      subheading1Style: materialTheme.textTheme.titleMedium,
      subheading2Style: materialTheme.textTheme.titleSmall,
      captionStyle: materialTheme.textTheme.labelLarge,
      tooltipStyle: materialTheme.textTheme.labelMedium,
      buttonStyle: materialTheme.textTheme.titleLarge,
    ),
    buttonTheme: EasyDevButtonThemeData(
      minWidth: materialTheme.buttonTheme.minWidth,
      defaultColor:
          materialTheme.buttonTheme.colorScheme?.primary ?? materialTheme.colorScheme.primary,
      disabledColor: materialTheme.disabledColor,
    ),
    selectableTheme: EasyDevSelectablesThemeData(
      disabledColor: materialTheme.disabledColor,
      selectedColor: materialTheme.colorScheme.primary,
      unselectedColor: materialTheme.colorScheme.primary,
    ),
    inputTheme: EasyDevInputThemeData(
      iconColor: materialTheme.inputDecorationTheme.iconColor,
      filledColor: materialTheme.inputDecorationTheme.fillColor,
      focusedColor: materialTheme.inputDecorationTheme.focusColor,
      disabledColor: materialTheme.disabledColor,
      labelColor: materialTheme.inputDecorationTheme.labelStyle?.color,
      hintColor: materialTheme.inputDecorationTheme.hintStyle?.color,
    ),
    sliderTheme: EasyDevSliderThemeData(
      selectedTrackColor: materialTheme.sliderTheme.activeTrackColor,
      unselectedTrackColor: materialTheme.sliderTheme.inactiveTrackColor,
      handleColor: materialTheme.sliderTheme.thumbColor,
      disabledColor: materialTheme.disabledColor,
      sliderTrackThickness: materialTheme.sliderTheme.trackHeight,
    ),
    appBarTheme: EasyDevAppBarThemeData(
      backgroundColor: materialTheme.appBarTheme.backgroundColor,
      actionIconColor: materialTheme.appBarTheme.actionsIconTheme?.color,
      actionIconSize: materialTheme.appBarTheme.actionsIconTheme?.size,
      titleColor: materialTheme.appBarTheme.titleTextStyle?.color,
    ),
    bottomNavigationBarTheme: EasyDevBottomNavigationBarThemeData(
      backgroundColor: materialTheme.bottomNavigationBarTheme.backgroundColor,
      elevation: materialTheme.bottomNavigationBarTheme.elevation,
      selectedLabelTextStyle: materialTheme.bottomNavigationBarTheme.selectedLabelStyle,
      selectedLabelColor: materialTheme.bottomNavigationBarTheme.selectedLabelStyle?.color,
      selectedIconColor: materialTheme.bottomNavigationBarTheme.selectedIconTheme?.color,
      unselectedIconColor: materialTheme.bottomNavigationBarTheme.unselectedIconTheme?.color,
      unselectedLabelColor: materialTheme.bottomNavigationBarTheme.unselectedLabelStyle?.color,
      unselectedLabelTextStyle: materialTheme.bottomNavigationBarTheme.unselectedLabelStyle,
    ),
    tabsTheme: EasyDevTabsThemeData(
      dividerColor: materialTheme.tabBarTheme.dividerColor,
      selectedLabelColor: materialTheme.tabBarTheme.labelColor,
      selectedLabelStyle: materialTheme.tabBarTheme.labelStyle,
      unselectedLabelStyle: materialTheme.tabBarTheme.unselectedLabelStyle,
      unselectedLabelColor: materialTheme.tabBarTheme.unselectedLabelColor,
      selectedIndicator: materialTheme.tabBarTheme.indicator,
      selectedIndicatorColor: materialTheme.tabBarTheme.indicatorColor,
    ),
    dialogTheme: EasyDevDialogThemeData(
      backgroundColor: materialTheme.dialogTheme.backgroundColor,
      elevation: materialTheme.dialogTheme.elevation,
    ),
    snackbarTheme: EasyDevSnackbarThemeData(
      actionColor: materialTheme.snackBarTheme.actionTextColor,
    ),
    datePickerTheme: EasyDevDatePickerDialogThemeData(
      backgroundColor: materialTheme.datePickerTheme.backgroundColor,
    ),
    calendarTheme: EasyDevCalendarThemeData(
      todayBorderColor: materialTheme.datePickerTheme.todayBorder?.color,
      weekdayColor: materialTheme.datePickerTheme.weekdayStyle?.color,
    ),
    dateInputTheme: EasyDevDateInputThemeData(
      disabledColor: materialTheme.disabledColor,
      focusedColor: materialTheme.inputDecorationTheme.focusColor,
      hintColor: materialTheme.inputDecorationTheme.hintStyle?.color,
    ),
    iconTheme: EasyDevIconThemeData(
      color: materialTheme.iconTheme.color,
      size: materialTheme.iconTheme.size,
    ),
    bottomSheetTheme: EasyDevBottomSheetThemeData(
      backgroundColor: materialTheme.bottomSheetTheme.backgroundColor,
      elevation: materialTheme.bottomSheetTheme.elevation,
      dragHandleColor: materialTheme.bottomSheetTheme.dragHandleColor,
      dragHandleWidth: materialTheme.bottomSheetTheme.dragHandleSize?.width,
      dragHandleThickness: materialTheme.bottomSheetTheme.dragHandleSize?.height,
    ),
    floatingActionButtonTheme: EasyDevFloatingActionButtonThemeData(
      elevation: materialTheme.floatingActionButtonTheme.elevation,
      disabledElevation: materialTheme.floatingActionButtonTheme.disabledElevation,
      color: materialTheme.floatingActionButtonTheme.backgroundColor,
      tapColor: materialTheme.floatingActionButtonTheme.splashColor,
      disabledColor: materialTheme.disabledColor,
    ),
    chipsThemeData: EasyDevChipsThemeData(
      disabledColor: materialTheme.chipTheme.disabledColor,
      iconColor: materialTheme.chipTheme.iconTheme?.color,
    ),
  );
}

EasyDevThemeData resolveCupertinoTheme(cupertino.CupertinoThemeData cupertinoTheme) {
  return EasyDevThemeData(
    brightness:
        cupertinoTheme.brightness == cupertino.Brightness.dark ? Brightness.dark : Brightness.light,
    colorPalette: ColorPalette(
      primarySwatch: ColorSwatch(
        cupertinoTheme.primaryColor.value,
        {
          500: cupertinoTheme.primaryColor,
        },
      ),
      greySwatch: GreySwatch(
        surfaceColor: cupertinoTheme.scaffoldBackgroundColor,
        onSurfaceColor: cupertinoTheme.primaryContrastingColor,
        greyColor: cupertinoTheme.brightness == cupertino.Brightness.dark
            ? darkThemeGrey400
            : lightThemeGrey400,
      ),
    ),
  );
}
