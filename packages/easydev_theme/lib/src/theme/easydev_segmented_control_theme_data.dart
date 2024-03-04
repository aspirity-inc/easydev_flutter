import 'package:flutter/painting.dart';

class EasyDevSegmentedControlThemeData {
  const EasyDevSegmentedControlThemeData({
    this.selectedTabColor,
    this.unselectedTabColor,
    this.selectedLabelColor,
    this.unselectedLabelColor,
    this.tabWidth,
    this.tabThickness,
    this.padding,
    this.tabsBorderRadius,
  });

  final Color? selectedTabColor;

  final Color? unselectedTabColor;

  final Color? selectedLabelColor;

  final Color? unselectedLabelColor;

  final double? tabWidth;

  final double? tabThickness;

  final EdgeInsets? padding;

  final BorderRadius? tabsBorderRadius;

  @override
  bool operator ==(Object other) =>
      other is EasyDevSegmentedControlThemeData &&
      selectedTabColor == other.selectedTabColor &&
      unselectedTabColor == other.unselectedTabColor &&
      selectedLabelColor == other.selectedLabelColor &&
      unselectedLabelColor == other.unselectedLabelColor &&
      tabWidth == other.tabWidth &&
      tabThickness == other.tabThickness &&
      padding == other.padding &&
      tabsBorderRadius == other.tabsBorderRadius;

  @override
  int get hashCode => Object.hash(
        selectedTabColor,
        unselectedTabColor,
        selectedLabelColor,
        unselectedLabelColor,
        tabWidth,
        tabThickness,
        padding,
        tabsBorderRadius,
      );

  EasyDevSegmentedControlThemeData copyWith({
    Color? selectedTabColor,
    Color? unselectedTabColor,
    Color? selectedLabelColor,
    Color? unselectedLabelColor,
    double? tabWidth,
    double? tabThickness,
    EdgeInsets? padding,
    BorderRadius? tabsBorderRadius,
  }) =>
      EasyDevSegmentedControlThemeData(
        selectedTabColor: selectedTabColor ?? this.selectedTabColor,
        unselectedTabColor: unselectedTabColor ?? this.unselectedTabColor,
        selectedLabelColor: selectedLabelColor ?? this.selectedLabelColor,
        unselectedLabelColor: unselectedLabelColor ?? this.unselectedLabelColor,
        tabWidth: tabWidth ?? this.tabWidth,
        tabThickness: tabThickness ?? this.tabThickness,
        padding: padding ?? this.padding,
        tabsBorderRadius: tabsBorderRadius ?? this.tabsBorderRadius,
      );
}
