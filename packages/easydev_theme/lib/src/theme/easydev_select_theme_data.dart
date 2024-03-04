import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';

class EasyDevSelectThemeData {
  const EasyDevSelectThemeData({
    this.borderRadius,
    this.backgroundColor,
    this.tappedColor,
    this.activeBorderColor,
    this.borderColor,
    this.disabledBorderColor,
    this.dividerColor,
    this.selectedItemColor,
    this.itemPadding,
    this.scrollbarColor,
    this.textColor,
    this.unselectedTextColor,
    this.selectedTextColor,
    this.disabledTextColor,
    this.tappedTextColor,
    this.textStyle,
    this.bottomSheetTitleStyle,
  });

  final BorderRadius? borderRadius;

  final Color? backgroundColor;

  final Color? tappedColor;

  final Color? activeBorderColor;

  final Color? borderColor;

  final Color? disabledBorderColor;

  final Color? dividerColor;

  final Color? selectedItemColor;

  final EdgeInsets? itemPadding;

  final Color? scrollbarColor;

  final Color? textColor;

  final Color? unselectedTextColor;

  final Color? selectedTextColor;

  final Color? disabledTextColor;

  final Color? tappedTextColor;

  final TextStyle? textStyle;

  final TextStyle? bottomSheetTitleStyle;

  @override
  bool operator ==(Object other) =>
      other is EasyDevSelectThemeData &&
      borderRadius == other.borderRadius &&
      backgroundColor == other.backgroundColor &&
      tappedColor == other.tappedColor &&
      activeBorderColor == other.activeBorderColor &&
      borderColor == other.borderColor &&
      activeBorderColor == other.activeBorderColor &&
      dividerColor == other.dividerColor &&
      selectedItemColor == other.selectedItemColor &&
      itemPadding == other.itemPadding &&
      scrollbarColor == other.scrollbarColor &&
      textColor == other.textColor &&
      unselectedTextColor == other.unselectedTextColor &&
      selectedTextColor == other.selectedTextColor &&
      disabledTextColor == other.disabledTextColor &&
      tappedTextColor == other.tappedTextColor &&
      textStyle == other.textStyle &&
      bottomSheetTitleStyle == other.bottomSheetTitleStyle;

  @override
  int get hashCode => Object.hash(
        borderRadius,
        backgroundColor,
        tappedColor,
        activeBorderColor,
        borderColor,
        disabledBorderColor,
        dividerColor,
        selectedItemColor,
        itemPadding,
        scrollbarColor,
        textColor,
        unselectedTextColor,
        selectedTextColor,
        disabledTextColor,
        tappedTextColor,
        textStyle,
        bottomSheetTitleStyle,
      );

  EasyDevSelectThemeData copyWith({
    BorderRadius? borderRadius,
    Color? backgroundColor,
    Color? tappedColor,
    Color? activeBorderColor,
    Color? borderColor,
    Color? disabledBorderColor,
    Color? dividerColor,
    Color? selectedItemColor,
    double? width,
    EdgeInsets? itemPadding,
    EdgeInsets? padding,
    Color? scrollbarColor,
    Color? textColor,
    Color? unselectedTextColor,
    Color? selectedTextColor,
    Color? disabledTextColor,
    Color? tappedTextColor,
    TextStyle? textStyle,
    TextStyle? bottomSheetTitleStyle,
  }) =>
      EasyDevSelectThemeData(
        borderRadius: borderRadius ?? this.borderRadius,
        backgroundColor: backgroundColor ?? this.backgroundColor,
        tappedColor: tappedColor ?? this.tappedColor,
        activeBorderColor: activeBorderColor ?? this.activeBorderColor,
        borderColor: borderColor ?? this.borderColor,
        disabledBorderColor: disabledBorderColor ?? this.disabledBorderColor,
        dividerColor: dividerColor ?? this.dividerColor,
        selectedItemColor: selectedItemColor ?? this.selectedItemColor,
        itemPadding: itemPadding ?? this.itemPadding,
        scrollbarColor: scrollbarColor ?? this.scrollbarColor,
        textColor: textColor ?? this.textColor,
        unselectedTextColor: unselectedTextColor ?? this.unselectedTextColor,
        selectedTextColor: selectedTextColor ?? this.selectedTextColor,
        disabledTextColor: disabledTextColor ?? this.disabledTextColor,
        tappedTextColor: tappedTextColor ?? this.tappedTextColor,
        textStyle: textStyle ?? this.textStyle,
        bottomSheetTitleStyle: bottomSheetTitleStyle ?? this.bottomSheetTitleStyle,
      );
}
