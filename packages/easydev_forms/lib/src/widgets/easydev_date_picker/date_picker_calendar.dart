import 'date_picker_day.dart';
import 'date_picker_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Internal widget for displaying weeks in month.
class DatePickerCalendar extends StatelessWidget {
  const DatePickerCalendar({
    super.key,
    required this.selectedMonth,
    required this.selectedYear,
    required this.onTap,
    required this.decoration,
    this.selectedDate,
    this.showDisabledDays = true,
  });

  /// Used for returning date on day tap.
  final int selectedMonth;

  /// Used for returning date on day tap.
  final int selectedYear;

  /// Date selected by user, used for highlighting selected day.
  final DateTime? selectedDate;

  /// Callback on day selected.
  final ValueChanged<DateTime> onTap;

  /// Either calendar should show days of previous and next month, making each
  /// row 7 days long. Days of other month will be disabled for selection.
  final bool showDisabledDays;

  /// {@macro easydev_forms.widgets.easydev_date_picker.date_picker_decoration}
  final DatePickerDecoration decoration;

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          final calendarIndex = index - _getFirstDayOffset(selectedYear, selectedMonth) + 1;
          final isSelected = _checkIfSelected(calendarIndex);
          return (calendarIndex > 0) && index < _daysWithoutLastOffset
              ? GestureDetector(
                  onTap: () => onTap(
                    DateTime(
                      selectedYear,
                      selectedMonth,
                      calendarIndex,
                    ),
                  ),
                  child: DatePickerDay(
                    text: _formatDay(calendarIndex),
                    border: _checkIfToday(calendarIndex) && !isSelected
                        ? Border.all(color: decoration.todayBorderColor!)
                        : null,
                    color: isSelected ? decoration.selectedDayBackgroundColor : null,
                    style: decoration.daysTextStyle?.copyWith(
                      color:
                          isSelected ? decoration.selectedDayColor : decoration.unselectedDayColor,
                    ),
                  ),
                )
              : Container(
                  child: showDisabledDays
                      ? DatePickerDay(
                          text: _getDisabledDay(calendarIndex),
                          style: decoration.daysTextStyle?.copyWith(
                            color: decoration.disabledDayColor,
                          ),
                        )
                      : null,
                );
        },
        childCount: _numDaysInCalendar,
      ),
    );
  }

  int get _numDaysInCalendar {
    final lastDayOffset = 7 - _daysWithoutLastOffset % 7;
    return lastDayOffset == 7 ? _daysWithoutLastOffset : _daysWithoutLastOffset + lastDayOffset;
  }

  int get _daysWithoutLastOffset {
    return _daysInSelectedMonth + _getFirstDayOffset(selectedYear, selectedMonth);
  }

  int get _daysInSelectedMonth {
    return _getDaysInMonth(selectedYear, selectedMonth);
  }

  String _getDisabledDay(int index) {
    return index > 0
        ? _formatDay(index - _daysInSelectedMonth)
        : ((selectedMonth - 1 <= 0
                    ? _getDaysInMonth(selectedYear - 1, 12)
                    : _getDaysInMonth(selectedYear, selectedMonth - 1)) +
                index)
            .toString();
  }

  bool _checkIfToday(int day) {
    return DateTime.now().day == day &&
        DateTime.now().month == selectedMonth &&
        DateTime.now().year == selectedYear;
  }

  bool _checkIfSelected(int day) {
    return DateTime(selectedYear, selectedMonth, day) == selectedDate;
  }

  static int _getDaysInMonth(int year, int month) {
    if (month == DateTime.february) {
      final bool isLeapYear = (year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0);
      return isLeapYear ? 29 : 28;
    }
    const List<int> daysInMonth = [31, -1, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    return daysInMonth[month - 1];
  }

  static int _getFirstDayOffset(int year, int month) {
    final int weekdayFromMonday = DateTime(year, month).weekday - 1;

    return weekdayFromMonday % 7;
  }

  static String _formatDay(int num) {
    return num < 10 ? '0$num' : '$num';
  }
}
