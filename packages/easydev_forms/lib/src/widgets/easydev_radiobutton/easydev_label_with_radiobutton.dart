import 'package:easydev_forms/src/widgets/easydev_radiobutton/easydev_radiobutton.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// {@macro easydev_forms.widgets.easydev_radiobutton.easydev_radiobutton}
/// [EasyDevRadioButton] with label.
class EasyDevLabelWithRadioButton<T> extends StatelessWidget {
  /// Create a radio button with label.
  const EasyDevLabelWithRadioButton({
    super.key,
    required this.label,
    required this.selected,
    required this.onSelect,
    required this.value,
    this.labelStyle,
    this.buttonSize = 24,
    this.selectedColor,
    this.unselectedColor,
    this.disabledColor,
    this.disabled = false,
    this.radioType = RadioType.classic,
    this.padding,
    this.spacing,
    this.trailingRadioButton = true,
    this.minWidth,
    this.height,
    this.expanded = false,
  });

  /// Text that will be written next to the radio button.
  final String? label;

  /// Whether the radio button selected.
  final bool selected;

  /// Action to be taken on radio button tap.
  final ValueChanged<T> onSelect;

  /// Value of the radio button.
  final T value;

  /// Text style of the label.
  final TextStyle? labelStyle;

  /// Length of the width and height of the radio button.
  final double buttonSize;

  /// Color of the enabled button when it is selected.
  final Color? selectedColor;

  /// Color of the enabled button when it is not selected.
  final Color? unselectedColor;

  /// Color of the disabled button.
  final Color? disabledColor;

  /// Whether the radio button is disabled.
  final bool disabled;

  /// Type of the radio button.
  final RadioType radioType;

  /// Padding around the radio button.
  final EdgeInsets? padding;

  /// Amount of space between label and radio button.
  final double? spacing;

  /// Whether the radio button should be after the label.
  final bool trailingRadioButton;

  /// Minimal width of the widget.
  final double? minWidth;

  /// Height of the widget.
  final double? height;

  /// Whether the widget should take all of the available horizontal space.
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final theme = EasyDevTheme.of(context);

    final textLabel = Text(
      label ?? "",
      style: labelStyle ?? theme.typography?.body3Style,
    );

    final radioButton = EasyDevRadioButton(
      selected: selected,
      onSelect: onSelect,
      value: value,
      padding: padding,
      disabledColor: disabledColor,
      disabled: disabled,
      radioType: radioType,
      selectedColor: selectedColor,
      size: buttonSize,
      unselectedColor: unselectedColor,
    );

    final innerSpace = SizedBox(width: spacing);

    return Container(
      padding: padding ?? EdgeInsets.zero,
      constraints: BoxConstraints(
        minWidth: minWidth ?? 0,
        minHeight: height ?? 0,
        maxHeight: height ?? double.infinity,
      ),
      child: Row(
        mainAxisAlignment: expanded ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
        mainAxisSize: expanded ? MainAxisSize.max : MainAxisSize.min,
        children: trailingRadioButton
            ? [textLabel, innerSpace, radioButton]
            : [radioButton, innerSpace, textLabel],
      ),
    );
  }
}
