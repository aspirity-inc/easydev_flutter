import 'package:easydev_forms/easydev_forms.dart';
import 'package:flutter/painting.dart';

/// [MultiselectDecoration] is class containing [EasyDevMultiSelect] style properties:
/// [Color]s, [TextStyle]s, [BorderRadius] and [EdgeInsets] item padding.
class MultiselectDecoration {
  const MultiselectDecoration({
    required this.borderRadius,
    required this.backgroundColor,
    required this.selectedColor,
    required this.dividerColor,
    required this.disabledColor,
    required this.iconColor,
    required this.itemPadding,
    required this.scrollbarColor,
    required this.textColor,
    required this.selectedTextColor,
    required this.disabledTextColor,
    required this.textStyle,
    required this.bottomSheetTitleStyle,
  });

  final BorderRadius borderRadius;

  final Color backgroundColor;

  final Color selectedColor;

  final Color dividerColor;

  final Color disabledColor;

  final Color iconColor;

  final EdgeInsets itemPadding;

  final Color scrollbarColor;

  final Color textColor;

  final Color selectedTextColor;

  final Color disabledTextColor;

  final TextStyle textStyle;

  final TextStyle bottomSheetTitleStyle;

  @override
  bool operator ==(Object other) =>
      other is MultiselectDecoration &&
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

  MultiselectDecoration copyWith({
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
      MultiselectDecoration(
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
