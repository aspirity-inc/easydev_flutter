import 'package:community_material_icon/community_material_icon.dart';
import 'package:easydev_base_ui/easydev_base_ui.dart';
import 'package:easydev_forms/src/widgets/easydev_date_picker/date_picker_calendar.dart';
import 'package:easydev_forms/src/widgets/easydev_date_picker/picker_selector.dart';
import 'package:easydev_forms/src/widgets/easydev_date_picker/year_picker.dart';
import 'date_picker_decoration.dart';
import 'date_picker_week.dart';
import 'month_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

/// Internal widget that displays Date picker, have two picker selections on top.
/// With this pickers user can change month and year of selected date.
/// Below pickers will be placed [YearPicker], [MonthPicker] or [DatePickerCalendar] depending
/// what parts of date user is selected.
/// And on bottom of widget there are two buttons that react [onOkTap] and [onCancelTap] callbacks.
class EasyDevDatePickerContent extends StatefulWidget {
  EasyDevDatePickerContent({
    super.key,
    required this.startDate,
    required this.endDate,
    required this.onCancelTap,
    required this.onOkTap,
    required this.decoration,
    this.locale = 'en',
    this.onDateSelected,
    this.initialDate,
    this.value,
    this.formatMonth,
    this.formatWeekday,
    this.showDisabledDays = true,
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

  /// Function for formatting month.
  final String Function(String)? formatMonth;

  /// Function for formatting weekdays.
  final String Function(String)? formatWeekday;

  /// Callback on user selecting date, can be used to show selecting date somewhere else.
  final ValueChanged<DateTime>? onDateSelected;

  /// Callback on "Ok" button tap.
  final ValueChanged<DateTime?> onOkTap;

  /// Currently selected value of widget.
  final DateTime? value;

  /// Callback on "Cancel" button tap.
  final VoidCallback onCancelTap;

  /// Either calendar should show days of previous and next month, making each
  /// row 7 days long. Days of other months will be disabled for selection.
  final bool showDisabledDays;

  /// {@macro easydev_forms.widgets.easydev_date_picker.date_picker_decoration}
  final DatePickerDecoration decoration;

  /// Text of "OK" button, reacting on [onOkTap].
  final String? okButtonText;

  /// Text of "Cancel" button, reacting on [onCancelTap].
  final String? cancelButtonText;

  @override
  State<EasyDevDatePickerContent> createState() => _EasyDevDatePickerContentState();
}

class _EasyDevDatePickerContentState extends State<EasyDevDatePickerContent> {
  bool _showMonthPicker = false;
  bool _showYearPicker = false;
  late DateTime? _selectedDate;
  late int _selectedMonth;
  late int _selectedYear;
  late List<String> _monthsList;
  late List<String> _weekdaysList;

  @override
  void initState() {
    _selectedDate = widget.initialDate != null
        ? DateTime(
            widget.initialDate!.year,
            widget.initialDate!.month,
            widget.initialDate!.day,
          )
        : null;
    _selectedMonth = widget.initialDate?.month ?? widget.endDate.month;
    _selectedYear = widget.initialDate?.year ?? widget.endDate.year;
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PickerSelector(
              onTap: () => setState(() {
                _showMonthPicker = !_showMonthPicker;
                _showYearPicker = false;
              }),
              text: _monthsList[(widget.value?.month ?? _selectedMonth) - 1],
              icon: !_showYearPicker ? CommunityMaterialIcons.menu_down : null,
              isActive: !_showYearPicker,
              decoration: widget.decoration,
            ),
            PickerSelector(
              onTap: () => setState(() {
                _showYearPicker = !_showYearPicker;
                _showMonthPicker = false;
              }),
              text: (widget.value?.year ?? _selectedYear).toString(),
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
            height: 280,
            child: MonthPicker(
              onTap: (index) {
                setState(() {
                  _showMonthPicker = false;
                  _showYearPicker = false;
                  _selectedMonth = index + 1;
                });
              },
              monthsList: _monthsList,
              selectedMonth: widget.value?.month ?? _selectedMonth,
              endMonth: _selectedYear == widget.endDate.year ? widget.endDate.month : 12,
              decoration: widget.decoration,
            ),
          ),
        if (_showYearPicker)
          SizedBox(
            height: 280,
            child: YearPicker(
              startYear: widget.startDate.year,
              endYear: widget.endDate.year,
              onTap: (index) {
                setState(() {
                  _showMonthPicker = false;
                  _showYearPicker = false;
                  _selectedYear = widget.endDate.year - index;
                });
              },
              selectedYear: widget.value?.year ?? _selectedYear,
              decoration: widget.decoration,
            ),
          ),
        if (!_showMonthPicker && !_showYearPicker) ...[
          DatePickerWeek(
            weekdaysList: _weekdaysList,
            decoration: widget.decoration,
          ),
          CustomScrollView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            slivers: [
              DatePickerCalendar(
                selectedMonth: widget.value?.month ?? _selectedMonth,
                selectedYear: widget.value?.year ?? _selectedYear,
                selectedDate: widget.value ?? _selectedDate,
                onTap: (date) => setState(() {
                  _selectedDate = date;
                  widget.onDateSelected?.call(date);
                }),
                decoration: widget.decoration,
                showDisabledDays: widget.showDisabledDays,
              ),
              SliverPadding(
                padding: const EdgeInsets.only(top: 12),
                sliver: SliverToBoxAdapter(
                  child: Row(
                    children: [
                      const Spacer(),
                      EasyDevButton.text(
                        onTap: widget.onCancelTap,
                        text: widget.cancelButtonText ?? 'Cancel',
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      EasyDevButton.text(
                        onTap: () => widget.onOkTap(_selectedDate),
                        text: widget.okButtonText ?? 'Ok',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ]
      ],
    );
  }
}
