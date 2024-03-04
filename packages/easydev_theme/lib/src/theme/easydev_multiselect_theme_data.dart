import 'package:flutter/painting.dart';

class EasyDevMultiselectThemeData {
  const EasyDevMultiselectThemeData({
    this.borderRadius,
    this.backgroundColor,
    this.selectedColor,
    this.dividerColor,
    this.disabledColor,
    this.iconColor,
    this.itemPadding,
    this.scrollbarColor,
    this.textColor,
    this.selectedTextColor,
    this.disabledTextColor,
    this.textStyle,
    this.bottomSheetTitleStyle,
  });

  final BorderRadius? borderRadius;

  final Color? backgroundColor;

  final Color? selectedColor;

  final Color? dividerColor;

  final Color? disabledColor;

  final Color? iconColor;

  final EdgeInsets? itemPadding;

  final Color? scrollbarColor;

  final Color? textColor;

  final Color? selectedTextColor;

  final Color? disabledTextColor;

  final TextStyle? textStyle;

  final TextStyle? bottomSheetTitleStyle;

  @override
  bool operator ==(Object other) =>
      other is EasyDevMultiselectThemeData &&
      borderRadius == other.borderRadius &&
      backgroundColor == other.backgroundColor &&
      selectedColor == other.selectedColor &&
      dividerColor == other.dividerColor &&
      disabledColor == other.disabledColor &&
      iconColor == other.iconColor &&
      itemPadding == other.itemPadding &&
      scrollbarColor == other.scrollbarColor &&
      textColor == other.textColor &&
      selectedTextColor == other.selectedTextColor &&
      disabledTextColor == other.disabledTextColor &&
      textStyle == other.textStyle &&
      bottomSheetTitleStyle == other.bottomSheetTitleStyle;

  @override
  int get hashCode => Object.hash(
        borderRadius,
        backgroundColor,
        selectedColor,
        dividerColor,
        disabledColor,
        iconColor,
        itemPadding,
        scrollbarColor,
        textColor,
        selectedTextColor,
        disabledTextColor,
        textStyle,
        bottomSheetTitleStyle,
      );

  EasyDevMultiselectThemeData copyWith({
    BorderRadius? borderRadius,
    Color? backgroundColor,
    Color? selectedColor,
    Color? dividerColor,
    Color? disabledColor,
    Color? iconColor,
    EdgeInsets? itemPadding,
    Color? scrollbarColor,
    Color? textColor,
    Color? selectedTextColor,
    Color? disabledTextColor,
    TextStyle? textStyle,
    TextStyle? bottomSheetTitleStyle,
  }) =>
      EasyDevMultiselectThemeData(
        borderRadius: borderRadius ?? this.borderRadius,
        backgroundColor: backgroundColor ?? this.backgroundColor,
        selectedColor: selectedColor ?? this.selectedColor,
        dividerColor: dividerColor ?? this.dividerColor,
        disabledColor: disabledColor ?? this.disabledColor,
        iconColor: iconColor ?? this.iconColor,
        itemPadding: itemPadding ?? this.itemPadding,
        scrollbarColor: scrollbarColor ?? this.scrollbarColor,
        textColor: textColor ?? this.textColor,
        selectedTextColor: selectedTextColor ?? this.selectedTextColor,
        disabledTextColor: disabledTextColor ?? this.disabledTextColor,
        textStyle: textStyle ?? this.textStyle,
        bottomSheetTitleStyle: bottomSheetTitleStyle ?? this.bottomSheetTitleStyle,
      );
}
