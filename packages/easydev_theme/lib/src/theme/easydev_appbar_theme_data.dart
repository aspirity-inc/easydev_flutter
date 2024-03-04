import 'package:flutter/painting.dart';

class EasyDevAppBarThemeData {
  const EasyDevAppBarThemeData({
    this.backgroundColor,
    this.actionIconSize,
    this.actionIconColor,
    this.titleColor,
    this.titleAlignment,
    this.leadingIconColor,
    this.leadingIconSize,
  });

  final Color? backgroundColor;

  final double? actionIconSize;

  final Color? actionIconColor;

  final Color? titleColor;

  final Alignment? titleAlignment;

  final Color? leadingIconColor;

  final double? leadingIconSize;

  @override
  bool operator ==(Object other) =>
      other is EasyDevAppBarThemeData &&
      backgroundColor == other.backgroundColor &&
      actionIconSize == other.actionIconSize &&
      titleColor == other.titleColor &&
      titleAlignment == other.titleAlignment &&
      leadingIconColor == other.leadingIconColor &&
      leadingIconColor == other.leadingIconColor &&
      leadingIconSize == other.leadingIconSize;

  @override
  int get hashCode => Object.hash(
        backgroundColor,
        actionIconSize,
        actionIconColor,
        titleColor,
        titleAlignment,
        leadingIconColor,
        leadingIconSize,
      );

  EasyDevAppBarThemeData copyWith({
    Color? backgroundColor,
    double? actionIconSize,
    Color? actionIconColor,
    Color? titleColor,
    Alignment? titleAlignment,
    Color? leadingIconColor,
    double? leadingIconSize,
  }) =>
      EasyDevAppBarThemeData(
        backgroundColor: backgroundColor ?? this.backgroundColor,
        actionIconSize: actionIconSize ?? this.actionIconSize,
        actionIconColor: actionIconColor ?? this.actionIconColor,
        titleColor: titleColor ?? this.titleColor,
        titleAlignment: titleAlignment ?? this.titleAlignment,
        leadingIconColor: leadingIconColor ?? this.leadingIconColor,
        leadingIconSize: leadingIconSize ?? this.leadingIconSize,
      );
}
