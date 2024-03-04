import 'package:community_material_icon/community_material_icon.dart';
import 'package:easydev_base_ui/easydev_base_ui.dart';
import 'package:easydev_forms/easydev_forms.dart';
import 'package:easydev_forms/src/indexed_list/indexed_list.dart';
import 'package:easydev_forms/src/widgets/easydev_date_picker/date_picker_week.dart';
import 'package:easydev_forms/src/widgets/easydev_date_picker/picker_selector.dart';
import 'package:easydev_forms/src/widgets/easydev_date_range_picker/date_range_year_picker.dart';
import 'date_range_picker_month.dart';
import 'package:flutter/widgets.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart' hide TextDirection;

class EasyDevDateRangePickerContent extends StatefulWidget {
  EasyDevDateRangePickerContent({
    super.key,
    required this.startDate,
    required this.endDate,
    required this.onSelectTap,
    required this.decoration,
    this.value,
    this.initialDateRange,
    this.onDateRangeSelected,
    this.locale = 'en',
    this.formatMonth,
    this.formatWeekday,
    this.formatSelectText,
    this.showDisabledDays = true,
    this.okButtonText,
    this.cancelButtonText,
    this.controller,
  }) : assert((initialDateRange?.start.isBefore(endDate) ?? true) &&
            (initialDateRange?.end.isAfter(startDate) ?? true));

  final DateRange? initialDateRange;

  final DateTime startDate;

  final DateTime endDate;

  final ValueChanged<DateRange> onSelectTap;

  /// Locale for the displaying of months and weekdays.
  final String locale;

  final NullableDateRange? value;

  final ValueChanged<NullableDateRange>? onDateRangeSelected;

  /// Function for formatting months.
  final String Function(String)? formatMonth;

  /// Function for formatting weekdays.
  final String Function(String)? formatWeekday;

  /// Function for formatting weekdays.
  final String Function(DateTime? start, DateTime? end)? formatSelectText;

  /// Either calendar should show days of previous and next month, making each
  /// row 7 days long. Days of other months will be disabled for selection.
  final bool showDisabledDays;

  /// {@macro easydev_forms.widgets.easydev_date_picker.date_picker_decoration}
  final DatePickerDecoration decoration;

  /// Text of "OK" button, reacting on [onOkTap].
  final String? okButtonText;

  /// Text of "Cancel" button, reacting on [onCancelTap].
  final String? cancelButtonText;

  final ScrollController? controller;

  @override
  State<EasyDevDateRangePickerContent> createState() => _EasyDevDateRangePickerContentState();
}

class _EasyDevDateRangePickerContentState extends State<EasyDevDateRangePickerContent> {
  bool _showMonthPicker = false;
  bool _showYearPicker = false;
  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;
  late int selectedMonth;
  late int selectedYear;
  double monthSize = 0;
  late List<String> _monthsList;
  late List<String> _weekdaysList;
  late int initialIndex;

  late TextStyle _buttonsTextStyle;

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

    _buttonsTextStyle = theme.typography?.buttonStyle ?? const TextStyle();
  }

  @override
  void initState() {
    DateTime? currentDateStart;
    DateTime? currentDateEnd;
    if (widget.value != null) {
      currentDateStart = widget.value?.start;
      currentDateEnd = widget.value?.end;
    } else {
      currentDateStart = _selectedStartDate;
      currentDateEnd = _selectedEndDate;
    }
    _selectedStartDate = currentDateStart;
    _selectedEndDate = currentDateEnd;
    initializeDateFormatting(widget.locale);
    _monthsList = List<String>.generate(12, (int index) {
      final monthName = DateFormat.MMMM(widget.locale).format(
        DateTime(2000, index + 1),
      );
      return widget.formatMonth != null ? widget.formatMonth!(monthName) : monthName;
    });

    _weekdaysList = List<String>.generate(7, (int index) {
      final weekdayName = DateFormat.E(widget.locale).format(
        DateTime(2000, 5, index + 1),
      );
      return widget.formatWeekday != null ? widget.formatWeekday!(weekdayName) : weekdayName;
    });
    selectedMonth = widget.endDate.month;
    selectedYear = widget.endDate.year;
    initialIndex = _monthDelta(widget.initialDateRange?.end ?? DateTime.now(), widget.endDate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_showMonthPicker || _showYearPicker) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PickerSelector(
                onTap: () => setState(() {
                  _showMonthPicker = !_showMonthPicker;
                  _showYearPicker = false;
                  initialIndex = _monthDelta(
                    DateTime(selectedYear, selectedMonth),
                    widget.endDate,
                  );
                }),
                text: _monthsList[selectedMonth - 1],
                icon: !_showYearPicker ? CommunityMaterialIcons.menu_down : null,
                isActive: !_showYearPicker,
                decoration: widget.decoration,
              ),
              PickerSelector(
                onTap: () => setState(() {
                  _showYearPicker = !_showYearPicker;
                  _showMonthPicker = false;
                  initialIndex = _monthDelta(
                    DateTime(selectedYear, selectedMonth),
                    widget.endDate,
                  );
                }),
                text: selectedYear.toString(),
                icon: !_showMonthPicker ? CommunityMaterialIcons.menu_down : null,
                isActive: !_showMonthPicker,
                decoration: widget.decoration,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          if (_showMonthPicker)
            SizedBox(
              height: 270,
              child: MonthPicker(
                onTap: (index) {
                  final newDate = _placeDateBetweenBounds(DateTime(selectedYear, index + 1));
                  setState(() {
                    _showMonthPicker = false;
                    _showYearPicker = false;
                    initialIndex = _monthDelta(
                      newDate,
                      widget.endDate,
                    );
                  });
                },
                monthsList: _monthsList,
                selectedMonth: selectedMonth,
                endMonth: selectedYear == widget.endDate.year ? widget.endDate.month : 12,
                decoration: widget.decoration,
              ),
            ),
          if (_showYearPicker)
            DateRangeYearPicker(
              startYear: widget.startDate.year,
              endYear: widget.endDate.year,
              selectedYear: selectedYear,
              decoration: widget.decoration,
              onCancelTap: () => setState(() {
                _showYearPicker = false;
                _showMonthPicker = false;
              }),
              cancelButtonText: widget.cancelButtonText,
              okButtonText: widget.okButtonText,
              onOkTap: (year) {
                final newDate = _placeDateBetweenBounds(
                  DateTime(year, selectedMonth),
                );
                setState(() {
                  _showMonthPicker = false;
                  _showYearPicker = false;
                  initialIndex = _monthDelta(
                    newDate,
                    widget.endDate,
                  );
                });
              },
            ),
        ],
      );
    } else {
      return Stack(
        children: [
          // To quickly switch between years and months, a CustomScrollView is used, consisting of three SliverList.
          // The central sliver consists of one element under initialIndex. The key from the center property of
          // CustomScrollView is passed to it, so that it is visible in the initial state. Since a CustomScrollView build anew
          // when a year is selected, it is enough to change the initialIndex to change central sliver of CustomScrollView
          IndexedList(
              itemCount: _monthDelta(widget.startDate, widget.endDate) + 2,
              positionedIndex: initialIndex,
              controller: widget.controller,
              physics: const BouncingScrollPhysics(),
              reverse: true,
              itemBuilder: (context, index) {
                final date = _addMonthsToMonthDate(widget.endDate, -index);
                return Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PickerSelector(
                          onTap: () => setState(() {
                            _showMonthPicker = !_showMonthPicker;
                            _showYearPicker = false;
                            selectedMonth = date.month;
                            selectedYear = date.year;
                          }),
                          text: _monthsList[date.month - 1],
                          icon: CommunityMaterialIcons.menu_down,
                          isActive: true,
                          decoration: widget.decoration,
                        ),
                        PickerSelector(
                          onTap: () => setState(() {
                            _showYearPicker = !_showYearPicker;
                            _showMonthPicker = false;
                            selectedYear = date.year;
                            selectedMonth = date.month;
                          }),
                          text: date.year.toString(),
                          icon: CommunityMaterialIcons.menu_down,
                          isActive: true,
                          decoration: widget.decoration,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DatePickerWeek(
                      weekdaysList: _weekdaysList,
                      decoration: widget.decoration,
                    ),
                    DateRangePickerMonth(
                      month: date.month,
                      year: date.year,
                      selectedStartDate: widget.value?.start ?? _selectedStartDate,
                      selectedEndDate: widget.value?.end ?? _selectedEndDate,
                      onTap: (date) => _handleDateTapped(date),
                      showDisabledDays: widget.showDisabledDays,
                      decoration: widget.decoration,
                    ),
                    SizedBox(
                      height: index == 0 ? 60 : 30,
                    ),
                  ],
                );
              }),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 0),
              child: LayoutBuilder(builder: ((context, constraints) {
                return EasyDevButton(
                  text:
                      'Select ${_getSelectedDateRangeText(widget.value?.start ?? _selectedStartDate, widget.value?.end ?? _selectedEndDate)}',
                  textStyle: _changeTextSize(
                    'Select ${_getSelectedDateRangeText(widget.value?.start ?? _selectedStartDate, widget.value?.end ?? _selectedEndDate)}',
                    constraints.maxWidth,
                  ),
                  margin: EdgeInsets.zero,
                  disabled: (widget.value?.start == null && _selectedStartDate == null) ||
                      (widget.value?.end == null && _selectedEndDate == null),
                  onTap: () => widget.onSelectTap.call(
                    DateRange(
                      start: _selectedStartDate!,
                      end: _selectedEndDate!,
                    ),
                  ),
                );
              })),
            ),
          ),
        ],
      );
    }
  }

  static DateTime _addMonthsToMonthDate(DateTime monthDate, int monthsToAdd) {
    return DateTime(monthDate.year, monthDate.month + monthsToAdd);
  }

  static int _monthDelta(DateTime startDate, DateTime endDate) {
    return (endDate.year - startDate.year) * 12 + endDate.month - startDate.month;
  }

  String _getSelectedDateRangeText(DateTime? selectedStartDate, DateTime? selectedEndDate) {
    if (selectedStartDate != null && selectedEndDate != null) {
      final startDay = selectedStartDate.day;
      final startMonth = _monthsList[selectedStartDate.month - 1];
      final startYear = selectedStartDate.year;
      final endDay = selectedEndDate.day;
      final endMonth = _monthsList[selectedEndDate.month - 1];
      final endYear = selectedEndDate.year;

      if (startMonth == endMonth && startYear == endYear) {
        return '$startDay - $endDay $startMonth $startYear';
      } else if (startYear == endYear) {
        return '$startDay $startMonth - $endDay $endMonth $startYear';
      } else {
        return '$startDay $startMonth $startYear - $endDay $endMonth $endYear';
      }
    } else {
      return '';
    }
  }

  void _handleDateTapped(DateTime date) {
    DateTime? currentDateStart;
    DateTime? currentDateEnd;
    if (widget.value != null) {
      currentDateStart = widget.value?.start;
      currentDateEnd = widget.value?.end;
    } else {
      currentDateStart = _selectedStartDate;
      currentDateEnd = _selectedEndDate;
    }

    if (currentDateEnd != null && currentDateStart != null) {
      if (date.isAtSameMomentAs(currentDateEnd)) {
        setState(() {
          _selectedEndDate = null;
        });
      } else if (date.isAtSameMomentAs(currentDateStart)) {
        setState(() {
          _selectedStartDate = currentDateEnd;
          _selectedEndDate = null;
        });
      } else {
        setState(() {
          _selectedStartDate = date;
          _selectedEndDate = null;
        });
      }
    } else if (currentDateStart != null) {
      if (date.isBefore(currentDateStart)) {
        setState(() {
          _selectedEndDate = currentDateStart;
          _selectedStartDate = date;
        });
      } else if (date.isAtSameMomentAs(currentDateStart)) {
        setState(() {
          _selectedStartDate = null;
        });
      } else {
        setState(() {
          _selectedEndDate = date;
        });
      }
    } else {
      setState(() {
        _selectedStartDate = date;
      });
    }

    widget.onDateRangeSelected?.call(
      NullableDateRange(
        start: _selectedStartDate,
        end: _selectedEndDate,
      ),
    );
  }

  DateTime _placeDateBetweenBounds(DateTime date) {
    if (date.isAfter(widget.endDate)) return widget.endDate;
    if (date.isBefore(widget.startDate)) return widget.startDate;
    return date;
  }

  TextStyle? _changeTextSize(
    String text,
    double maxWidth,
  ) {
    double textWidth = _getTextWidth(
      text,
      _buttonsTextStyle,
    );
    TextStyle? textStyle = _buttonsTextStyle;
    if (textWidth > maxWidth - 64) {
      while (textWidth > maxWidth - 64) {
        textStyle = textStyle?.copyWith(fontSize: (textStyle.fontSize ?? 18) - 1);
        textWidth = _getTextWidth(text, textStyle);
      }
    }
    return textStyle;
  }

  double _getTextWidth(String text, TextStyle? style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout();
    return textPainter.size.width;
  }
}
