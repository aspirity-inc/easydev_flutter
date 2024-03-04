import 'dart:io';

import 'package:easydev_forms/src/widgets/easydev_switch/easydev_switch.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';

/// {@macro easydev_forms.widgets.easydev_switch.easydev_switch}
/// [EasyDevSwitch] with label.
class EasyDevLabelWithSwitch extends StatelessWidget {
  /// Create a switch with label.
  const EasyDevLabelWithSwitch({
    super.key,
    required this.label,
    required this.value,
    required this.onSelect,
    this.switchHeight,
    this.switchWidth,
    this.selectedTrackColor,
    this.selectedKnobColor,
    this.unselectedTrackColor,
    this.unselectedKnobColor,
    this.disabledTrackColor,
    this.disabledKnobColor,
    this.pinType = PinType.neutral,
    this.disabled = false,
    this.outlined = false,
    this.padding,
    this.spacing,
    this.trailingSwitch = true,
    this.labelStyle,
    this.minWidth,
    this.height,
    this.expanded = false,
  });

  /// Create a label with switch that styles itself
  /// according to current platform.
  factory EasyDevLabelWithSwitch.adaptive({
    required String? label,
    required bool value,
    required ValueChanged<bool> onSelect,
    required double? switchHeight,
    double? switchWidth,
    Color? selectedTrackColor,
    Color? selectedKnobColor,
    Color? unselectedTrackColor,
    Color? unselectedKnobColor,
    Color? disabledTrackColor,
    Color? disabledKnobColor,
    bool disabled,
    bool outlined,
    EdgeInsets? padding,
    double? spacing,
    bool trailingSwitch,
    TextStyle? labelStyle,
    double? minWidth,
    double? height,
    bool expanded,
  }) = _EasyDevLabelWithSwitchAdaptive;

  /// Text that will be written next to the switch.
  final String? label;

  /// Current state of the switch.
  final bool value;

  /// Action to be taken on switch tap.
  final ValueChanged<bool> onSelect;

  /// Height of the switch.
  final double? switchHeight;

  /// Width of the switch.
  final double? switchWidth;

  /// Color of the track when the switch is enabled and selected.
  final Color? selectedTrackColor;

  /// Color of the knob when the switch is enabled and selected.
  final Color? selectedKnobColor;

  /// Color of the track when the switch is enabled and not selected.
  final Color? unselectedTrackColor;

  /// Color of the knob when the switch is enabled and not selected.
  final Color? unselectedKnobColor;

  /// Color of the track when the switch is disabled.
  final Color? disabledTrackColor;

  /// Color of the knob when the switch is disabled.
  final Color? disabledKnobColor;

  /// Type of the switch pin.
  final PinType pinType;

  /// Whether the switch is disabled.
  final bool disabled;

  /// Whether the switch is outlined.
  ///
  /// If it is true, the track color would be transparent
  /// even if it is set in constructor.
  final bool outlined;

  /// Padding around the switch.
  final EdgeInsets? padding;

  /// Amount of space between label and radio button.
  final double? spacing;

  /// Whether the switch should be after the label.
  final bool trailingSwitch;

  /// Text style of the label.
  final TextStyle? labelStyle;

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

    final switchWidget = EasyDevSwitch(
      value: value,
      onSelect: onSelect,
      height: switchHeight,
      width: switchWidth,
      selectedTrackColor: selectedTrackColor,
      selectedKnobColor: selectedKnobColor,
      unselectedTrackColor: unselectedTrackColor,
      unselectedKnobColor: unselectedKnobColor,
      disabledTrackColor: disabledTrackColor,
      disabledKnobColor: disabledKnobColor,
      pinType: pinType,
      disabled: disabled,
      outlined: outlined,
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
        children: trailingSwitch
            ? [textLabel, innerSpace, switchWidget]
            : [switchWidget, innerSpace, textLabel],
      ),
    );
  }
}

class _EasyDevLabelWithSwitchAdaptive extends EasyDevLabelWithSwitch {
  _EasyDevLabelWithSwitchAdaptive({
    required super.label,
    required super.value,
    required super.onSelect,
    required super.switchHeight,
    super.switchWidth,
    super.selectedTrackColor,
    super.selectedKnobColor,
    super.unselectedTrackColor,
    super.unselectedKnobColor,
    super.disabledTrackColor,
    super.disabledKnobColor,
    super.disabled = false,
    super.outlined = false,
    super.padding,
    super.spacing,
    super.trailingSwitch = true,
    super.labelStyle,
    super.minWidth,
    super.height,
    super.expanded = false,
  }) : super(pinType: _getPinType());

  static PinType _getPinType() {
    if (Platform.isAndroid || Platform.isFuchsia) return PinType.android;
    if (Platform.isIOS || Platform.isMacOS) return PinType.ios;
    return PinType.neutral;
  }
}
