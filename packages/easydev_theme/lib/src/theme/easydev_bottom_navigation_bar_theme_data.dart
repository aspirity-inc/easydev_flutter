import 'package:flutter/painting.dart';

class EasyDevBottomNavigationBarThemeData {
  const EasyDevBottomNavigationBarThemeData({
    this.backgroundColor,
    this.selectedLabelTextStyle,
    this.unselectedLabelTextStyle,
    this.unselectedIconColor,
    this.selectedIconColor,
    this.unselectedLabelColor,
    this.selectedLabelColor,
    this.shadowColor,
    this.indicatorColor,
    this.showLabel = ShowLabel.always,
    this.alignment = BottomNavigationBarItemAlignment.allExpanded,
    this.iconSize,
    this.padding,
    this.margin,
    this.radius,
    this.elevation,
  });

  final Color? backgroundColor;

  final TextStyle? selectedLabelTextStyle;

  final TextStyle? unselectedLabelTextStyle;

  final Color? unselectedIconColor;

  final Color? selectedIconColor;

  final Color? unselectedLabelColor;

  final Color? selectedLabelColor;

  final Color? shadowColor;

  final Color? indicatorColor;

  final ShowLabel showLabel;

  final BottomNavigationBarItemAlignment alignment;

  final double? iconSize;

  final EdgeInsets? padding;

  final EdgeInsets? margin;

  final BorderRadius? radius;

  final double? elevation;

  @override
  bool operator ==(Object other) =>
      other is EasyDevBottomNavigationBarThemeData &&
      backgroundColor == other.backgroundColor &&
      selectedLabelTextStyle == other.selectedLabelTextStyle &&
      unselectedLabelTextStyle == other.unselectedLabelTextStyle &&
      unselectedIconColor == other.unselectedIconColor &&
      selectedIconColor == other.selectedIconColor &&
      unselectedLabelColor == other.unselectedLabelColor &&
      selectedLabelColor == other.selectedLabelColor &&
      shadowColor == other.shadowColor &&
      indicatorColor == other.indicatorColor &&
      showLabel == other.showLabel &&
      alignment == other.alignment &&
      iconSize == other.iconSize &&
      padding == other.padding &&
      margin == other.margin &&
      radius == other.radius &&
      elevation == other.elevation;

  @override
  int get hashCode => Object.hash(
        backgroundColor,
        selectedLabelTextStyle,
        unselectedLabelTextStyle,
        unselectedIconColor,
        selectedIconColor,
        unselectedLabelColor,
        selectedLabelColor,
        shadowColor,
        indicatorColor,
        showLabel,
        alignment,
        iconSize,
        padding,
        margin,
        radius,
        elevation,
      );

  EasyDevBottomNavigationBarThemeData copyWith({
    Color? backgroundColor,
    TextStyle? selectedLabelTextStyle,
    TextStyle? unselectedLabelTextStyle,
    Color? unselectedIconColor,
    Color? selectedIconColor,
    Color? unselectedLabelColor,
    Color? selectedLabelColor,
    Color? shadowColor,
    Color? indicatorColor,
    ShowLabel? showLabel,
    BottomNavigationBarItemAlignment? alignment,
    double? iconSize,
    EdgeInsets? padding,
    EdgeInsets? margin,
    BorderRadius? radius,
    double? elevation,
  }) =>
      EasyDevBottomNavigationBarThemeData(
        backgroundColor: backgroundColor ?? this.backgroundColor,
        selectedLabelTextStyle: selectedLabelTextStyle ?? this.selectedLabelTextStyle,
        unselectedLabelTextStyle: unselectedLabelTextStyle ?? this.unselectedLabelTextStyle,
        unselectedIconColor: unselectedIconColor ?? this.unselectedIconColor,
        selectedIconColor: selectedIconColor ?? this.selectedIconColor,
        unselectedLabelColor: unselectedLabelColor ?? this.unselectedLabelColor,
        selectedLabelColor: selectedLabelColor ?? this.selectedLabelColor,
        shadowColor: shadowColor ?? this.shadowColor,
        indicatorColor: indicatorColor ?? this.indicatorColor,
        showLabel: showLabel ?? this.showLabel,
        alignment: alignment ?? this.alignment,
        iconSize: iconSize ?? this.iconSize,
        padding: padding ?? this.padding,
        margin: margin ?? this.margin,
        radius: radius ?? this.radius,
        elevation: elevation ?? this.elevation,
      );
}

enum ShowLabel {
  always,
  selected,
  unselected,
  never,
}

enum BottomNavigationBarItemAlignment {
  center,
  start,
  end,
  spaceEvenly,
  spaceBetween,
  spaceAround,
  allExpanded,
}
