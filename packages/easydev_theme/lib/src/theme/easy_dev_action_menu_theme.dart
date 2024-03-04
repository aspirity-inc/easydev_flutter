import 'package:flutter/painting.dart';

class EasyDevActionMenuThemeData {
  const EasyDevActionMenuThemeData({
    this.backgroundColor,
    this.tappedColor,
    this.iconColor,
    this.iconSize,
    this.padding,
    this.actionStyle,
    this.unselectedActionColor,
    this.selectedActionColor,
    this.borderRadius,
  });

  final Color? backgroundColor;

  final Color? tappedColor;

  final Color? iconColor;

  final double? iconSize;

  final EdgeInsets? padding;

  final TextStyle? actionStyle;

  final Color? unselectedActionColor;

  final Color? selectedActionColor;

  final BorderRadius? borderRadius;

  @override
  bool operator ==(Object other) =>
      other is EasyDevActionMenuThemeData &&
      backgroundColor == other.backgroundColor &&
      tappedColor == other.tappedColor &&
      iconSize == other.iconSize &&
      iconColor == other.iconColor &&
      padding == other.padding &&
      actionStyle == other.actionStyle &&
      borderRadius == other.borderRadius &&
      unselectedActionColor == other.unselectedActionColor &&
      selectedActionColor == other.selectedActionColor;

  @override
  int get hashCode => Object.hash(
        backgroundColor,
        tappedColor,
        iconColor,
        iconSize,
        padding,
        actionStyle,
        borderRadius,
        unselectedActionColor,
        selectedActionColor,
      );

  EasyDevActionMenuThemeData copyWith({
    Color? backgroundColor,
    Color? tappedColor,
    Color? iconColor,
    double? iconSize,
    EdgeInsets? padding,
    TextStyle? actionStyle,
    BorderRadius? borderRadius,
    Color? unselectedActionColor,
    Color? selectedActionColor,
  }) =>
      EasyDevActionMenuThemeData(
        backgroundColor: backgroundColor ?? this.backgroundColor,
        tappedColor: tappedColor ?? this.tappedColor,
        iconColor: iconColor ?? this.iconColor,
        iconSize: iconSize ?? this.iconSize,
        padding: padding ?? this.padding,
        actionStyle: actionStyle ?? this.actionStyle,
        borderRadius: borderRadius ?? this.borderRadius,
        unselectedActionColor: unselectedActionColor ?? this.unselectedActionColor,
        selectedActionColor: selectedActionColor ?? this.selectedActionColor,
      );
}
