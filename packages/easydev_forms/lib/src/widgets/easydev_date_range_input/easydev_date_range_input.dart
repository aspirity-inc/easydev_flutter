import 'package:easydev_base_ui/easydev_base_ui.dart';
import 'package:easydev_forms/src/widgets/easydev_date_input/date_input_format.dart';
import '../easydev_date_input/date_formatter.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart' hide TextDirection;

/// [EasyDevDateRangeInput] is column containing two text field, for entering date ranges
/// that can format dates and shows disabled [inputState], when
/// receive incorrect date. [separator] is field that helps split date to day,month and year.
/// Other field provides additional features, that is provided by [EasyDevTextField].
/// Values received in callbacks, are provided in String type, so they need to be parsed when value
/// received.
///
///
/// Example of using [EasyDevDateRangeInput].
/// ```dart
///  EasyDevDateRangeInput(
///   startValueChanged: (value){
///    ...
///   },
///   endValueChanged: (value){
///    ...
///   },
///  ),
/// ```
///
///
/// This sample shows app with [EasyDevDatePicker].
///
/// See code in example/lib/pages/examples/date_range_input_example.dart
///
/// See also:
///
///  * [EasyDevDateInput], input field used for inputting date.
///  * [EasyDevDateRangePicker], picker for picking date ranges.
class EasyDevDateRangeInput extends StatefulWidget {
  /// Create a date range input.
  const EasyDevDateRangeInput({
    super.key,
    this.startValueChanged,
    this.endValueChanged,
    this.separator = '.',
    this.dateFormat,
    this.startController,
    this.endController,
    this.startLabel,
    this.endLabel,
    this.startHelperText,
    this.endHelperText,
    this.startError,
    this.endError,
    this.startInputState = InputState.enabled,
    this.endInputState = InputState.enabled,
    this.textDirection = TextDirection.ltr,
    this.textAlign = TextAlign.start,
    this.decoration = const EasyDevInputDecoration(),
  }) : assert(separator.length == 1);

  /// Callback called on changing start value
  final ValueChanged<String>? startValueChanged;

  /// Callback called on changing end value
  final ValueChanged<String>? endValueChanged;

  /// Day, month and year separator
  final String separator;

  /// Format of date e.g. ddMMyyyy, yyyyMMdd.
  final DateInputFormat? dateFormat;

  /// Controller for first text field
  final TextEditingController? startController;

  /// Controller for second text field
  final TextEditingController? endController;

  /// Start label that floats when text is selected
  final String? startLabel;

  /// End label that floats when text is selected
  final String? endLabel;

  /// Start helper text under text field
  final String? startHelperText;

  /// End helper text under text field
  final String? endHelperText;

  /// {@macro easydev_base_ui.widgets.text_field.enums.input_state}
  /// Error text is shown instead of [helperText] when [inputState] is [InputState.error]
  final String? startError;

  /// {@macro easydev_base_ui.widgets.text_field.enums.input_state}
  /// Error text is shown instead of [helperText] when [inputState] is [InputState.error]
  final String? endError;

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
  final InputState startInputState;

  /// {@macro easydev_base_ui.widgets.text_field.enums.input_state}
  /// [InputState] enum provides you room for customization, when you need
  /// to implement different text field use cases. They have different
  /// customisation
  /// [InputState.enable] is focusable text field
  /// [InputState.disabled] disables text field
  /// [InputState.error] show [error] instead of [helperText] when [error] is provided
  /// other [InputState] value just change decoration of text field
  final InputState endInputState;

  /// [decoration] provides ability to change textField apperance, such as color,
  /// textStyles, and border appearance
  final EasyDevInputDecoration decoration;

  @override
  State<EasyDevDateRangeInput> createState() => _EasyDevDateRangeInputState();
}

class _EasyDevDateRangeInputState extends State<EasyDevDateRangeInput> {
  late DateInputFormat _dateFormat;
  late bool _startsFromYear;
  late InputState _startInputState;
  late InputState _endInputState;
  late String _dateMask;
  late TextStyle _floatingLabelTextStyle;
  late Color _focusedColor;
  late Color _filledColor;
  late Color _bothFilledColor;
  late Color _disabledColor;

  final _focusStart = FocusNode();
  final _focusEnd = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _focusStart.dispose();
    _focusEnd.dispose();
  }

  @override
  void initState() {
    super.initState();
    _focusStart.addListener(() {
      setState(() {});
    });
    _focusEnd.addListener(() {
      setState(() {});
    });
  }

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
            ? (colorPalette.secondarySwatch?[600] ?? colorPalette.primarySwatch)
            : colorPalette.secondarySwatch?[500] ?? colorPalette.primarySwatch);
    _filledColor = widget.decoration.filledColor ??
        (theme.brightness == Brightness.light
            ? (colorPalette.greySwatch.disabledColor ?? colorPalette.greySwatch.surfaceColor)
            : colorPalette.secondarySwatch?[200] ?? colorPalette.primarySwatch);
    _bothFilledColor = widget.decoration.filledColor ??
        (theme.brightness == Brightness.light
            ? (colorPalette.secondarySwatch?[200] ?? colorPalette.primarySwatch)
            : colorPalette.secondarySwatch?[200] ?? colorPalette.primarySwatch);
    _disabledColor = widget.decoration.disabledColor ??
        (theme.brightness == Brightness.light
            ? (colorPalette.greySwatch.disabledColor ?? colorPalette.greySwatch.surfaceColor)
            : colorPalette.greySwatch.tappedSurfaceColor ?? colorPalette.primarySwatch);

    _dateFormat = widget.dateFormat ?? DateInputFormat.ddMMyyyy();
    _startsFromYear = _dateFormat.format[0] == 'y';
    _startInputState = widget.startInputState;
    _endInputState = widget.endInputState;
    _dateMask = _startsFromYear
        ? _addSeparator(_dateFormat.format, [4, 6])
        : _addSeparator(_dateFormat.format, [2, 4]);
  }

  DateTime? _startDate;
  DateTime? _endDate;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: EasyDevTextField(
            focusNode: _focusStart,
            valueChanged: widget.startValueChanged,
            label: widget.startLabel,
            helperText: widget.startHelperText,
            error: widget.startError,
            inputState: _startInputState,
            controller: widget.startController,
            textAlign: widget.textAlign,
            textDirection: widget.textDirection,
            inputFormatters: [
              DateFormatter(
                startsFromYear: _startsFromYear,
                separator: widget.separator,
                validateDate: (value) => _validateDate(_dateMask, value, true),
              )
            ],
            maxLength: 10,
            textInputType: TextInputType.number,
            decoration: widget.decoration.copyWith(
              floatingLabelStyle: _floatingLabelTextStyle,
              focusedColor: _focusedColor,
              filledColor: _focusEnd.hasFocus ? _filledColor : _bothFilledColor,
              disabledColor: _disabledColor,
            ),
          ),
        ),
        Expanded(
          child: EasyDevTextField(
            focusNode: _focusEnd,
            valueChanged: widget.endValueChanged,
            label: widget.endLabel,
            helperText: widget.endHelperText,
            error: widget.endError,
            inputState: _endInputState,
            controller: widget.endController,
            textAlign: widget.textAlign,
            textDirection: widget.textDirection,
            inputFormatters: [
              DateFormatter(
                startsFromYear: _startsFromYear,
                separator: widget.separator,
                validateDate: (value) => _validateDate(_dateMask, value, false),
              )
            ],
            maxLength: 10,
            textInputType: TextInputType.number,
            decoration: widget.decoration.copyWith(
              floatingLabelStyle: _floatingLabelTextStyle,
              focusedColor: _focusedColor,
              filledColor: _focusStart.hasFocus ? _filledColor : _bothFilledColor,
              disabledColor: _disabledColor,
            ),
          ),
        ),
      ],
    );
  }

  void _validateDate(String dateMask, String value, bool isStart) {
    try {
      final date = DateFormat(dateMask).parseStrict(value);
      isStart
          ? setState(() {
              _startDate = date;
            })
          : setState(() {
              _endDate = date;
            });
      setState(() {
        _startInputState = _endDate != null
            ? (date.isAfter(_endDate!) ? InputState.error : widget.startInputState)
            : widget.startInputState;
        _endInputState = _startDate != null
            ? (date.isBefore(_startDate!) ? InputState.error : widget.endInputState)
            : widget.endInputState;
      });
    } on FormatException {
      setState(() {
        if (isStart) {
          _startInputState = InputState.error;
        } else {
          _endInputState = InputState.error;
        }
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
