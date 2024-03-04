import 'package:easydev_forms/easydev_forms.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';

/// [EasyDevRadioButton] provides a way of selecting [value], returned with [onSelect]
/// callback, [selected] is boolean value provides is [EasyDevRadioButton] is selected.
/// Distinction between [value] and [selected] is provided to help to use generate functions
/// in creating radiobutton lists, instead of specifying each radiobutton values. It usually
/// used in lists where only value need be selected so it will not provide way to unselect
/// radiobutton.
///
///
/// Example of using [EasyDevRadioButton].
/// ```dart
///  EasyDevRadioButton(
///   value: value,
///   onSelect: (value) {
///     ...
///   },
///   selected: selectedValue = value,
///  ),
/// ```
///
///
/// This sample shows app with [EasyDevRadioButton].
///
/// See code in example/lib/pages/examples/radiobutton_example.dart
///
/// See also:
///
///  * [EasyDevLabelWithRadioButton], labeled radiobutton widget.
///  * [EasyDevSwitch], switch widget
///  * [EasyDevCheckbox], checkbox widget.
class EasyDevRadioButton<T> extends StatefulWidget {
  /// Create a radio button.
  const EasyDevRadioButton({
    super.key,
    required this.selected,
    required this.onSelect,
    required this.value,
    this.size = 24,
    this.selectedColor,
    this.unselectedColor,
    this.disabledColor,
    this.radioType = RadioType.classic,
    this.disabled = false,
    this.padding,
  });

  /// Whether the radio button selected.
  final bool selected;

  /// Action to be taken on radio button tap.
  final ValueChanged<T> onSelect;

  /// Value of the radio button.
  final T value;

  /// Length of the width and height of the radio button.
  final double size;

  /// Color of the enabled button when it is selected.
  final Color? selectedColor;

  /// Color of the enabled button when it is not selected.
  final Color? unselectedColor;

  /// Color of the disabled button.
  final Color? disabledColor;

  /// {@macro easydev_theme.theme.easydev_selectables_theme_data}
  /// Type of the radio button.
  final RadioType radioType;

  /// Whether the radio button is disabled.
  final bool disabled;

  /// Padding around the radio button.
  final EdgeInsets? padding;

  @override
  State<EasyDevRadioButton<T>> createState() => _EasyDevRadioButtonState<T>();
}

class _EasyDevRadioButtonState<T> extends State<EasyDevRadioButton<T>> {
  late bool selected;

  late Color _radioColor;
  late double _borderWidth;
  late EdgeInsets _padding;

  double get selectedBorderWidth {
    switch (widget.radioType) {
      case RadioType.classic:
        return 1;
      case RadioType.modern:
        return 5;
    }
  }

  @override
  void initState() {
    super.initState();
    selected = widget.selected;
  }

  @override
  void didUpdateWidget(covariant EasyDevRadioButton<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    setAndUpdateFields();
    setState(() {
      selected = widget.selected;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setAndUpdateFields();
  }

  void setAndUpdateFields() {
    final theme = EasyDevTheme.of(context);
    final radioTheme = theme.selectableTheme;

    _radioColor = _getRadioColor(theme);

    _padding = widget.padding ?? radioTheme?.padding ?? EdgeInsets.zero;
  }

  @override
  Widget build(BuildContext context) {
    _borderWidth = selected ? selectedBorderWidth : 1.5;

    final Widget? child;
    switch (widget.radioType) {
      case RadioType.classic:
        child = AnimatedOpacity(
          opacity: selected ? 1 : 0,
          duration: const Duration(milliseconds: 100),
          child: Container(
            decoration: BoxDecoration(
              color: _radioColor,
              borderRadius: BorderRadius.circular(widget.size),
            ),
          ),
        );
        break;
      case RadioType.modern:
        child = null;
        break;
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapUp: (details) {
        if (widget.disabled) return;
        widget.onSelect(widget.value);
      },
      child: Padding(
        padding: _padding,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          height: widget.size,
          width: widget.size,
          padding: EdgeInsets.all(widget.size / 6),
          decoration: BoxDecoration(
            color: const Color(0x00000000),
            borderRadius: BorderRadius.circular(widget.size),
            border: Border.all(color: _radioColor, width: _borderWidth),
          ),
          child: child,
        ),
      ),
    );
  }

  Color _getRadioColor(EasyDevThemeData theme) {
    final themeBrightness = theme.brightness;
    final themePalette = theme.colorPalette;
    final radioTheme = theme.selectableTheme;

    if (widget.disabled) {
      if (themeBrightness == Brightness.light) {
        return widget.disabledColor ??
            radioTheme?.disabledColor ??
            themePalette.greySwatch.greyColor;
      }
      return widget.disabledColor ??
          radioTheme?.disabledColor ??
          themePalette.greySwatch.unselectedColor ??
          theme.brightness.surfaceColor;
    }
    if (selected) {
      if (themeBrightness == Brightness.light) {
        return radioTheme?.selectedColor ??
            themePalette.secondarySwatch?[400] ??
            themePalette.secondarySwatch ??
            themePalette.primarySwatch;
      }
      return (widget.selectedColor ??
              radioTheme?.selectedColor ??
              themePalette.secondarySwatch?[500]) ??
          themePalette.primarySwatch;
    }
    if (themeBrightness == Brightness.light) {
      return (widget.unselectedColor ??
              radioTheme?.unselectedColor ??
              themePalette.secondarySwatch?[400]) ??
          themePalette.secondarySwatch ??
          themePalette.primarySwatch;
    }
    return (widget.unselectedColor ??
            radioTheme?.unselectedColor ??
            themePalette.secondarySwatch?[500]) ??
        themePalette.secondarySwatch ??
        themePalette.primarySwatch;
  }
}
