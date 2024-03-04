import 'package:easydev_forms/easydev_forms.dart';
import 'package:flutter/services.dart';

/// {@macro flutter.widgets.editableText.inputFormatters}
/// [TextInputFormatter] for [EasyDevDateInput] and [EasyDevDateRangeInput], that format
/// values and validates date with [validateDate] callback. [separator] is symbol that
/// separates day, month and year. [validateDate].
class DateFormatter extends TextInputFormatter {
  final bool startsFromYear;
  final String separator;
  final ValueChanged<String> validateDate;

  DateFormatter({
    required this.startsFromYear,
    required this.separator,
    required this.validateDate,
  });

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final dateRegExp = RegExp('^[0-9]*[$separator]?[0-9]*[$separator]?[0-9]*\$');

    if (dateRegExp.matchAsPrefix(newValue.text) == null) return oldValue;

    final valueWithoutSeparator = newValue.text.replaceAll(separator, '');
    final valueWithSeparator = startsFromYear
        ? _addSeparator(valueWithoutSeparator, [4, 6])
        : _addSeparator(valueWithoutSeparator, [2, 4]);

    if (valueWithSeparator.length > 10) return oldValue;

    if (valueWithSeparator.length == 10) {
      validateDate(valueWithSeparator);
    }
    if (valueWithSeparator.length - oldValue.text.length == 2) {
      return TextEditingValue(
        text: valueWithSeparator,
        selection: TextSelection.collapsed(offset: newValue.selection.end + 1),
      );
    } else if (valueWithSeparator.length - oldValue.text.length == -2) {
      return TextEditingValue(
        text: valueWithSeparator,
        selection: TextSelection.collapsed(offset: newValue.selection.end - 1),
      );
    } else {
      return TextEditingValue(
        text: valueWithSeparator,
        selection: TextSelection.collapsed(offset: newValue.selection.end),
      );
    }
  }

  String _addSeparator(String s, List<int> separators) {
    String valueWithSeparator = "";

    int j = 0;

    for (int i = 0; i < s.length; i++) {
      if (j < separators.length && i == separators[j]) {
        valueWithSeparator += separator;
        j++;
      }
      valueWithSeparator += s[i];
    }

    return valueWithSeparator;
  }
}
