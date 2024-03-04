import 'package:easydev_forms/easydev_forms.dart';
import 'package:easydev_forms/src/widgets/easydev_date_range_picker/easydev_date_range_picker_content.dart';

import 'package:flutter/widgets.dart';
import 'package:easydev_theme/easydev_theme.dart';

/// [EasyDevDateRangePicker] allows user to select two date ranges with start and end of
/// this range.
///
///
/// Example of using [EasyDevDateRangeInput].
/// ```dart
///  EasyDevDateRangePicker(
///   endDate: DateTime(2024, 12),
///   startDate: DateTime(1800),
///   onSelectTap: (value) {
///    ...
///   },
///  ),
/// ```
///
///
/// This sample shows app with [EasyDevDateRangePicker].
///
/// See code in example/lib/pages/examples/date_range_picker_example.dart
///
/// See also:
///
///  * [EasyDevDateRangeInputInput], input fields used for picking date range.
///  * [EasyDevDatePicker], picker for picking single date.
class EasyDevDateRangePicker extends StatefulWidget {
  /// Create a date picker.
  EasyDevDateRangePicker({
    super.key,
    required this.startDate,
    required this.endDate,
    required this.onSelectTap,
    this.controller,
    this.onDateRangeSelected,
    this.value,
    this.decoration,
    this.initialDateRange,
    this.locale = 'en',
    this.formatMonth,
    this.formatWeekday,
    this.showDisabledDays = true,
    this.okButtonText,
    this.cancelButtonText,
  }) : assert((initialDateRange?.start.isBefore(endDate) ?? true) &&
            (initialDateRange?.end.isAfter(startDate) ?? true));

  /// Initial [DateRange], when provided month and year of this date, will be initially selected.
  final DateRange? initialDateRange;

  /// Latest boundary of date shown in date picker.
  final DateTime startDate;

  /// Further date shown in date picker.
  final DateTime endDate;

  /// When [value] != null, selectedDate always will be equal to it.
  /// Used when date must be passed to [EasyDevDateRangePicker].
  final NullableDateRange? value;

  /// Callback when date range selected
  final ValueChanged<DateRange> onSelectTap;

  /// Callback when date selected
  final ValueChanged<NullableDateRange>? onDateRangeSelected;

  /// Locale for the displaying of months and weekdays
  final String locale;

  /// Function for formatting months.
  final String Function(String)? formatMonth;

  /// Function for formatting weekdays.
  final String Function(String)? formatWeekday;

  /// Either calendar should show days of previous and next month, making each
  /// row 7 days long. Days of other months will be disabled for selection.
  final bool showDisabledDays;

  /// {@macro easydev_forms.widgets.easydev_date_picker.date_picker_decoration}
  final DatePickerDecoration? decoration;

  /// Text of "OK" button, reacting on [onOkTap].
  final String? okButtonText;

  /// Text of "Cancel" button, reacting on [onCancelTap].
  final String? cancelButtonText;

  /// ScrollController for controlling calendar scroll
  final ScrollController? controller;

  @override
  State<EasyDevDateRangePicker> createState() => _EasyDevDateRangePickerState();
}

class _EasyDevDateRangePickerState extends State<EasyDevDateRangePicker> {
  late DatePickerDecoration _decoration;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setAndUpdateFields();
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    setAndUpdateFields();
  }

  void setAndUpdateFields() {
    final theme = EasyDevTheme.of(context);
    final colorPalette = theme.colorPalette;
    final calendarTheme = theme.calendarTheme;

    _decoration = DatePickerDecoration(
      selectedMonthColor: widget.decoration?.selectedMonthColor ??
          calendarTheme?.selectedMonthColor ??
          (theme.brightness == Brightness.light
              ? colorPalette.primarySwatch[700] ?? colorPalette.primarySwatch
              : colorPalette.primarySwatch[500] ?? colorPalette.primarySwatch),
      unselectedMonthColor: widget.decoration?.unselectedMonthColor ??
          calendarTheme?.unselectedMonthColor ??
          (theme.brightness == Brightness.light
              ? colorPalette.greySwatch.onBackgroundColor ?? colorPalette.greySwatch.greyColor
              : colorPalette.greySwatch.dividerColor ?? colorPalette.greySwatch.greyColor),
      activeColor: widget.decoration?.activeColor ??
          calendarTheme?.activeColor ??
          (theme.brightness == Brightness.light
              ? (colorPalette.secondarySwatch?[700] ??
                  colorPalette.secondarySwatch ??
                  colorPalette.primarySwatch)
              : (colorPalette.tertiarySwatch?[100] ??
                  colorPalette.tertiarySwatch ??
                  colorPalette.secondarySwatch ??
                  colorPalette.primarySwatch)),
      inactiveColor: widget.decoration?.inactiveColor ??
          calendarTheme?.inactiveColor ??
          (theme.brightness == Brightness.light
              ? colorPalette.greySwatch.unselectedColor ?? colorPalette.greySwatch.greyColor
              : colorPalette.greySwatch.disabledColor ?? colorPalette.greySwatch.greyColor),
      iconColor: widget.decoration?.iconColor ??
          calendarTheme?.iconColor ??
          (theme.brightness == Brightness.light
              ? (colorPalette.secondarySwatch?[600] ??
                  colorPalette.secondarySwatch ??
                  colorPalette.primarySwatch)
              : colorPalette.secondarySwatch?[300] ?? colorPalette.secondarySwatch),
      weekdayColor: widget.decoration?.weekdayColor ??
          calendarTheme?.weekdayColor ??
          (theme.brightness == Brightness.light
              ? colorPalette.greySwatch.onSurfaceColor
              : colorPalette.greySwatch.dividerColor ?? colorPalette.greySwatch.greyColor),
      selectedDayColor: widget.decoration?.selectedDayColor ??
          calendarTheme?.selectedDayColor ??
          (theme.brightness == Brightness.light
              ? colorPalette.greySwatch.onBackgroundColor ?? colorPalette.greySwatch.greyColor
              : colorPalette.greySwatch.onSurfaceColor),
      dayInSelectedIntervalColor: widget.decoration?.dayInSelectedIntervalColor ??
          calendarTheme?.dateRangeColor ??
          (theme.brightness == Brightness.light
              ? colorPalette.greySwatch.onBackgroundColor ?? colorPalette.greySwatch.greyColor
              : colorPalette.greySwatch.onBackgroundColor ?? colorPalette.greySwatch.greyColor),
      unselectedDayColor: widget.decoration?.unselectedDayColor ??
          calendarTheme?.unselectedDayColor ??
          (theme.brightness == Brightness.light
              ? colorPalette.greySwatch.onBackgroundColor ?? colorPalette.greySwatch.greyColor
              : colorPalette.greySwatch.dividerColor ?? colorPalette.greySwatch.greyColor),
      disabledDayColor: widget.decoration?.disabledDayColor ??
          calendarTheme?.disabledDayColor ??
          (theme.brightness == Brightness.light
              ? colorPalette.greySwatch.greyColor
              : colorPalette.greySwatch.unselectedColor ?? colorPalette.greySwatch.greyColor),
      selectedDayBackgroundColor: widget.decoration?.selectedDayBackgroundColor ??
          calendarTheme?.dateRangeEndsBackgroundColor ??
          (theme.brightness == Brightness.light
              ? (colorPalette.secondarySwatch?[400] ??
                  colorPalette.secondarySwatch ??
                  colorPalette.primarySwatch)
              : (colorPalette.secondarySwatch?[500] ??
                  colorPalette.secondarySwatch ??
                  colorPalette.primarySwatch)),
      dayInSelectedIntervalBackgroundColor:
          widget.decoration?.dayInSelectedIntervalBackgroundColor ??
              calendarTheme?.dateRangeEndsBackgroundColor ??
              (theme.brightness == Brightness.light
                  ? (colorPalette.secondarySwatch?[100] ??
                      colorPalette.secondarySwatch ??
                      colorPalette.primarySwatch)
                  : colorPalette.tertiarySwatch?[900] ??
                      colorPalette.secondarySwatch ??
                      colorPalette.primarySwatch),
      todayBorderColor: widget.decoration?.todayBorderColor ??
          calendarTheme?.todayBorderColor ??
          (theme.brightness == Brightness.light
              ? (colorPalette.secondarySwatch?[200] ??
                  colorPalette.secondarySwatch ??
                  colorPalette.primarySwatch)
              : colorPalette.secondarySwatch?[400] ??
                  colorPalette.secondarySwatch ??
                  colorPalette.primarySwatch),
      selectedYearBackgroundColor: widget.decoration?.selectedYearBackgroundColor ??
          calendarTheme?.selectedYearBackgroundColor ??
          (theme.brightness == Brightness.light
              ? (colorPalette.secondarySwatch?[300] ??
                  colorPalette.secondarySwatch ??
                  colorPalette.primarySwatch)
              : colorPalette.secondarySwatch?[600] ??
                  colorPalette.secondarySwatch ??
                  colorPalette.primarySwatch),
      selectedYearColor: widget.decoration?.selectedYearColor ??
          calendarTheme?.selectedYearColor ??
          (theme.brightness == Brightness.light
              ? colorPalette.greySwatch.surfaceColor
              : colorPalette.greySwatch.dividerColor ?? colorPalette.greySwatch.greyColor),
      unselectedYearColor: widget.decoration?.unselectedYearColor ??
          calendarTheme?.unselectedYearColor ??
          (theme.brightness == Brightness.light
              ? colorPalette.greySwatch.onSurfaceBright ?? colorPalette.greySwatch.greyColor
              : colorPalette.greySwatch.dividerColor ?? colorPalette.greySwatch.greyColor),
      selectedDayBorderRadius: widget.decoration?.selectedDayBorderRadius ??
          calendarTheme?.dateRangeEndsRadius ??
          const BorderRadius.all(Radius.circular(2)),
      monthsTextStyle: (theme.typography?.body1Style ?? const TextStyle()),
      daysTextStyle: (theme.typography?.body2Style ?? const TextStyle()),
      yearsTextStyle: (theme.typography?.subheading1Style ?? const TextStyle()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return EasyDevDateRangePickerContent(
      startDate: widget.startDate,
      endDate: widget.endDate,
      onSelectTap: widget.onSelectTap,
      decoration: _decoration,
      initialDateRange: widget.initialDateRange,
      onDateRangeSelected: widget.onDateRangeSelected,
      value: widget.value,
      locale: widget.locale,
      formatMonth: widget.formatMonth,
      formatWeekday: widget.formatWeekday,
      showDisabledDays: widget.showDisabledDays,
      okButtonText: widget.okButtonText,
      cancelButtonText: widget.cancelButtonText,
      controller: widget.controller,
    );
  }
}
