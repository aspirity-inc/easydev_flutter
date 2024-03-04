import 'package:easydev_forms/easydev_forms.dart';
import 'package:example_forms/widgets/page_appbar.dart';
import 'package:example_forms/widgets/widget_wrapper.dart';
import 'package:easydev_basics/easydev_basics.dart';
import 'package:flutter/widgets.dart';
import 'package:easydev_base_ui/easydev_base_ui.dart';
import 'package:intl/intl.dart';

class DateRangePickerPage extends StatefulWidget {
  const DateRangePickerPage({super.key});

  @override
  State<DateRangePickerPage> createState() => _DateRangePickerPageState();
}

class _DateRangePickerPageState extends State<DateRangePickerPage> {
  DateRange? dateRange1;
  NullableDateRange? dateRange2;
  final _startController1 = TextEditingController();
  final _endController1 = TextEditingController();
  final _startController2 = TextEditingController();
  final _endController2 = TextEditingController();
  final _startController3 = TextEditingController();
  final _endController3 = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    _startController2.text = '11.01.2023';
    _endController2.text = '11.01.2024';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return EasyDevScaffold(
      body: ListView(
        children: [
          WidgetWrapper(
            label: 'Default date range input',
            child: EasyDevDateRangeInput(
              startLabel: 'Start date',
              endLabel: 'End date',
              startController: _startController1,
              endController: _endController1,
              startError: 'Invalid date',
              endError: 'Invalid date',
              startHelperText: '',
              endHelperText: '',
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const WidgetWrapper(
            label: 'Disabled date range empty input',
            child: EasyDevDateRangeInput(
              startLabel: 'Start date',
              endLabel: 'End date',
              startInputState: InputState.disabled,
              endInputState: InputState.disabled,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          WidgetWrapper(
            label: 'Disabled date filled input',
            child: EasyDevDateRangeInput(
              startController: _startController2,
              endController: _endController2,
              startInputState: InputState.disabled,
              endInputState: InputState.disabled,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          WidgetWrapper(
            label: 'Default date range picker',
            child: SizedBox(
              height: 430,
              child: EasyDevDateRangePicker(
                endDate: DateTime(2024, 12),
                startDate: DateTime(1800),
                onSelectTap: (value) {
                  setState(() {
                    dateRange1 = DateRange(start: value.start, end: value.end);
                    _startController1.value = TextEditingValue(
                      text: DateFormat('dd.MM.yyyy').format(value.start),
                    );
                    _endController1.value = TextEditingValue(
                      text: DateFormat('dd.MM.yyyy').format(value.end),
                    );
                    _startController2.value = TextEditingValue(
                      text: DateFormat('dd.MM.yyyy').format(value.start),
                    );
                    _endController2.value = TextEditingValue(
                      text: DateFormat('dd.MM.yyyy').format(value.end),
                    );
                  });
                },
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          WidgetWrapper(
            label: 'Date range picker and input date range picker',
            child: Column(
              children: [
                EasyDevDateRangeInput(
                  startController: _startController3,
                  endController: _endController3,
                  startValueChanged: (value) {
                    final dateInInput = _getRangeDate2();

                    if (dateInInput != null &&
                        (dateInInput.start?.isBefore(DateTime(2025, 12, 31, 23)) ?? false) &&
                        (dateInInput.end?.isBefore(DateTime(2025, 12, 31, 23)) ?? false) &&
                        (dateInInput.start?.isAfter(DateTime(2023, 2)) ?? false) &&
                        (dateInInput.end?.isAfter(DateTime(2023, 2)) ?? false)) {
                      setState(() {
                        dateRange2 = dateInInput;
                      });
                      if (dateInInput.start != null) {
                        _scrollController.jumpTo(_calculateOffset(dateInInput.start!));
                      }
                    }
                  },
                  endValueChanged: (value) {
                    final dateInInput = _getRangeDate2();

                    if (dateInInput != null &&
                        (dateInInput.start?.isBefore(DateTime(2025, 12, 31, 23)) ?? false) &&
                        (dateInInput.end?.isBefore(DateTime(2025, 12, 31, 23)) ?? false) &&
                        (dateInInput.start?.isAfter(DateTime(2023, 2)) ?? false) &&
                        (dateInInput.end?.isAfter(DateTime(2023, 2)) ?? false)) {
                      setState(() {
                        dateRange2 = dateInInput;
                      });
                      if (dateInInput.start != null) {
                        _scrollController.jumpTo(_calculateOffset(dateInInput.start!));
                      }
                    }
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                SizedBox(
                  height: 430,
                  child: EasyDevDateRangePicker(
                    endDate: DateTime(2025, 12, 31, 23),
                    startDate: DateTime(2023, 2),
                    value: dateRange2,
                    controller: _scrollController,
                    onDateRangeSelected: (value) {
                      setState(() {
                        dateRange2 = value;
                      });
                    },
                    onSelectTap: ((value) {
                      _startController3.value = TextEditingValue(
                        text: DateFormat('dd.MM.yyyy').format(value.start),
                      );
                      _endController3.value = TextEditingValue(
                        text: DateFormat('dd.MM.yyyy').format(value.end),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      appBar: const PageAppBar(
        title: 'Date range pickers page',
      ),
    );
  }

  @override
  void dispose() {
    _startController1.dispose();
    _startController2.dispose();
    _startController3.dispose();
    _endController1.dispose();
    _endController2.dispose();
    _endController3.dispose();
    super.dispose();
  }

  NullableDateRange? _getRangeDate2() {
    try {
      return NullableDateRange(
        start: DateFormat('dd.MM.yyyy').parse(_startController3.text),
        end: DateFormat('dd.MM.yyyy').parse(_endController3.text),
      );
    } catch (e) {
      return null;
    }
  }

  double _calculateOffset(DateTime startDate) {
    final diffInMonths = monthDelta(DateTime.now(), startDate);

    return (-diffInMonths * 280 + (-diffInMonths ~/ 2) * 200).toDouble();
  }

  static int monthDelta(DateTime startDate, DateTime endDate) {
    return (endDate.year - startDate.year) * 12 + endDate.month - startDate.month;
  }
}
