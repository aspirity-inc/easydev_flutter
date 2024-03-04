import 'package:easydev_theme/easydev_theme.dart';
import 'package:easydev_theme/src/theme/easydev_assets_table_theme_data.dart';

class EasyDevThemeData {
  const EasyDevThemeData({
    required this.brightness,
    required this.colorPalette,
    this.buttonTheme,
    this.selectableTheme,
    this.switchTheme,
    this.inputTheme,
    this.codeInputTheme,
    this.inputNumberTheme,
    this.selectTheme,
    this.multiselectTheme,
    this.autocompleteTheme,
    this.sliderTheme,
    this.appBarTheme,
    this.bottomNavigationBarTheme,
    this.tabsTheme,
    this.segmentedControlTheme,
    this.dialogTheme,
    this.snackbarTheme,
    this.toastTheme,
    this.datePickerTheme,
    this.calendarTheme,
    this.dateInputTheme,
    this.typography,
    this.iconTheme,
    this.floatingActionButtonTheme,
    this.carouselTheme,
    this.bottomSheetTheme,
    this.actionSheetThemeData,
    this.actionMenuThemeData,
    this.chipsThemeData,
    this.assetsTableThemeData,
  });

  final Brightness brightness;

  final ColorPalette colorPalette;

  final EasyDevButtonThemeData? buttonTheme;

  final EasyDevSelectablesThemeData? selectableTheme;

  final EasyDevSwitchThemeData? switchTheme;

  final EasyDevInputThemeData? inputTheme;

  final EasyDevCodeInputThemeData? codeInputTheme;

  final EasyDevInputNumberThemeData? inputNumberTheme;

  final EasyDevSelectThemeData? selectTheme;

  final EasyDevMultiselectThemeData? multiselectTheme;

  final EasyDevAutocompleteThemeData? autocompleteTheme;

  final EasyDevSliderThemeData? sliderTheme;

  final EasyDevAppBarThemeData? appBarTheme;

  final EasyDevBottomNavigationBarThemeData? bottomNavigationBarTheme;

  final EasyDevTabsThemeData? tabsTheme;

  final EasyDevSegmentedControlThemeData? segmentedControlTheme;

  final EasyDevDialogThemeData? dialogTheme;

  final EasyDevSnackbarThemeData? snackbarTheme;

  final EasyDevToastThemeData? toastTheme;

  final EasyDevDatePickerDialogThemeData? datePickerTheme;

  final EasyDevCalendarThemeData? calendarTheme;

  final EasyDevDateInputThemeData? dateInputTheme;

  final TextTheme? typography;

  final EasyDevIconThemeData? iconTheme;

  final EasyDevFloatingActionButtonThemeData? floatingActionButtonTheme;

  final EasyDevCarouselThemeData? carouselTheme;

  final EasyDevBottomSheetThemeData? bottomSheetTheme;

  final EasyDevActionSheetThemeData? actionSheetThemeData;

  final EasyDevActionMenuThemeData? actionMenuThemeData;

  final EasyDevChipsThemeData? chipsThemeData;

  final EasyDevAssetsTableThemeData? assetsTableThemeData;

  @override
  bool operator ==(Object other) =>
      other is EasyDevThemeData &&
      brightness == other.brightness &&
      colorPalette == other.colorPalette &&
      buttonTheme == other.buttonTheme &&
      selectableTheme == other.selectableTheme &&
      switchTheme == other.switchTheme &&
      inputTheme == other.inputTheme &&
      codeInputTheme == other.codeInputTheme &&
      inputNumberTheme == other.inputNumberTheme &&
      selectTheme == other.selectTheme &&
      multiselectTheme == other.multiselectTheme &&
      autocompleteTheme == other.autocompleteTheme &&
      sliderTheme == other.sliderTheme &&
      appBarTheme == other.appBarTheme &&
      bottomNavigationBarTheme == other.bottomNavigationBarTheme &&
      tabsTheme == other.tabsTheme &&
      segmentedControlTheme == other.segmentedControlTheme &&
      dialogTheme == other.dialogTheme &&
      snackbarTheme == other.snackbarTheme &&
      toastTheme == other.toastTheme &&
      datePickerTheme == other.datePickerTheme &&
      calendarTheme == other.calendarTheme &&
      dateInputTheme == other.dateInputTheme &&
      typography == other.typography &&
      iconTheme == other.iconTheme &&
      carouselTheme == other.carouselTheme &&
      bottomSheetTheme == other.bottomSheetTheme &&
      floatingActionButtonTheme == other.floatingActionButtonTheme &&
      actionSheetThemeData == other.actionSheetThemeData &&
      actionMenuThemeData == other.actionMenuThemeData &&
      chipsThemeData == other.chipsThemeData &&
      assetsTableThemeData == other.assetsTableThemeData;

  @override
  int get hashCode => Object.hashAll([
        brightness,
        colorPalette,
        buttonTheme,
        selectableTheme,
        switchTheme,
        inputTheme,
        codeInputTheme,
        inputNumberTheme,
        selectTheme,
        multiselectTheme,
        autocompleteTheme,
        sliderTheme,
        appBarTheme,
        bottomNavigationBarTheme,
        tabsTheme,
        segmentedControlTheme,
        dialogTheme,
        snackbarTheme,
        toastTheme,
        datePickerTheme,
        calendarTheme,
        dateInputTheme,
        typography,
        iconTheme,
        calendarTheme,
        bottomSheetTheme,
        floatingActionButtonTheme,
        actionSheetThemeData,
        actionMenuThemeData,
        chipsThemeData,
        assetsTableThemeData,
      ]);

  EasyDevThemeData copyWith({
    Brightness? brightness,
    ColorPalette? colorPalette,
    EasyDevButtonThemeData? buttonTheme,
    EasyDevSelectablesThemeData? selectableTheme,
    EasyDevSwitchThemeData? switchTheme,
    EasyDevInputThemeData? inputTheme,
    EasyDevCodeInputThemeData? codeInputTheme,
    EasyDevInputNumberThemeData? inputNumberTheme,
    EasyDevSelectThemeData? selectTheme,
    EasyDevMultiselectThemeData? multiselectTheme,
    EasyDevAutocompleteThemeData? autocompleteTheme,
    EasyDevSliderThemeData? sliderTheme,
    EasyDevAppBarThemeData? appBarTheme,
    EasyDevBottomNavigationBarThemeData? bottomNavigationBarTheme,
    EasyDevTabsThemeData? tabsTheme,
    EasyDevSegmentedControlThemeData? segmentedControlTheme,
    EasyDevDialogThemeData? dialogTheme,
    EasyDevSnackbarThemeData? snackbarTheme,
    EasyDevToastThemeData? toastTheme,
    EasyDevDatePickerDialogThemeData? datePickerTheme,
    EasyDevCalendarThemeData? calendarTheme,
    EasyDevDateInputThemeData? dateInputTheme,
    TextTheme? typography,
    EasyDevIconThemeData? iconTheme,
    EasyDevFloatingActionButtonThemeData? floatingActionButtonTheme,
    EasyDevCarouselThemeData? carouselTheme,
    EasyDevBottomSheetThemeData? bottomSheetTheme,
    EasyDevActionSheetThemeData? actionSheetThemeData,
    EasyDevActionMenuThemeData? actionMenuThemeData,
    EasyDevChipsThemeData? chipsThemeData,
    EasyDevAssetsTableThemeData? assetsTableThemeData,
  }) =>
      EasyDevThemeData(
        brightness: brightness ?? this.brightness,
        colorPalette: colorPalette ?? this.colorPalette,
        buttonTheme: buttonTheme ?? this.buttonTheme,
        selectableTheme: selectableTheme ?? this.selectableTheme,
        switchTheme: switchTheme ?? this.switchTheme,
        inputTheme: inputTheme ?? this.inputTheme,
        codeInputTheme: codeInputTheme ?? this.codeInputTheme,
        inputNumberTheme: inputNumberTheme ?? this.inputNumberTheme,
        selectTheme: selectTheme ?? this.selectTheme,
        multiselectTheme: multiselectTheme ?? this.multiselectTheme,
        autocompleteTheme: autocompleteTheme ?? this.autocompleteTheme,
        sliderTheme: sliderTheme ?? this.sliderTheme,
        appBarTheme: appBarTheme ?? this.appBarTheme,
        bottomNavigationBarTheme: bottomNavigationBarTheme ?? this.bottomNavigationBarTheme,
        tabsTheme: tabsTheme ?? this.tabsTheme,
        segmentedControlTheme: segmentedControlTheme ?? this.segmentedControlTheme,
        dialogTheme: dialogTheme ?? this.dialogTheme,
        snackbarTheme: snackbarTheme ?? this.snackbarTheme,
        toastTheme: toastTheme ?? this.toastTheme,
        datePickerTheme: datePickerTheme ?? this.datePickerTheme,
        calendarTheme: calendarTheme ?? this.calendarTheme,
        dateInputTheme: dateInputTheme ?? this.dateInputTheme,
        typography: typography ?? this.typography,
        iconTheme: iconTheme ?? this.iconTheme,
        floatingActionButtonTheme: floatingActionButtonTheme ?? this.floatingActionButtonTheme,
        carouselTheme: carouselTheme ?? this.carouselTheme,
        bottomSheetTheme: bottomSheetTheme ?? this.bottomSheetTheme,
        actionSheetThemeData: actionSheetThemeData ?? this.actionSheetThemeData,
        actionMenuThemeData: actionMenuThemeData ?? this.actionMenuThemeData,
        chipsThemeData: chipsThemeData ?? this.chipsThemeData,
        assetsTableThemeData: assetsTableThemeData ?? this.assetsTableThemeData,
      );
}

final defaultDarkTheme = EasyDevThemeData(
  brightness: Brightness.dark,
  iconTheme: EasyDevIconThemeData(
    color: darkVioletSwatch[300] ?? darkVioletSwatch,
  ),
  colorPalette: ColorPalette(
    primarySwatch: darkGreenSwatch,
    secondarySwatch: darkVioletSwatch,
    tertiarySwatch: darkLilacSwatch,
    greySwatch: darkGreySwatch,
    successSwatch: darkSuccessGreenSwatch,
    errorSwatch: darkRedSwatch,
    warningSwatch: darkOrangeSwatch,
    linksSwatch: darkBlueSwatch,
  ),
  typography: TextTheme.copyWithColor(
    defaultTextTheme,
    darkGreySwatch.onBackgroundColor!,
  ),
);

final defaultLightTheme = EasyDevThemeData(
  brightness: Brightness.light,
  iconTheme: EasyDevIconThemeData(
    color: lightVioletSwatch[300] ?? lightVioletSwatch,
  ),
  colorPalette: ColorPalette(
    primarySwatch: lightGreenSwatch,
    secondarySwatch: lightVioletSwatch,
    tertiarySwatch: lightLilacSwatch,
    greySwatch: lightGreySwatch,
    successSwatch: lightSuccessGreenSwatch,
    errorSwatch: lightRedSwatch,
    warningSwatch: lightOrangeSwatch,
    linksSwatch: lightBlueSwatch,
  ),
  typography: TextTheme.copyWithColor(
    defaultTextTheme,
    lightGreySwatch.onBackgroundColor!,
  ),
);
