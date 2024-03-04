import 'package:community_material_icon/community_material_icon.dart';
import 'package:easydev_forms/easydev_forms.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';

/// Checkbox that can be used to show a value that can be selected or unselected.
/// Checkbox selection is represented by providing [selected] field.
/// [value] represents current value of checkbox and [onSelect] is callback for this
/// value changed, checkbox is often used in situations where user can select multiple
/// boolean values. Separation [selected] field and [value], can provide easier way of
/// creating list of checkboxes, as checkboxes can be create with generate function rather
/// specifying manually each checkbox and what value it should change.
///
/// Example of using [EasyDevCheckbox] with children.
/// ```dart
///  EasyDevCheckbox(
///   value: value
///   onSelect: (value) {
///     ...
///   },
///   selected: values.contains(value),
///  ),
/// ```
///
///
/// This sample shows app with list of checkboxes. Lowest checkbox is [EasyDevLabelWithCheckbox].
///
/// See code in example/lib/pages/examples/checkbox_example.dart
///
/// See also:
///
///  * [EasyDevLabelWithCheckbox], labeled checkbox widget.
///  * [EasyDevSwitch], switch widget
///  * [EasyDevRadioButton], radio button, usually used for selecting one value from set of values.
class EasyDevCheckbox<T> extends StatefulWidget {
  /// Create a checkbox.
  const EasyDevCheckbox({
    super.key,
    required this.selected,
    required this.onSelect,
    required this.value,
    this.size = 28,
    this.selectedColor,
    this.unselectedColor,
    this.disabledColor,
    this.disabled = false,
    this.padding,
    this.outlined = false,
  });

  /// Whether the checkbox is selected.
  final bool selected;

  /// Action to be taken on checkbox tap.
  final ValueChanged<T> onSelect;

  /// Value that the checkbox represents.
  final T value;

  /// Length of the width and height of the checkbox.
  final double size;

  /// Color of enabled checkbox when it is selected.
  final Color? selectedColor;

  /// Color of enabled checkbox when it is not selected.
  final Color? unselectedColor;

  /// Color of disabled checkbox.
  final Color? disabledColor;

  /// Whether the checkbox is disabled.
  final bool disabled;

  /// Padding around the checkbox.
  final EdgeInsets? padding;

  /// Whether the checkbox is outlined.
  final bool outlined;

  @override
  State<EasyDevCheckbox<T>> createState() => _EasyDevCheckboxState();
}

class _EasyDevCheckboxState<T> extends State<EasyDevCheckbox<T>> {
  late bool selected;

  late Color _iconColor;
  late EdgeInsets _padding;

  Color? _getColor() {
    final theme = EasyDevTheme.of(context);
    final themeBrightness = theme.brightness;
    final themePalette = theme.colorPalette;
    final checkboxTheme = theme.selectableTheme;

    if (widget.disabled) {
      if (themeBrightness == Brightness.light) {
        return widget.disabledColor ??
            checkboxTheme?.disabledColor ??
            theme.colorPalette.greySwatch.greyColor;
      }
      return widget.disabledColor ??
          checkboxTheme?.disabledColor ??
          theme.colorPalette.greySwatch.unselectedColor ??
          theme.brightness.onSurfaceColor;
    }
    if (selected) {
      if (themeBrightness == Brightness.light) {
        return widget.selectedColor ??
            checkboxTheme?.selectedColor ??
            themePalette.secondarySwatch?[300] ??
            themePalette.secondarySwatch ??
            themePalette.primarySwatch;
      }
      return widget.selectedColor ??
          checkboxTheme?.selectedColor ??
          themePalette.secondarySwatch?[500];
    }

    if (themeBrightness == Brightness.light) {
      return widget.unselectedColor ??
          checkboxTheme?.unselectedColor ??
          themePalette.secondarySwatch?[300] ??
          themePalette.secondarySwatch ??
          themePalette.primarySwatch;
    }
    return widget.unselectedColor ??
        checkboxTheme?.unselectedColor ??
        themePalette.secondarySwatch?[500];
  }

  @override
  void initState() {
    super.initState();
    selected = widget.selected;
  }

  @override
  void didUpdateWidget(covariant EasyDevCheckbox<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    setAndUpdateFields();
    setState(() {
      selected = widget.selected;
    });
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    setAndUpdateFields();
  }

  void setAndUpdateFields() {
    final theme = EasyDevTheme.of(context);
    final checkboxTheme = theme.selectableTheme;

    _iconColor = _getColor() ?? theme.brightness.onSurfaceColor;

    _padding = widget.padding ?? checkboxTheme?.padding ?? EdgeInsets.zero;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapUp: (details) {
        if (widget.disabled) return;
        widget.onSelect(widget.value);
      },
      child: Padding(
        padding: _padding,
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (widget.outlined)
              Icon(
                widget.selected
                    ? CommunityMaterialIcons.check_box_outline
                    : CommunityMaterialIcons.checkbox_blank_outline,
                color: _iconColor,
                size: widget.size,
              )
            else
              Icon(
                widget.selected
                    ? CommunityMaterialIcons.checkbox_marked
                    : CommunityMaterialIcons.checkbox_blank_outline,
                color: _iconColor,
                size: widget.size,
              )
          ],
        ),
      ),
    );
  }
}
