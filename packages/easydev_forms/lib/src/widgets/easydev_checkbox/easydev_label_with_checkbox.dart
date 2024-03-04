import 'package:easydev_forms/src/widgets/easydev_checkbox/easydev_checkbox.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';

/// {@macro easydev_forms.widgets.easydev_checkbox.easydev_checkbox}
/// [EasyDevSwitch] with label.
///
/// See also:
///
///  * [EasyDevCheckbox], checkbox widget.
class EasyDevLabelWithCheckbox<T> extends StatelessWidget {
  /// Create a checkbox with label.
  const EasyDevLabelWithCheckbox({
    super.key,
    required this.label,
    required this.selected,
    required this.onSelect,
    required this.value,
    this.labelStyle,
    this.checkboxSize = 28,
    this.selectedColor,
    this.unselectedColor,
    this.disabledColor,
    this.disabled = false,
    this.outlined = false,
    this.padding,
    this.spacing,
    this.trailingCheckbox = true,
    this.minWidth,
    this.height,
    this.expanded = false,
  });

  /// Text that will be written next to the checkbox.
  final String? label;

  /// Whether the checkbox is selected.
  final bool selected;

  /// Action to be taken on checkbox tap.
  final ValueChanged<T> onSelect;

  /// Value that the checkbox represents.
  final T value;

  /// Text style of the label.
  final TextStyle? labelStyle;

  /// Length of the width and height of the checkbox.
  final double checkboxSize;

  /// Color of enabled checkbox when it is selected.
  final Color? selectedColor;

  /// Color of enabled checkbox when it is not selected.
  final Color? unselectedColor;

  /// Color of disabled checkbox.
  final Color? disabledColor;

  /// Whether the checkbox is disabled.
  final bool disabled;

  /// Whether the checkbox is outlined.
  final bool outlined;

  /// Padding around the widget.
  final EdgeInsets? padding;

  /// Amount of space between label and checkbox.
  final double? spacing;

  /// Whether the checkbox should be after the label.
  final bool trailingCheckbox;

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

    final checkbox = EasyDevCheckbox(
      selected: selected,
      onSelect: onSelect,
      value: value,
      padding: padding,
      disabledColor: disabledColor,
      disabled: disabled,
      outlined: outlined,
      selectedColor: selectedColor,
      size: checkboxSize,
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
        children: trailingCheckbox
            ? [textLabel, innerSpace, checkbox]
            : [checkbox, innerSpace, textLabel],
      ),
    );
  }
}
