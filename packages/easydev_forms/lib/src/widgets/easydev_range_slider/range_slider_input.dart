import 'package:easydev_base_ui/easydev_base_ui.dart';
import 'package:easydev_forms/easydev_forms.dart';
import 'package:easydev_theme/easydev_theme.dart';

import 'package:flutter/widgets.dart';

/// Internal widget that is placed in [EasyDevRangeSlider] that contains two [EasyDevTextField].
/// That provides a way to change [EasyDevRangeSlider] values by using inputs.
class RangeSliderInput extends StatefulWidget {
  const RangeSliderInput({
    super.key,
    required this.min,
    required this.max,
    required this.currentValue,
    required this.onStartChanged,
    required this.onEndChanged,
    required this.formatValue,
    this.minimalRange,
    this.startController,
    this.endController,
  });

  final double min;
  final double max;
  final RangeValue currentValue;
  final ValueChanged<double?> onStartChanged;
  final ValueChanged<double?> onEndChanged;
  final double? minimalRange;
  final TextEditingController? startController;
  final TextEditingController? endController;
  final String Function(double) formatValue;

  @override
  State<RangeSliderInput> createState() => _RangeSliderInputState();
}

class _RangeSliderInputState extends State<RangeSliderInput> {
  @override
  Widget build(BuildContext context) {
    final theme = EasyDevTheme.of(context);
    return Row(
      children: [
        Expanded(
          child: EasyDevTextField(
            controller: widget.startController,
            textInputType: TextInputType.number,
            valueChanged: (value) {
              setState(() {});
              widget.onStartChanged(_setValue(value, true));
            },
            inputState: _validateInputValue(widget.startController?.text, true)
                ? InputState.enabled
                : InputState.error,
            decoration: EasyDevInputDecoration(
              margin: EdgeInsets.zero,
              height: 36,
              backgroundColor: theme.brightness == Brightness.light
                  ? theme.colorPalette.greySwatch.tappedSurfaceColor
                  : theme.colorPalette.greySwatch.disabledColor,
              focusedColor: theme.brightness == Brightness.light
                  ? theme.colorPalette.greySwatch.tappedSurfaceColor
                  : theme.colorPalette.greySwatch.disabledColor,
              unfocusedColor: theme.brightness == Brightness.light
                  ? theme.colorPalette.greySwatch.tappedSurfaceColor
                  : theme.colorPalette.greySwatch.disabledColor,
            ),
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: EasyDevTextField(
            controller: widget.endController,
            textInputType: TextInputType.number,
            valueChanged: (value) {
              setState(() {});
              widget.onEndChanged(_setValue(value, false));
            },
            inputState: _validateInputValue(widget.endController?.text, false)
                ? InputState.enabled
                : InputState.error,
            decoration: EasyDevInputDecoration(
              margin: EdgeInsets.zero,
              height: 36,
              backgroundColor: theme.brightness == Brightness.light
                  ? theme.colorPalette.greySwatch.tappedSurfaceColor
                  : theme.colorPalette.greySwatch.disabledColor,
              focusedColor: theme.brightness == Brightness.light
                  ? theme.colorPalette.greySwatch.tappedSurfaceColor
                  : theme.colorPalette.greySwatch.disabledColor,
              unfocusedColor: theme.brightness == Brightness.light
                  ? theme.colorPalette.greySwatch.tappedSurfaceColor
                  : theme.colorPalette.greySwatch.disabledColor,
            ),
          ),
        ),
      ],
    );
  }

  bool _validateInputValue(String? value, bool isStart) {
    final number = double.tryParse(value ?? '');
    if (number != null) {
      if (number > widget.max ||
          number < widget.min ||
          (isStart
              ? number >
                  _formatDouble(
                    (widget.currentValue.end - (widget.minimalRange ?? 0)),
                  )
              : number <
                  _formatDouble(
                    widget.currentValue.start + (widget.minimalRange ?? 0),
                  ))) {
        return false;
      }
      return true;
    }
    return false;
  }

  double _formatDouble(double value) {
    return double.parse(widget.formatValue(value));
  }

  double? _setValue(String? value, bool isStart) {
    final number = double.tryParse(value ?? '');

    if (number != null) {
      if (isStart &&
          number >
              _formatDouble(
                (widget.currentValue.end - (widget.minimalRange ?? 0)),
              )) {
        return _formatDouble((widget.currentValue.end - (widget.minimalRange ?? 0)));
      } else if (!isStart &&
          number <
              _formatDouble(
                widget.currentValue.start + (widget.minimalRange ?? 0),
              )) {
        return _formatDouble(
          widget.currentValue.start + (widget.minimalRange ?? 0),
        );
      } else if (number > widget.max) {
        return widget.max;
      } else if (number < widget.min) {
        return widget.min;
      } else {
        return number;
      }
    }
    return null;
  }
}
