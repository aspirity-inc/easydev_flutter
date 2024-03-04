import 'package:flutter/painting.dart';

class EasyDevSelectablesThemeData {
  const EasyDevSelectablesThemeData({
    this.size,
    this.padding,
    this.selectedColor,
    this.unselectedColor,
    this.disabledColor,
    this.radioType = RadioType.classic,
  });

  final double? size;

  final EdgeInsets? padding;

  final Color? selectedColor;

  final Color? unselectedColor;

  final Color? disabledColor;

  final RadioType radioType;

  @override
  bool operator ==(Object other) =>
      other is EasyDevSelectablesThemeData &&
      size == other.size &&
      padding == other.padding &&
      selectedColor == other.selectedColor &&
      unselectedColor == other.unselectedColor &&
      disabledColor == other.disabledColor &&
      radioType == other.radioType;

  @override
  int get hashCode => Object.hash(
        size,
        padding,
        selectedColor,
        unselectedColor,
        disabledColor,
        radioType,
      );

  EasyDevSelectablesThemeData copyWith({
    double? size,
    EdgeInsets? padding,
    Color? selectedColor,
    Color? unselectedColor,
    Color? disabledColor,
    RadioType? radioType,
  }) =>
      EasyDevSelectablesThemeData(
        size: size ?? this.size,
        padding: padding ?? this.padding,
        selectedColor: selectedColor ?? this.selectedColor,
        unselectedColor: unselectedColor ?? this.unselectedColor,
        disabledColor: disabledColor ?? this.disabledColor,
        radioType: radioType ?? this.radioType,
      );
}

/// Different types of radiobuttons [modern] is looking as wider circle when selected, when
/// unselected [modern] radiobutton looks like thin circle. [classic] radiobutton looks like
/// thin circle and then if it selected, solid circle appears inside it.
enum RadioType {
  classic,
  modern,
}
