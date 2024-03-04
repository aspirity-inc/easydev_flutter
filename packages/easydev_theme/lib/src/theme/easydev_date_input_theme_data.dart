import 'package:flutter/painting.dart';

class EasyDevDateInputThemeData {
  const EasyDevDateInputThemeData({
    this.height,
    this.minWidth,
    this.inputPadding,
    this.margin,
    this.textColor,
    this.hintColor,
    this.focusedColor,
    this.unfocusedColor,
    this.disabledColor,
  });

  final double? height;

  final double? minWidth;

  final EdgeInsets? inputPadding;

  final EdgeInsets? margin;

  final Color? textColor;

  final Color? hintColor;

  final Color? focusedColor;

  final Color? unfocusedColor;

  final Color? disabledColor;

  @override
  bool operator ==(Object other) =>
      other is EasyDevDateInputThemeData &&
      height == other.height &&
      minWidth == other.minWidth &&
      inputPadding == other.inputPadding &&
      margin == other.margin &&
      textColor == other.textColor &&
      hintColor == other.hintColor &&
      focusedColor == other.focusedColor &&
      unfocusedColor == other.unfocusedColor &&
      disabledColor == other.disabledColor;

  @override
  int get hashCode => Object.hash(
        height,
        minWidth,
        inputPadding,
        margin,
        textColor,
        hintColor,
        focusedColor,
        unfocusedColor,
        disabledColor,
      );

  EasyDevDateInputThemeData copyWith({
    double? height,
    double? minWidth,
    EdgeInsets? inputPadding,
    EdgeInsets? margin,
    Color? textColor,
    Color? hintColor,
    Color? focusedColor,
    Color? unfocusedColor,
    Color? disabledColor,
  }) =>
      EasyDevDateInputThemeData(
        height: height ?? this.height,
        minWidth: minWidth ?? this.minWidth,
        inputPadding: inputPadding ?? this.inputPadding,
        margin: margin ?? this.margin,
        textColor: textColor ?? this.textColor,
        hintColor: hintColor ?? this.hintColor,
        focusedColor: focusedColor ?? this.focusedColor,
        unfocusedColor: unfocusedColor ?? this.unfocusedColor,
        disabledColor: disabledColor ?? this.disabledColor,
      );
}
