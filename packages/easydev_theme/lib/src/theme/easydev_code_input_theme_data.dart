import 'package:flutter/painting.dart';

class EasyDevCodeInputThemeData {
  const EasyDevCodeInputThemeData({
    this.size,
    this.emptyColor,
    this.backgroundColor,
    this.codeColor,
    this.borderColor,
    this.borderRadius,
    this.padding,
    this.margin,
  });

  final double? size;

  final Color? emptyColor;

  final Color? backgroundColor;

  final Color? codeColor;

  final Color? borderColor;

  final BorderRadius? borderRadius;

  final EdgeInsets? padding;

  final EdgeInsets? margin;

  @override
  bool operator ==(Object other) =>
      other is EasyDevCodeInputThemeData &&
      size == other.size &&
      emptyColor == other.emptyColor &&
      backgroundColor == other.backgroundColor &&
      codeColor == other.codeColor &&
      borderColor == other.borderColor &&
      padding == other.padding &&
      margin == other.margin;

  @override
  int get hashCode => Object.hash(
        size,
        emptyColor,
        backgroundColor,
        codeColor,
        borderColor,
        borderRadius,
        padding,
        margin,
      );

  EasyDevCodeInputThemeData copyWith({
    double? size,
    Color? emptyColor,
    Color? backgroundColor,
    Color? codeColor,
    Color? borderColor,
    BorderRadius? borderRadius,
    EdgeInsets? padding,
    EdgeInsets? margin,
  }) =>
      EasyDevCodeInputThemeData(
        size: size ?? this.size,
        emptyColor: emptyColor ?? this.emptyColor,
        backgroundColor: backgroundColor ?? this.backgroundColor,
        codeColor: codeColor ?? this.codeColor,
        borderColor: borderColor ?? this.borderColor,
        borderRadius: borderRadius ?? this.borderRadius,
        padding: padding ?? this.padding,
        margin: margin ?? this.margin,
      );
}
