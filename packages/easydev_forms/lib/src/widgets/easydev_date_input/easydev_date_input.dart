import 'package:easydev_base_ui/easydev_base_ui.dart';
import 'package:easydev_forms/easydev_forms.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart' hide TextDirection;

/// [EasyDevDateInput] is text field, that can format date and shows disabled [inputState], when
/// receive incorrect date. [separator] is field that helps split date to day,month and year.
/// Other field provides additional features, that is provided by [EasyDevTextField].
/// Value received in [valueChanged], is provided in String type, so it need to be parsed when value
/// received.
///
///
/// Example of using [EasyDevDateInput].
/// ```dart
/// EasyDevDateInput(
///  separator: '-',
///  dateFormat: DateInputFormat.yyyyddMM(),
///  valueChanged: (value){
///    ...
///  }
/// ),
/// ```
///
///
/// This sample shows app with [EasyDevDateInput].
///
/// See code in example/lib/pages/examples/date_input_example.dart
///
/// See also:
///
///  * [EasyDevDatePicker], date picker widget.
///  * [EasyDevDateRangeInput], inputs for date range.
class EasyDevDateInput extends StatefulWidget {
  /// Create a date text field.
  const EasyDevDateInput({
    super.key,
    this.valueChanged,
    this.separator = '.',
    this.dateFormat,
    this.label,
    this.helperText,
    this.error,
    this.inputState = InputState.enabled,
    this.decoration = const EasyDevInputDecoration(),
    this.textDirection = TextDirection.ltr,
    this.textAlign = TextAlign.start,
    this.controller,
  }) : assert(separator.length == 1);

  /// Callback called on changing value
  final ValueChanged<String>? valueChanged;

  /// Day, month and year separator
  final String separator;

  /// Format of date e.g. ddMMyyyy, yyyyMMdd.
  /// Default to ddMMyyyy
  final DateInputFormat? dateFormat;

  /// {@macro flutter.widgets.editable_text.textEditingController}
  /// Controls the text being edited.
  ///
  /// If null, this widget will create its own [TextEditingController].
  final TextEditingController? controller;

  /// Label that floats when text is selected
  final String? label;

  /// Helper text under text field
  final String? helperText;

  /// {@macro easydev_base_ui.widgets.text_field.enums.input_state}
  /// Error text is shown instead of [helperText] when [inputState] is [InputState.error]
  final String? error;

  /// {@macro dart.ui}
  final TextDirection textDirection;

  /// {@macro flutter.widgets.editableText.textAlign}
  final TextAlign textAlign;

  /// {@macro easydev_base_ui.widgets.text_field.enums.input_state}
  /// [InputState] enum provides you room for customization, when you need
  /// to implement different text field use cases. They have different
  /// customisation
  /// [InputState.enable] is focusable text field
  /// [InputState.disabled] disables text field
  /// [InputState.error] show [error] instead of [helperText] when [error] is provided
  /// other [InputState] value just change decoration of text field
  final InputState inputState;

  /// [decoration] provides ability to change textField apperance, such as color,
  /// textStyles, and border appearance
  final EasyDevInputDecoration decoration;

  @override
  State<EasyDevDateInput> createState() => _EasyDevDateInputState();
}

class _EasyDevDateInputState extends State<EasyDevDateInput> {
  late DateInputFormat _dateFormat;
  late bool _startsFromYear;
  late InputState _inputState;
  late String _dateMask;
  late TextStyle _floatingLabelTextStyle;
  late Color _focusedColor;
  late Color _filledColor;
  late Color _disabledColor;

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

    _floatingLabelTextStyle = widget.decoration.floatingLabelStyle ??
        (theme.brightness == Brightness.light
            ? (theme.typography?.captionStyle?.copyWith(
                    color: colorPalette.secondarySwatch?[400] ?? colorPalette.primarySwatch) ??
                const TextStyle())
            : (theme.typography?.captionStyle?.copyWith(
                    color: colorPalette.tertiarySwatch?[300] ?? colorPalette.primarySwatch) ??
                const TextStyle()));

    _focusedColor = widget.decoration.focusedColor ??
        (theme.brightness == Brightness.light
            ? (colorPalette.secondarySwatch?[300] ?? colorPalette.primarySwatch)
            : colorPalette.secondarySwatch?[500] ?? colorPalette.primarySwatch);
    _filledColor = widget.decoration.filledColor ??
        (theme.brightness == Brightness.light
            ? (colorPalette.greySwatch.disabledColor ?? colorPalette.greySwatch.surfaceColor)
            : colorPalette.secondarySwatch?[500] ?? colorPalette.primarySwatch);
    _disabledColor = widget.decoration.disabledColor ??
        (theme.brightness == Brightness.light
            ? (colorPalette.greySwatch.disabledColor ?? colorPalette.greySwatch.surfaceColor)
            : colorPalette.greySwatch.tappedSurfaceColor ?? colorPalette.primarySwatch);
    _dateFormat = widget.dateFormat ?? DateInputFormat.ddMMyyyy();
    _startsFromYear = _dateFormat.format[0] == 'y';
    _inputState = widget.inputState;
    _dateMask = _startsFromYear
        ? _addSeparator(_dateFormat.format, [4, 6])
        : _addSeparator(_dateFormat.format, [2, 4]);
  }

  @override
  Widget build(BuildContext context) {
    return EasyDevTextField(
      valueChanged: widget.valueChanged,
      label: widget.label,
      helperText: widget.helperText,
      error: widget.error,
      inputState: _inputState,
      textAlign: widget.textAlign,
      textDirection: widget.textDirection,
      controller: widget.controller,
      inputFormatters: [
        DateFormatter(
          startsFromYear: _startsFromYear,
          separator: widget.separator,
          validateDate: (value) => _validateDate(_dateMask, value),
        )
      ],
      maxLength: 10,
      textInputType: TextInputType.number,
      decoration: widget.decoration.copyWith(
        floatingLabelStyle: _floatingLabelTextStyle,
        focusedColor: _focusedColor,
        filledColor: _filledColor,
        disabledColor: _disabledColor,
      ),
    );
  }

  void _validateDate(String dateMask, String value) {
    try {
      DateFormat(dateMask).parseStrict(value);
      setState(() {
        _inputState = widget.inputState;
      });
    } on FormatException {
      setState(() {
        _inputState = InputState.error;
      });
    }
  }

  String _addSeparator(String s, List<int> separators) {
    String valueWithSeparator = "";

    int j = 0;

    for (int i = 0; i < s.length; i++) {
      if (j < separators.length && i == separators[j]) {
        valueWithSeparator += widget.separator;
        j++;
      }
      valueWithSeparator += s[i];
    }

    return valueWithSeparator;
  }
}
