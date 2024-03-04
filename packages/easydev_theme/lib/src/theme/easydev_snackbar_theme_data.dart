import 'package:flutter/painting.dart';

class EasyDevSnackbarThemeData {
  const EasyDevSnackbarThemeData({
    this.height,
    this.margin,
    this.padding,
    this.titleColor,
    this.subtitleColor,
    this.actionColor,
    this.borderRadius,
    this.duration,
  });

  final double? height;

  final EdgeInsets? margin;

  final EdgeInsets? padding;

  final Color? titleColor;

  final Color? subtitleColor;

  final Color? actionColor;

  final BorderRadius? borderRadius;

  final Duration? duration;

  @override
  bool operator ==(Object other) =>
      other is EasyDevSnackbarThemeData &&
      height == other.height &&
      margin == other.margin &&
      padding == other.margin &&
      padding == other.padding &&
      titleColor == other.titleColor &&
      subtitleColor == other.subtitleColor &&
      actionColor == other.actionColor &&
      borderRadius == other.borderRadius &&
      duration == other.duration;

  @override
  int get hashCode => Object.hash(
        height,
        margin,
        padding,
        titleColor,
        subtitleColor,
        actionColor,
        borderRadius,
        duration,
      );

  EasyDevSnackbarThemeData copyWith({
    double? height,
    EdgeInsets? margin,
    EdgeInsets? padding,
    Color? titleColor,
    Color? subtitleColor,
    Color? actionColor,
    BorderRadius? borderRadius,
    Duration? duration,
  }) =>
      EasyDevSnackbarThemeData(
        height: height ?? this.height,
        margin: margin ?? this.margin,
        padding: padding ?? this.padding,
        titleColor: titleColor ?? this.titleColor,
        subtitleColor: subtitleColor ?? this.subtitleColor,
        actionColor: actionColor ?? this.actionColor,
        borderRadius: borderRadius ?? this.borderRadius,
        duration: duration ?? this.duration,
      );
}
