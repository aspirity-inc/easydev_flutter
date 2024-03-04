import 'package:community_material_icon/community_material_icon.dart';
import 'package:easydev_forms/src/widgets/easydev_input_number/counter_button.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';

/// Simple number input with buttons that changes value by one. If internal value is equal to
/// [minValue], subtract button is disabled. If internal value is equal to [maxValue],
/// if [maxValue] is provided, add button is disabled.
///
///
/// Example of using [EasyDevInputNumber].
/// ```dart
/// EasyDevInputNumber((
///   initialValue: 3,
///   maxValue: 5,
///   valueChanged: (int value) {
///     ...
///   },
/// ),
/// ```
///
///
///
/// This sample shows app with [EasyDevInputNumber].
///
/// See code in example/lib/pages/examples/input_number_example.dart
class EasyDevInputNumber extends StatefulWidget {
  const EasyDevInputNumber({
    super.key,
    required this.valueChanged,
    this.initialValue = 0,
    this.minValue = 0,
    this.maxValue,
    this.enabledColor,
    this.disabledColor,
    this.counterIconColor,
    this.padding,
    this.spacing,
    this.counterStyle,
    this.size,
    this.addIcon,
    this.subtractIcon,
  });

  /// Called when change number buttons is pressed and there are not disabled.
  final ValueChanged<int> valueChanged;

  /// Initial value of number input widget.
  final int initialValue;

  /// Minimum value of number input. Initially is 0.
  final int minValue;

  /// Maximum value of number input.
  final int? maxValue;

  /// Color of enabled side [CounterButton]s.
  final Color? enabledColor;

  /// Color of disabled side [CounterButton]s.
  final Color? disabledColor;

  /// Color of icon in [CounterButton].
  final Color? counterIconColor;

  /// Padding of widget.
  final EdgeInsets? padding;

  /// Spacing between [CounterButton] and count.
  final double? spacing;

  /// [TextStyle] of count widget.
  final TextStyle? counterStyle;

  /// Size of [CounterButton] widgets.
  final double? size;

  /// Icon of left [CounterButton] widget.
  final IconData? addIcon;

  /// Icons of right [CounterButton] widget.
  final IconData? subtractIcon;

  @override
  State<EasyDevInputNumber> createState() => _EasyDevInputNumberState();
}

class _EasyDevInputNumberState extends State<EasyDevInputNumber> {
  late int value;
  late Color _enabledColor;
  late Color _disabledColor;
  late Color _counterIconColor;
  late EdgeInsets _padding;
  late TextStyle? _counterStyle;
  late double _spacing;
  late double _size;

  @override
  void initState() {
    value = widget.initialValue;
    super.initState();
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
    final brightness = theme.brightness;
    final colorPalette = theme.colorPalette;
    final inputNumberTheme = theme.inputNumberTheme;

    _disabledColor = widget.disabledColor ??
        inputNumberTheme?.disabledColor ??
        colorPalette.greySwatch.disabledColor ??
        colorPalette.greySwatch.greyColor;

    _enabledColor = widget.enabledColor ??
        inputNumberTheme?.enabledColor ??
        colorPalette.secondarySwatch ??
        (brightness == Brightness.dark
            ? (colorPalette.secondarySwatch?[500] ?? colorPalette.primarySwatch)
            : (colorPalette.secondarySwatch?[400] ?? colorPalette.primarySwatch));

    _counterIconColor =
        colorPalette.greySwatch.backgroundColor ?? colorPalette.greySwatch.surfaceColor;

    _counterStyle = widget.counterStyle ??
        theme.typography?.subheading1Style?.copyWith(
          color: inputNumberTheme?.countColor ??
              theme.colorPalette.greySwatch.onBackgroundColor ??
              theme.colorPalette.greySwatch.onSurfaceColor,
        );

    _padding = widget.padding ?? inputNumberTheme?.padding ?? const EdgeInsets.all(16);

    _spacing = widget.spacing ?? inputNumberTheme?.spacing ?? 12;

    _size = widget.size ?? inputNumberTheme?.size ?? 32;
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.easyDevTheme;

    return Padding(
      padding: _padding,
      child: Row(
        children: [
          CounterButton(
            icon: widget.addIcon ?? CommunityMaterialIcons.minus,
            size: _size,
            onTap: () {
              widget.valueChanged(value - 1);
              setState(() {
                value = value - 1;
              });
            },
            enabled: value > widget.minValue,
            disabledColor: _disabledColor,
            radius: theme.inputNumberTheme?.radius ??
                const BorderRadius.all(
                  Radius.circular(4),
                ),
            enabledColor: _enabledColor,
            counterIconColor: _counterIconColor,
          ),
          SizedBox(
            width: _spacing,
          ),
          Text(
            value.toString(),
            style: _counterStyle,
          ),
          SizedBox(
            width: _spacing,
          ),
          CounterButton(
            icon: widget.subtractIcon ?? CommunityMaterialIcons.plus,
            size: _size,
            onTap: () {
              widget.valueChanged(value + 1);
              setState(() {
                value = value + 1;
              });
            },
            enabled: (widget.maxValue == null || value < widget.maxValue!),
            disabledColor: _disabledColor,
            radius: theme.inputNumberTheme?.radius ??
                const BorderRadius.all(
                  Radius.circular(4),
                ),
            enabledColor: _enabledColor,
            counterIconColor: _counterIconColor,
          ),
        ],
      ),
    );
  }
}
