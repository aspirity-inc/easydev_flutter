import 'package:flutter/painting.dart';

class EasyDevAutocompleteThemeData {
  const EasyDevAutocompleteThemeData({
    this.borderRadius,
    this.backgroundColor,
    this.dividerColor,
    this.disabledColor,
    this.selectedItemColor,
    this.maxHeight,
    this.itemHeight,
    this.itemBorderRadius,
    this.width,
    this.itemPadding,
    this.textColor,
    this.iconColor,
    this.selectedTextColor,
    this.shrink,
  });

  final BorderRadius? borderRadius;

  final Color? backgroundColor;

  final Color? dividerColor;

  final Color? disabledColor;

  final Color? selectedItemColor;

  final double? maxHeight;

  final double? itemHeight;

  final BorderRadius? itemBorderRadius;

  final double? width;

  final EdgeInsets? itemPadding;

  final Color? textColor;

  final Color? iconColor;

  final Color? selectedTextColor;

  final bool? shrink;

  @override
  bool operator ==(Object other) =>
      other is EasyDevAutocompleteThemeData &&
      borderRadius == other.borderRadius &&
      backgroundColor == other.backgroundColor &&
      dividerColor == other.dividerColor &&
      disabledColor == other.disabledColor &&
      selectedItemColor == other.selectedItemColor &&
      maxHeight == other.maxHeight &&
      itemHeight == other.itemHeight &&
      itemBorderRadius == other.itemBorderRadius &&
      width == other.width &&
      itemPadding == other.itemPadding &&
      textColor == other.textColor &&
      iconColor == other.iconColor &&
      itemPadding == other.itemPadding &&
      textColor == other.textColor &&
      iconColor == other.iconColor &&
      selectedTextColor == other.selectedTextColor &&
      shrink == other.shrink;

  @override
  int get hashCode => Object.hash(
        borderRadius,
        backgroundColor,
        dividerColor,
        disabledColor,
        selectedItemColor,
        maxHeight,
        itemHeight,
        itemBorderRadius,
        width,
        itemPadding,
        textColor,
        iconColor,
        selectedTextColor,
        shrink,
      );

  EasyDevAutocompleteThemeData copyWith({
    BorderRadius? borderRadius,
    Color? backgroundColor,
    Color? dividerColor,
    Color? disabledColor,
    Color? selectedItemColor,
    double? maxHeight,
    double? itemHeight,
    BorderRadius? itemBorderRadius,
    double? width,
    EdgeInsets? itemPadding,
    Color? textColor,
    Color? iconColor,
    Color? selectedTextColor,
    bool? shrink,
  }) =>
      EasyDevAutocompleteThemeData(
        borderRadius: borderRadius ?? this.borderRadius,
        backgroundColor: backgroundColor ?? this.backgroundColor,
        dividerColor: dividerColor ?? this.dividerColor,
        disabledColor: disabledColor ?? this.disabledColor,
        selectedItemColor: selectedItemColor ?? this.selectedItemColor,
        maxHeight: maxHeight ?? this.maxHeight,
        itemHeight: itemHeight ?? this.itemHeight,
        itemBorderRadius: itemBorderRadius ?? this.itemBorderRadius,
        width: width ?? this.width,
        itemPadding: itemPadding ?? this.itemPadding,
        textColor: textColor ?? this.textColor,
        iconColor: iconColor ?? this.iconColor,
        selectedTextColor: selectedTextColor ?? this.selectedTextColor,
        shrink: shrink ?? this.shrink,
      );
}
