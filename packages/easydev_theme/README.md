# easydev_theme

---

This package containts themes for decoration widgets from EasyDev UI Kit.

This package includes themes for widgets from packages: easydev_basics, easydev_base_ui and easydev_forms. Most widgets from these packages must be wrapped `EasyDevTheme` from this package to set their style parameters.

## Installation

---

To use this package, add easydev_theme as a dependency in your pubspec.yaml file.

## Usage

---

Import package into your code:

```
import "package:easydev_theme/easydev_theme.dart";
```

When using EasyDevApp (from easydev_basics), light and dark `EasyDevThemeData` can be added to corresponding fields. This package includes two default theme datas that can be used there: `defaultLightTheme` and `defaultDarkTheme`.

```
EasyDevApp(
  ...
  darkThemeData: defaultDarkTheme,
  lightThemeData: defaultLightTheme,
),
```

Alternatively, `EasyDevTheme` can be used directly to provide styles to widgets. Also, `EasyDevTheme` resolves automatically when `MaterialApp` or `CupertinoApp` are used.

### Basics

`EasyDevThemeData` includes common elements that can be applied through app, such as `ColorPalette`, `TextTheme` and `EasyDevIconThemeData`. Also it includes more specific themes that can be applied to specific widgets from EasyDev UI Kit. This themes are given below.

`EasyDevThemeData` includes themes for widgets from easydev_base_ui:

- `EasyDevButtonThemeData`;
- `EasyDevCarouselThemeData`;
- `EasyDevInputThemeData`;
- `EasyDevTabsThemeData`;
- `EasyDevActionSheetThemeData`;
- `EasyDevActionMenuThemeData`.

`EasyDevThemeData` includes themes for widgets from easydev_basics:

- `EasyDevAppBarThemeData`;
- `EasyDevBottomNavigationBarThemeData`;
- `EasyDevDialogThemeData`;
- `EasyDevSnackbarThemeData`;
- `EasyDevToastThemeData`;
- `EasyDevFloatingActionButtonThemeData`;
- `EasyDevBottomSheetThemeData`.

`EasyDevThemeData` includes themes for widgets from easydev_forms:

- `EasyDevSelectablesThemeData`;
- `EasyDevSwitchThemeData`;
- `EasyDevCodeInputThemeData`;
- `EasyDevInputNumberThemeData`;
- `EasyDevSelectThemeData`;
- `EasyDevMultiselectThemeData`;
- `EasyDevSliderThemeData`;
- `EasyDevDatePickerDialogThemeData`;
- `EasyDevCalendarThemeData`;
- `EasyDevDateInputThemeData`;
- `EasyDevChipsThemeData`.
