import 'package:easydev_forms/easydev_forms.dart';
import 'package:easydev_forms/src/widgets/easydev_date_picker/date_picker_day.dart';
import 'package:flutter/widgets.dart';

/// [DateRangePickerMonth] is internal widget, that used in [EasyDevDateRangePicker]
/// to pick start and end month of [DateRange].
class DateRangePickerMonth extends StatelessWidget {
  const DateRangePickerMonth({
    super.key,
    required this.month,
    required this.year,
    required this.onTap,
    required this.decoration,
    this.selectedStartDate,
    this.selectedEndDate,
    this.showDisabledDays = true,
  });

  /// Currently selected month.
  final int month;

  /// Currently selected year.
  final int year;

  /// Start of currently selected [DateRange].
  final DateTime? selectedStartDate;

  /// End of currently selected [DateRange].
  final DateTime? selectedEndDate;

  /// Callback on day selected.
  final ValueChanged<DateTime> onTap;

  /// Either calendar should show days of previous and next month, making each
  /// row 7 days long. Days of other months will be disabled for selection.
  final bool showDisabledDays;

  /// {@macro easydev_forms.widgets.easydev_date_picker.date_picker_decoration}
  final DatePickerDecoration decoration;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 1,
      ),
      itemCount: _numDaysInCalendar,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        final calendarIndex = index - _getFirstDayOffset(year, month) + 1;
        final date = DateTime(year, month, calendarIndex);
        return (calendarIndex > 0) && index < _daysWithoutLastOffset
            ? GestureDetector(
                onTap: () => onTap(date),
                child: DatePickerDay(
                  text: _formatDay(calendarIndex),
                  border: _needTodayBorder(date)
                      ? Border.all(color: decoration.todayBorderColor!)
                      : null,
                  borderRadius: _dayOnEndRange(date) ? decoration.selectedDayBorderRadius : null,
                  color: _getBackgroundColor(date),
                  style: decoration.daysTextStyle?.copyWith(
                    color: _getTextColor(date),
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
    );
  }

  int get _numDaysInCalendar {
    final lastDayOffset = 7 - _daysWithoutLastOffset % 7;
    return lastDayOffset == 7 ? _daysWithoutLastOffset : _daysWithoutLastOffset + lastDayOffset;
  }

  int get _daysWithoutLastOffset {
    return _daysInSelectedMonth + _getFirstDayOffset(year, month);
  }

  int get _daysInSelectedMonth {
    return _getDaysInMonth(year, month);
  }

  String _getDisabledDay(int index) {
    return index > 0
        ? _formatDay(index - _daysInSelectedMonth)
        : ((month - 1 <= 0 ? _getDaysInMonth(year - 1, 12) : _getDaysInMonth(year, month - 1)) +
                index)
            .toString();
  }

  bool _needTodayBorder(DateTime date) {
    return DateTime.now().day == date.day &&
        DateTime.now().month == date.month &&
        DateTime.now().year == date.year &&
        !_dayInSelectedRange(date);
  }

  bool _dayInSelectedRange(DateTime date) {
    if (selectedStartDate == null) {
      return false;
    } else if (selectedEndDate == null) {
      return date == selectedStartDate;
    } else {
      return date.isAfter(selectedStartDate!) && date.isBefore(selectedEndDate!) ||
          _dayOnEndRange(date);
    }
  }

  bool _dayOnEndRange(DateTime date) {
    return date == selectedStartDate || date == selectedEndDate;
  }

  Color? _getBackgroundColor(DateTime date) {
    if (date == selectedStartDate || date == selectedEndDate) {
      return decoration.selectedDayBackgroundColor;
    } else if (date.isBefore(selectedEndDate ?? date) && date.isAfter(selectedStartDate ?? date)) {
      return decoration.dayInSelectedIntervalBackgroundColor;
    }
    return null;
  }

  Color? _getTextColor(DateTime date) {
    if (date == selectedStartDate || date == selectedEndDate) {
      return decoration.selectedDayColor;
    } else if (date.isBefore(selectedEndDate ?? date) && date.isAfter(selectedStartDate ?? date)) {
      return decoration.dayInSelectedIntervalColor;
    }
    return decoration.unselectedDayColor;
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
