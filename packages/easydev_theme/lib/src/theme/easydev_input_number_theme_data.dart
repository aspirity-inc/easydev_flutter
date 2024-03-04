import 'package:flutter/painting.dart';

class EasyDevInputNumberThemeData {
  const EasyDevInputNumberThemeData({
    this.size,
    this.enabledColor,
    this.disabledColor,
    this.countColor,
    this.padding,
    this.radius,
    this.spacing,
  });

  final double? size;

  final Color? enabledColor;

  final Color? disabledColor;

  final Color? countColor;

  final EdgeInsets? padding;

  final BorderRadius? radius;

  final double? spacing;

  @override
  bool operator ==(Object other) =>
      other is EasyDevInputNumberThemeData &&
      size == other.size &&
      enabledColor == other.enabledColor &&
      disabledColor == other.disabledColor &&
      countColor == other.countColor &&
      padding == other.padding &&
      radius == other.radius &&
      spacing == other.spacing;

  @override
  int get hashCode => Object.hash(
        size,
        enabledColor,
        disabledColor,
        countColor,
        padding,
        radius,
        spacing,
      );

  EasyDevInputNumberThemeData copyWith({
    double? size,
    Color? enabledColor,
    Color? disabledColor,
    Color? countColor,
    EdgeInsets? padding,
    BorderRadius? radius,
    double? spacing,
  }) =>
      EasyDevInputNumberThemeData(
        size: size ?? this.size,
        enabledColor: enabledColor ?? this.enabledColor,
        disabledColor: disabledColor ?? this.disabledColor,
        countColor: countColor ?? this.countColor,
        padding: padding ?? this.padding,
        radius: radius ?? this.radius,
        spacing: spacing ?? this.spacing,
      );
}
