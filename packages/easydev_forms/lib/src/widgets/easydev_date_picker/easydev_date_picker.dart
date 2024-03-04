import 'package:easydev_forms/easydev_forms.dart';
import 'package:easydev_forms/src/widgets/easydev_date_picker/date_picker_calendar.dart';
import 'package:easydev_forms/src/widgets/easydev_date_picker/easydev_date_picker_content.dart';

import 'package:flutter/widgets.dart';
import 'package:easydev_theme/easydev_theme.dart';

/// [EasyDevDatePicker] that can be displayed to select date. It displays [YearPicker],
/// [MonthPicker] and [DatePickerCalendar] depending if user is selected year, month or day.
/// User can reselect month and year by pressing corresponding buttons on top of date picker.
/// User need to provide start and end dates, and callbacks on ok button tapped [onOkTap],
/// and on cancelling selection [onCancelTap]. Text can be changed by providing [okButtonText]
/// and [cancelButtonText].
/// By proving [locale] you can customize month name and starting day of week.
/// [onDateSelected] callback provides  way to instantly receive selected value,
/// even if user does not tapped ok button. It can be helpful to show selected date outside
/// of date picker.
/// When provided [initialDate] this date will be initially selected.
///
///
/// Example of using [EasyDevDateInput].
/// ```dart
///  EasyDevDatePicker(
///   endDate: DateTime(2050),
///   initialDate: DateTime(2024),
///   startDate: DateTime(1800),
///   onCancelTap: () {},
///   onOkTap: (value) {
///      ...
///    }
///   ),
/// ```
///
///
/// This sample shows app with [EasyDevDatePicker].
///
/// See code in example/lib/pages/examples/date_picker_example.dart
///
/// See also:
///
///  * [EasyDevDateInput], input field used for inputting date.
///  * [EasyDevDateRangePicker], picker for picking date ranges.
class EasyDevDatePicker extends StatefulWidget {
  /// Create a date picker.
  EasyDevDatePicker({
    super.key,
    required this.startDate,
    required this.endDate,
    required this.onCancelTap,
    required this.onOkTap,
    this.locale = 'en',
    this.onDateSelected,
    this.initialDate,
    this.value,
    this.formatMonth,
    this.formatWeekday,
    this.showDisabledDays = true,
    this.decoration,
    this.okButtonText,
    this.cancelButtonText,
  }) : assert(
            (initialDate?.isBefore(endDate) ?? true) && (initialDate?.isAfter(startDate) ?? true));

  /// Initial date, when provided this date it will be initially selected.
  final DateTime? initialDate;

  /// Latest boundary of date shown in date picker.
  final DateTime startDate;

  /// Further date shown in date picker.
  final DateTime endDate;

  /// Locale for the displaying of months and weekdays.
  final String locale;

  /// Function for formatting months.
  final String Function(String)? formatMonth;

  /// Function for formatting weekdays.
  final String Function(String)? formatWeekday;

  /// Callback when date selected.
  final ValueChanged<DateTime>? onDateSelected;

  /// Callback when ok button tapped.
  final ValueChanged<DateTime?> onOkTap;

  /// When [value] != null, selectedDate always will be equal to it.
  /// Used when date must be passed to [EasyDevDatePicker].
  final DateTime? value;

  /// Callback when cancel button tapped
  final VoidCallback onCancelTap;

  /// Either calendar should show days of previous and next month, making each
  /// row 7 days long. Days of other months will be disabled for selection.
  final bool showDisabledDays;

  /// {@macro easydev_forms.widgets.easydev_date_picker.date_picker_decoration}
  final DatePickerDecoration? decoration;

  /// Text of "OK" button, reacting on [onOkTap].
  final String? okButtonText;

  /// Text of "Cancel" button, reacting on [onCancelTap].
  final String? cancelButtonText;

  @override
  State<EasyDevDatePicker> createState() => _EasyDevDatePickerState();
}

class _EasyDevDatePickerState extends State<EasyDevDatePicker> {
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
              : (colorPalette.secondarySwatch?[300] ??
                  colorPalette.secondarySwatch ??
                  colorPalette.primarySwatch)),
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
      todayBorderColor: widget.decoration?.todayBorderColor ??
          calendarTheme?.todayBorderColor ??
          (theme.brightness == Brightness.light
              ? (colorPalette.secondarySwatch?[200] ??
                  colorPalette.secondarySwatch ??
                  colorPalette.primarySwatch)
              : (colorPalette.secondarySwatch?[400] ??
                  colorPalette.secondarySwatch ??
                  colorPalette.primarySwatch)),
      monthsTextStyle:
          widget.decoration?.monthsTextStyle ?? theme.typography?.body1Style ?? const TextStyle(),
      daysTextStyle:
          widget.decoration?.daysTextStyle ?? theme.typography?.body2Style ?? const TextStyle(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return EasyDevDatePickerContent(
      startDate: widget.startDate,
      endDate: widget.endDate,
      onCancelTap: widget.onCancelTap,
      onOkTap: widget.onOkTap,
      decoration: _decoration,
      locale: widget.locale,
      onDateSelected: widget.onDateSelected,
      initialDate: widget.initialDate,
      value: widget.value,
      formatMonth: widget.formatMonth,
      formatWeekday: widget.formatWeekday,
      showDisabledDays: widget.showDisabledDays,
    );
  }
}
