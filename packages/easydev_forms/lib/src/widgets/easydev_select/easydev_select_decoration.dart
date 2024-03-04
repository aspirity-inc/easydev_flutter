import 'package:easydev_forms/easydev_forms.dart';
import 'package:flutter/widgets.dart';

/// [EasyDevSelectDecoration] is class containing [EasyDevSelect] style properties:
/// [Color]s, [TextStyle]s, [BorderRadius] and [EdgeInsets] item padding.
class EasyDevSelectDecoration {
  EasyDevSelectDecoration({
    required this.borderRadius,
    required this.backgroundColor,
    required this.tappedColor,
    required this.disabledColor,
    required this.dividerColor,
    required this.barrierColor,
    required this.activeBorderColor,
    required this.borderColor,
    required this.scrollbarColor,
    required this.iconColor,
    required this.itemPadding,
    required this.textColor,
    required this.selectedTextColor,
    required this.disabledTextColor,
    required this.unselectedTextColor,
    required this.tappedTextColor,
    required this.textStyle,
  });

  final BorderRadius borderRadius;

  final Color backgroundColor;

  final Color tappedColor;

  final Color disabledColor;

  final Color dividerColor;

  final Color barrierColor;

  final Color activeBorderColor;

  final Color borderColor;

  final Color scrollbarColor;

  final Color iconColor;

  final EdgeInsets itemPadding;

  final Color textColor;

  final Color unselectedTextColor;

  final Color selectedTextColor;

  final Color disabledTextColor;

  final Color tappedTextColor;

  final TextStyle textStyle;

  @override
  bool operator ==(Object other) =>
      other is EasyDevSelectDecoration &&
      borderRadius == other.borderRadius &&
      backgroundColor == other.backgroundColor &&
      tappedColor == other.tappedColor &&
      disabledColor == other.disabledColor &&
      dividerColor == other.dividerColor &&
      barrierColor == other.barrierColor &&
      activeBorderColor == other.activeBorderColor &&
      borderColor == other.borderColor &&
      scrollbarColor == other.scrollbarColor &&
      iconColor == other.iconColor &&
      itemPadding == other.itemPadding &&
      textColor == other.textColor &&
      unselectedTextColor == other.unselectedTextColor &&
      selectedTextColor == other.selectedTextColor &&
      disabledTextColor == other.disabledTextColor &&
      tappedTextColor == other.tappedTextColor &&
      textStyle == other.textStyle;

  @override
  int get hashCode => Object.hash(
        borderRadius,
        backgroundColor,
        tappedColor,
        disabledColor,
        dividerColor,
        barrierColor,
        activeBorderColor,
        borderColor,
        scrollbarColor,
        iconColor,
        itemPadding,
        textColor,
        unselectedTextColor,
        selectedTextColor,
        disabledTextColor,
        tappedTextColor,
        textStyle,
      );

  EasyDevSelectDecoration copyWith({
    BorderRadius? borderRadius,
    Color? backgroundColor,
    Color? tappedColor,
    Color? disabledColor,
    Color? dividerColor,
    Color? barrierColor,
    Color? activeBorderColor,
    Color? borderColor,
    Color? scrollbarColor,
    Color? iconColor,
    EdgeInsets? itemPadding,
    Color? textColor,
    Color? unselectedTextColor,
    Color? selectedTextColor,
    Color? disabledTextColor,
    Color? tappedTextColor,
    TextStyle? textStyle,
  }) =>
      EasyDevSelectDecoration(
        borderRadius: borderRadius ?? this.borderRadius,
        backgroundColor: backgroundColor ?? this.backgroundColor,
        tappedColor: tappedColor ?? this.tappedColor,
        disabledColor: disabledColor ?? this.disabledColor,
        dividerColor: dividerColor ?? this.dividerColor,
        barrierColor: barrierColor ?? this.barrierColor,
        activeBorderColor: activeBorderColor ?? this.activeBorderColor,
        borderColor: borderColor ?? this.borderColor,
        scrollbarColor: scrollbarColor ?? this.scrollbarColor,
        iconColor: iconColor ?? this.iconColor,
        itemPadding: itemPadding ?? this.itemPadding,
        textColor: textColor ?? this.textColor,
        unselectedTextColor: unselectedTextColor ?? this.unselectedTextColor,
        selectedTextColor: selectedTextColor ?? this.selectedTextColor,
        disabledTextColor: disabledTextColor ?? this.disabledTextColor,
        tappedTextColor: tappedTextColor ?? this.tappedTextColor,
        textStyle: textStyle ?? this.textStyle,
      );
}
