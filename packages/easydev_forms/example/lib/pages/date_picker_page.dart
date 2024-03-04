import 'package:easydev_forms/easydev_forms.dart';
import 'package:example_forms/widgets/page_appbar.dart';
import 'package:example_forms/widgets/widget_wrapper.dart';
import 'package:easydev_basics/easydev_basics.dart';
import 'package:flutter/widgets.dart';
import 'package:easydev_base_ui/easydev_base_ui.dart';
import 'package:intl/intl.dart';

class DatePickerPage extends StatefulWidget {
  const DatePickerPage({super.key});

  @override
  State<DatePickerPage> createState() => _DatePickerPageState();
}

class _DatePickerPageState extends State<DatePickerPage> {
  final _controller1 = TextEditingController();
  final _controller2 = TextEditingController();
  final _controller3 = TextEditingController();
  final _controller4 = TextEditingController();
  DateTime? date;

  @override
  void initState() {
    _controller3.text = '11.01.2023';
    super.initState();
    date = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return EasyDevScaffold(
      body: ListView(
        children: [
          WidgetWrapper(
            label: 'Default date input',
            child: EasyDevDateInput(
              label: 'Date of birth',
              controller: _controller1,
              error: 'Incorrect date format',
              helperText: '',
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          WidgetWrapper(
            label: 'Date input with custom separator and date format yyyyddMM',
            child: EasyDevDateInput(
              separator: '-',
              dateFormat: DateInputFormat.yyyyddMM(),
              controller: _controller2,
              error: 'Incorrect date format',
              helperText: '',
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const WidgetWrapper(
            label: 'Disabled date empty input',
            child: EasyDevDateInput(
              label: 'Enter date',
              inputState: InputState.disabled,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          WidgetWrapper(
            label: 'Disabled date filled input',
            child: EasyDevDateInput(
              inputState: InputState.disabled,
              controller: _controller3,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          WidgetWrapper(
            label: 'Default date picker',
            child: EasyDevDatePicker(
              endDate: DateTime(2050),
              initialDate: DateTime(2023),
              startDate: DateTime(1800),
              onCancelTap: () {},
              onOkTap: ((value) {
                if (value != null) {
                  _controller1.value = TextEditingValue(
                    text: DateFormat('dd.MM.yyyy').format(value),
                  );
                  _controller2.value = TextEditingValue(
                    text: DateFormat('yyyy-dd-MM').format(value),
                  );
                  _controller3.value = TextEditingValue(
                    text: DateFormat('dd.MM.yyyy').format(value),
                  );
                }
              }),
            ),
          ),
          WidgetWrapper(
            label: 'Date picker and input date picker',
            child: Column(
              children: [
                EasyDevDateInput(
                  controller: _controller4,
                  valueChanged: (value) {
                    final dateInInput = _getDate();

                    if (dateInInput != null &&
                        dateInInput.isBefore(DateTime(2050, 12, 31, 23)) &&
                        dateInInput.isAfter(DateTime(1800))) {
                      setState(() {
                        date = dateInInput;
                      });
                    }
                  },
                ),
                EasyDevDatePicker(
                  endDate: DateTime(2050, 12, 31, 23),
                  value: date,
                  startDate: DateTime(1800),
                  initialDate: date,
                  onCancelTap: () {},
                  onDateSelected: (value) {
                    setState(() {
                      date = value;
                    });
                  },
                  onOkTap: ((value) {
                    if (value != null) {
                      _controller4.value = TextEditingValue(
                        text: DateFormat('dd.MM.yyyy').format(value),
                      );
                    }
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
      appBar: const PageAppBar(
        title: 'Date pickers page',
      ),
    );
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
    super.dispose();
  }

  DateTime? _getDate() {
    try {
      return DateFormat('dd.MM.yyyy').parse(_controller4.text);
    } catch (e) {
      return null;
    }
  }
}
