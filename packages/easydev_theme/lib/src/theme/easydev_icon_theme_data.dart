import 'package:flutter/painting.dart';

class EasyDevIconThemeData {
  const EasyDevIconThemeData({
    this.color,
    this.size,
    this.padding,
  });

  final Color? color;

  final double? size;

  final EdgeInsets? padding;

  @override
  bool operator ==(Object other) =>
      other is EasyDevIconThemeData &&
      color == other.color &&
      size == other.size &&
      padding == other.padding;

  @override
  int get hashCode => Object.hash(
        color,
        size,
        padding,
      );

  EasyDevIconThemeData copyWith({
    Color? color,
    double? size,
    EdgeInsets? padding,
  }) =>
      EasyDevIconThemeData(
        color: color ?? this.color,
        size: size ?? this.size,
        padding: padding ?? this.padding,
      );
}
