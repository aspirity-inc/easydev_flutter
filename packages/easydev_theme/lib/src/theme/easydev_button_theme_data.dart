import 'package:flutter/painting.dart';

class EasyDevButtonThemeData {
  const EasyDevButtonThemeData({
    this.defaultColor,
    this.disabledColor,
    this.tapColor,
    this.padding,
    this.margin,
    this.expanded,
    this.minWidth,
    this.height,
    this.softButtonBorderRadius,
    this.borderRadius,
    this.iconMargin,
    this.textColor,
  });

  final Color? defaultColor;

  final Color? disabledColor;

  final Color? tapColor;

  final EdgeInsets? padding;

  final EdgeInsets? margin;

  final bool? expanded;

  final double? minWidth;

  final double? height;

  final BorderRadius? softButtonBorderRadius;

  final BorderRadius? borderRadius;

  final double? iconMargin;

  final Color? textColor;

  @override
  bool operator ==(Object other) =>
      other is EasyDevButtonThemeData &&
      defaultColor == other.defaultColor &&
      disabledColor == other.disabledColor &&
      tapColor == other.tapColor &&
      padding == other.padding &&
      margin == other.margin &&
      expanded == other.expanded &&
      minWidth == other.minWidth &&
      height == other.height &&
      softButtonBorderRadius == other.softButtonBorderRadius &&
      borderRadius == other.borderRadius &&
      iconMargin == other.iconMargin &&
      textColor == other.textColor;

  @override
  int get hashCode => Object.hash(
        defaultColor,
        disabledColor,
        tapColor,
        padding,
        margin,
        expanded,
        minWidth,
        height,
        softButtonBorderRadius,
        borderRadius,
        iconMargin,
        textColor,
      );

  EasyDevButtonThemeData copyWith({
    Color? defaultColor,
    Color? disabledColor,
    Color? tapColor,
    EdgeInsets? padding,
    EdgeInsets? margin,
    bool? expanded,
    double? minWidth,
    double? height,
    BorderRadius? softButtonBorderRadius,
    BorderRadius? borderRadius,
    double? iconMargin,
    Color? textColor,
  }) =>
      EasyDevButtonThemeData(
        defaultColor: defaultColor ?? this.defaultColor,
        disabledColor: disabledColor ?? this.disabledColor,
        tapColor: tapColor ?? this.tapColor,
        padding: padding ?? this.padding,
        margin: margin ?? this.margin,
        expanded: expanded ?? this.expanded,
        minWidth: minWidth ?? this.minWidth,
        height: height ?? this.height,
        softButtonBorderRadius: softButtonBorderRadius ?? this.softButtonBorderRadius,
        borderRadius: borderRadius ?? this.borderRadius,
        iconMargin: iconMargin ?? this.iconMargin,
        textColor: textColor ?? this.textColor,
      );
}
