import 'package:easydev_base_ui/easydev_base_ui.dart';
import 'package:easydev_forms/easydev_forms.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';

/// Internal widget that is placed in [EasyDevSlider] that can be used to manually enter value.
class SliderInput extends StatefulWidget {
  const SliderInput({
    super.key,
    required this.min,
    required this.max,
    required this.onChanged,
    this.controller,
  });

  final double min;
  final double max;
  final ValueChanged<double?> onChanged;
  final TextEditingController? controller;

  @override
  State<SliderInput> createState() => _SliderInputState();
}

class _SliderInputState extends State<SliderInput> {
  @override
  Widget build(BuildContext context) {
    final theme = EasyDevTheme.of(context);

    return EasyDevTextField(
      controller: widget.controller,
      textInputType: TextInputType.number,
      valueChanged: (value) {
        setState(() {});
        widget.onChanged(_setValue(value));
      },
      inputState: (_validateInputValue(widget.controller?.text) ?? true)
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
    );
  }

  bool? _validateInputValue(String? value) {
    final number = double.tryParse(value ?? '');
    if (number != null) {
      if (number > widget.max || number < widget.min) return false;
      return true;
    }
    return false;
  }

  double? _setValue(String? value) {
    final number = double.tryParse(value ?? '');

    if (number != null) {
      if (number > widget.max) {
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
