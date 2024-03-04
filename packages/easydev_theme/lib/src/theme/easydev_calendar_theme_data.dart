import 'package:flutter/painting.dart';

class EasyDevCalendarThemeData {
  const EasyDevCalendarThemeData({
    this.addNextPreviousMonthButtons,
    this.selectedMonthColor,
    this.unselectedMonthColor,
    this.selectedYearColor,
    this.unselectedYearColor,
    this.activeColor,
    this.inactiveColor,
    this.iconColor,
    this.weekdayColor,
    this.todayBorderColor,
    this.selectedDayColor,
    this.unselectedDayColor,
    this.disabledDayColor,
    this.dateRangeEndsBackgroundColor,
    this.dateRangeBackgroundColor,
    this.dateRangeColor,
    this.dateRangeEndsRadius,
    this.calendarDaySize,
    this.buttonsColor,
    this.selectedYearBackgroundColor,
  });

  final bool? addNextPreviousMonthButtons;

  final Color? selectedMonthColor;

  final Color? unselectedMonthColor;

  final Color? selectedYearColor;

  final Color? unselectedYearColor;

  final Color? activeColor;

  final Color? inactiveColor;

  final Color? iconColor;

  final Color? weekdayColor;

  final Color? todayBorderColor;

  final Color? selectedDayColor;

  final Color? unselectedDayColor;

  final Color? disabledDayColor;

  final Color? dateRangeEndsBackgroundColor;

  final Color? dateRangeBackgroundColor;

  final Color? dateRangeColor;

  final Color? buttonsColor;

  final Color? selectedYearBackgroundColor;

  final BorderRadius? dateRangeEndsRadius;

  final double? calendarDaySize;

  @override
  bool operator ==(Object other) =>
      other is EasyDevCalendarThemeData &&
      addNextPreviousMonthButtons == other.addNextPreviousMonthButtons &&
      selectedMonthColor == other.selectedMonthColor &&
      unselectedMonthColor == other.unselectedMonthColor &&
      selectedYearColor == other.selectedYearColor &&
      unselectedYearColor == other.unselectedYearColor &&
      activeColor == other.activeColor &&
      buttonsColor == other.buttonsColor &&
      selectedYearBackgroundColor == other.selectedYearBackgroundColor &&
      inactiveColor == other.inactiveColor &&
      iconColor == other.iconColor &&
      weekdayColor == other.weekdayColor &&
      todayBorderColor == other.todayBorderColor &&
      selectedDayColor == other.selectedDayColor &&
      unselectedDayColor == other.unselectedDayColor &&
      disabledDayColor == other.disabledDayColor &&
      dateRangeEndsBackgroundColor == other.dateRangeEndsBackgroundColor &&
      dateRangeBackgroundColor == other.dateRangeBackgroundColor &&
      dateRangeColor == other.dateRangeColor &&
      dateRangeEndsRadius == other.dateRangeEndsRadius &&
      calendarDaySize == other.calendarDaySize;

  @override
  int get hashCode => Object.hash(
        addNextPreviousMonthButtons,
        selectedMonthColor,
        unselectedMonthColor,
        selectedYearColor,
        unselectedYearColor,
        activeColor,
        inactiveColor,
        iconColor,
        weekdayColor,
        todayBorderColor,
        selectedDayColor,
        unselectedDayColor,
        disabledDayColor,
        dateRangeEndsBackgroundColor,
        dateRangeBackgroundColor,
        dateRangeColor,
        dateRangeEndsRadius,
        calendarDaySize,
        buttonsColor,
        selectedYearBackgroundColor,
      );

  EasyDevCalendarThemeData copyWith({
    bool? addNextPreviousMonthButtons,
    Color? selectedMonthColor,
    Color? unselectedMonthColor,
    Color? selectedYearColor,
    Color? unselectedYearColor,
    Color? activeColor,
    Color? inactiveColor,
    Color? iconColor,
    Color? weekdayColor,
    Color? todayBorderColor,
    Color? selectedDayColor,
    Color? unselectedDayColor,
    Color? disabledDayColor,
    Color? dateRangeEndsBackgroundColor,
    Color? dateRangeBackgroundColor,
    Color? dateRangeColor,
    Color? buttonsColor,
    Color? selectedYearBackgroundColor,
    BorderRadius? dateRangeEndsRadius,
    double? calendarDaySize,
  }) =>
      EasyDevCalendarThemeData(
        addNextPreviousMonthButtons:
            addNextPreviousMonthButtons ?? this.addNextPreviousMonthButtons,
        selectedMonthColor: selectedMonthColor ?? this.selectedMonthColor,
        unselectedMonthColor: unselectedMonthColor ?? this.unselectedMonthColor,
        selectedYearColor: selectedYearColor ?? this.selectedYearColor,
        unselectedYearColor: unselectedYearColor ?? this.unselectedYearColor,
        activeColor: activeColor ?? this.activeColor,
        inactiveColor: inactiveColor ?? this.inactiveColor,
        iconColor: iconColor ?? this.iconColor,
        weekdayColor: weekdayColor ?? this.weekdayColor,
        todayBorderColor: todayBorderColor ?? this.todayBorderColor,
        selectedDayColor: selectedDayColor ?? this.selectedDayColor,
        unselectedDayColor: unselectedDayColor ?? this.unselectedDayColor,
        disabledDayColor: disabledDayColor ?? this.disabledDayColor,
        dateRangeEndsBackgroundColor:
            dateRangeEndsBackgroundColor ?? this.dateRangeEndsBackgroundColor,
        dateRangeBackgroundColor: dateRangeBackgroundColor ?? this.dateRangeBackgroundColor,
        dateRangeColor: dateRangeColor ?? this.dateRangeColor,
        dateRangeEndsRadius: dateRangeEndsRadius ?? this.dateRangeEndsRadius,
        calendarDaySize: calendarDaySize ?? this.calendarDaySize,
        buttonsColor: buttonsColor ?? this.buttonsColor,
        selectedYearBackgroundColor:
            selectedYearBackgroundColor ?? this.selectedYearBackgroundColor,
      );
}
