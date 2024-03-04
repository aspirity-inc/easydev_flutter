import 'package:flutter/painting.dart';

class EasyDevChipsThemeData {
  const EasyDevChipsThemeData({
    this.padding,
    this.spacing,
    this.radius,
    this.color,
    this.tappedColor,
    this.disabledColor,
    this.iconColor,
    this.textStyle,
  });

  final EdgeInsets? padding;

  final double? spacing;

  final BorderRadius? radius;

  final Color? color;

  final Color? tappedColor;

  final Color? disabledColor;

  final Color? iconColor;

  final TextStyle? textStyle;

  @override
  bool operator ==(Object other) =>
      other is EasyDevChipsThemeData &&
      padding == other.padding &&
      spacing == other.spacing &&
      radius == other.radius &&
      color == other.color &&
      tappedColor == other.tappedColor &&
      disabledColor == other.disabledColor &&
      iconColor == other.iconColor &&
      textStyle == other.textStyle;

  @override
  int get hashCode => Object.hash(
        padding,
        spacing,
        radius,
        color,
        tappedColor,
        disabledColor,
        iconColor,
        textStyle,
      );

  EasyDevChipsThemeData copyWith({
    EdgeInsets? padding,
    double? spacing,
    BorderRadius? radius,
    Color? color,
    Color? tappedColor,
    Color? disabledColor,
    Color? iconColor,
    TextStyle? textStyle,
  }) =>
      EasyDevChipsThemeData(
        padding: padding ?? this.padding,
        spacing: spacing ?? this.spacing,
        radius: radius ?? this.radius,
        color: color ?? this.color,
        tappedColor: tappedColor ?? this.tappedColor,
        disabledColor: disabledColor ?? this.disabledColor,
        iconColor: iconColor ?? this.iconColor,
        textStyle: textStyle ?? this.textStyle,
      );
}
