import 'package:easydev_forms/easydev_forms.dart';
import 'package:flutter/widgets.dart';

/// Class that provides [Color]s and [TextStyle]s to [EasyDevDatePicker] and it's content.
class DatePickerDecoration {
  /// Color of selected month text.
  final Color? selectedMonthColor;

  /// Color of unselected month text.
  final Color? unselectedMonthColor;

  /// Color of selected year text.
  final Color? selectedYearColor;

  /// Color of unselected year text.
  final Color? unselectedYearColor;

  /// Color of background of selected year.
  final Color? selectedYearBackgroundColor;

  /// Color of active buttons for month and year text.
  final Color? activeColor;

  /// Color of inactive buttons for month and year text.
  final Color? inactiveColor;

  /// Color of active icon near button for month and year.
  final Color? iconColor;

  /// Color of weekday.
  final Color? weekdayColor;

  /// Color of selected day text.
  final Color? selectedDayColor;

  /// Color of unselected day text.
  final Color? unselectedDayColor;

  /// Color of disabled day text.
  final Color? disabledDayColor;

  ///Color of selected day background.
  final Color? selectedDayBackgroundColor;

  /// Color of border around current day.
  final Color? todayBorderColor;

  /// Color for days in selected interval.
  final Color? dayInSelectedIntervalColor;

  /// Background color for days in selected interval.
  final Color? dayInSelectedIntervalBackgroundColor;

  /// Border radius for selected days.
  final BorderRadius? selectedDayBorderRadius;

  /// TextStyle for displaying months.
  final TextStyle? monthsTextStyle;

  /// TextStyle for displaying years.
  final TextStyle? yearsTextStyle;

  /// TextStyle for displaying days.
  final TextStyle? daysTextStyle;

  const DatePickerDecoration({
    this.todayBorderColor,
    this.selectedMonthColor,
    this.unselectedMonthColor,
    this.selectedYearColor,
    this.unselectedYearColor,
    this.selectedYearBackgroundColor,
    this.activeColor,
    this.inactiveColor,
    this.iconColor,
    this.weekdayColor,
    this.selectedDayColor,
    this.unselectedDayColor,
    this.disabledDayColor,
    this.selectedDayBackgroundColor,
    this.selectedDayBorderRadius,
    this.dayInSelectedIntervalColor,
    this.dayInSelectedIntervalBackgroundColor,
    this.monthsTextStyle,
    this.yearsTextStyle,
    this.daysTextStyle,
  });
}
