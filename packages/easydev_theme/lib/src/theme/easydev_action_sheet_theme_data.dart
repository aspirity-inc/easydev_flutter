import 'package:flutter/painting.dart';

class EasyDevActionSheetThemeData {
  const EasyDevActionSheetThemeData({
    this.backgroundColor,
    this.tappedColor,
    this.actionIconColor,
    this.actionIconSize,
    this.spacing,
    this.padding,
    this.titleStyle,
    this.actionStyle,
    this.borderRadius,
    this.showCancelButton,
  });

  final Color? backgroundColor;

  final Color? tappedColor;

  final Color? actionIconColor;

  final double? actionIconSize;

  final double? spacing;

  final EdgeInsets? padding;

  final TextStyle? titleStyle;

  final TextStyle? actionStyle;

  final BorderRadius? borderRadius;

  final bool? showCancelButton;

  @override
  bool operator ==(Object other) =>
      other is EasyDevActionSheetThemeData &&
      backgroundColor == other.backgroundColor &&
      tappedColor == other.tappedColor &&
      actionIconColor == other.actionIconColor &&
      actionIconSize == other.actionIconSize &&
      spacing == other.spacing &&
      padding == other.padding &&
      titleStyle == other.titleStyle &&
      actionStyle == other.actionStyle &&
      borderRadius == other.borderRadius &&
      showCancelButton == other.showCancelButton;

  @override
  int get hashCode => Object.hash(
        backgroundColor,
        tappedColor,
        actionIconColor,
        actionIconSize,
        spacing,
        padding,
        titleStyle,
        actionStyle,
        borderRadius,
        showCancelButton,
      );

  EasyDevActionSheetThemeData copyWith({
    Color? backgroundColor,
    Color? tappedColor,
    Color? actionIconColor,
    double? actionIconSize,
    double? spacing,
    EdgeInsets? padding,
    TextStyle? titleStyle,
    TextStyle? actionStyle,
    BorderRadius? borderRadius,
    bool? showCancelButton,
  }) =>
      EasyDevActionSheetThemeData(
        backgroundColor: backgroundColor ?? this.backgroundColor,
        tappedColor: tappedColor ?? this.tappedColor,
        actionIconSize: actionIconSize ?? this.actionIconSize,
        actionIconColor: actionIconColor ?? this.actionIconColor,
        spacing: spacing ?? this.spacing,
        padding: padding ?? this.padding,
        titleStyle: titleStyle ?? this.titleStyle,
        actionStyle: actionStyle ?? this.actionStyle,
        borderRadius: borderRadius ?? this.borderRadius,
        showCancelButton: showCancelButton ?? this.showCancelButton,
      );
}
