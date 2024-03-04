import 'package:flutter/painting.dart';

class EasyDevInputThemeData {
  const EasyDevInputThemeData({
    this.borderRadius,
    this.borderWidth,
    this.border,
    this.unfocusedColor,
    this.focusedColor,
    this.filledColor,
    this.errorColor,
    this.loadingColor,
    this.successColor,
    this.disabledColor,
    this.textColor,
    this.labelColor,
    this.hintColor,
    this.commentColor,
    this.iconColor,
    this.letterCountColor,
    this.height,
    this.minWidth,
    this.expands,
    this.padding,
    this.margin,
  });

  final BorderRadius? borderRadius;

  final double? borderWidth;

  final Border? border;

  final Color? unfocusedColor;

  final Color? focusedColor;

  final Color? filledColor;

  final Color? errorColor;

  final Color? loadingColor;

  final Color? successColor;

  final Color? disabledColor;

  final Color? textColor;

  final Color? labelColor;

  final Color? hintColor;

  final Color? commentColor;

  final Color? iconColor;

  final Color? letterCountColor;

  final double? height;

  final double? minWidth;

  final bool? expands;

  final EdgeInsets? padding;

  final EdgeInsets? margin;

  @override
  bool operator ==(Object other) =>
      other is EasyDevInputThemeData &&
      borderRadius == other.borderRadius &&
      border == other.border &&
      unfocusedColor == other.unfocusedColor &&
      focusedColor == other.focusedColor &&
      filledColor == other.filledColor &&
      errorColor == other.errorColor &&
      loadingColor == other.loadingColor &&
      successColor == other.successColor &&
      disabledColor == other.disabledColor &&
      textColor == other.textColor &&
      labelColor == other.labelColor &&
      hintColor == other.hintColor &&
      commentColor == other.commentColor &&
      iconColor == other.iconColor &&
      letterCountColor == other.letterCountColor &&
      height == other.height &&
      minWidth == other.minWidth &&
      expands == other.expands &&
      padding == other.padding &&
      margin == other.margin;

  @override
  int get hashCode => Object.hashAll([
        borderRadius,
        borderWidth,
        border,
        unfocusedColor,
        focusedColor,
        filledColor,
        errorColor,
        loadingColor,
        successColor,
        disabledColor,
        textColor,
        labelColor,
        hintColor,
        commentColor,
        iconColor,
        letterCountColor,
        height,
        minWidth,
        expands,
        padding,
        margin,
      ]);

  EasyDevInputThemeData copyWith({
    BorderRadius? borderRadius,
    double? borderWidth,
    Border? border,
    Color? unfocusedColor,
    Color? focusedColor,
    Color? filledColor,
    Color? errorColor,
    Color? loadingColor,
    Color? successColor,
    Color? disabledColor,
    Color? textColor,
    Color? labelColor,
    Color? hintColor,
    Color? commentColor,
    Color? iconColor,
    Color? letterCountColor,
    double? height,
    double? minWidth,
    bool? expands,
    EdgeInsets? padding,
    EdgeInsets? margin,
  }) =>
      EasyDevInputThemeData(
        borderRadius: borderRadius ?? this.borderRadius,
        borderWidth: borderWidth ?? this.borderWidth,
        border: border ?? this.border,
        unfocusedColor: unfocusedColor ?? this.unfocusedColor,
        focusedColor: focusedColor ?? this.focusedColor,
        filledColor: filledColor ?? this.filledColor,
        errorColor: errorColor ?? this.errorColor,
        loadingColor: loadingColor ?? this.loadingColor,
        successColor: successColor ?? this.successColor,
        disabledColor: disabledColor ?? this.disabledColor,
        textColor: textColor ?? this.textColor,
        labelColor: labelColor ?? this.labelColor,
        hintColor: hintColor ?? this.hintColor,
        commentColor: commentColor ?? this.commentColor,
        iconColor: iconColor ?? this.iconColor,
        letterCountColor: letterCountColor ?? this.letterCountColor,
        height: height ?? this.height,
        minWidth: minWidth ?? this.minWidth,
        expands: expands ?? this.expands,
        padding: padding ?? this.padding,
        margin: margin ?? this.margin,
      );
}
