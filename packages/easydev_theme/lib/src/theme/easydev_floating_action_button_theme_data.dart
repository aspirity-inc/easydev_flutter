import 'package:flutter/painting.dart';

class EasyDevFloatingActionButtonThemeData {
  const EasyDevFloatingActionButtonThemeData({
    this.color,
    this.tapColor,
    this.disabledColor,
    this.radius,
    this.largeButtonSize,
    this.smallButtonSize,
    this.elevation,
    this.tapElevation,
    this.disabledElevation,
  });

  final Color? color;

  final Color? tapColor;

  final Color? disabledColor;

  final double? radius;

  final double? largeButtonSize;

  final double? smallButtonSize;

  final double? elevation;

  final double? tapElevation;

  final double? disabledElevation;

  @override
  bool operator ==(Object other) =>
      other is EasyDevFloatingActionButtonThemeData &&
      color == other.color &&
      tapColor == other.tapColor &&
      disabledColor == other.disabledColor &&
      radius == other.radius &&
      largeButtonSize == other.largeButtonSize &&
      smallButtonSize == other.smallButtonSize &&
      elevation == other.elevation &&
      tapElevation == other.tapElevation &&
      disabledElevation == other.disabledElevation;

  @override
  int get hashCode => Object.hash(
        color,
        tapColor,
        disabledColor,
        radius,
        largeButtonSize,
        smallButtonSize,
        elevation,
        tapElevation,
        disabledElevation,
      );

  EasyDevFloatingActionButtonThemeData copyWith({
    Color? color,
    Color? tapColor,
    Color? disabledColor,
    double? radius,
    double? largeButtonSize,
    double? smallButtonSize,
    double? elevation,
    double? tapElevation,
    double? disabledElevation,
  }) =>
      EasyDevFloatingActionButtonThemeData(
        color: color ?? this.color,
        tapColor: tapColor ?? this.tapColor,
        disabledColor: disabledColor ?? this.disabledColor,
        radius: radius ?? this.radius,
        largeButtonSize: largeButtonSize ?? this.largeButtonSize,
        smallButtonSize: smallButtonSize ?? this.smallButtonSize,
        elevation: elevation ?? this.elevation,
        tapElevation: tapElevation ?? this.tapElevation,
        disabledElevation: disabledElevation ?? this.disabledElevation,
      );
}
