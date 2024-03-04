import 'package:flutter/painting.dart';

class EasyDevTabsThemeData {
  const EasyDevTabsThemeData({
    this.selectedIndicator,
    this.unselectedIndicator,
    this.selectedIndicatorColor,
    this.unselectedIndicatorColor,
    this.selectedLabelColor,
    this.unselectedLabelColor,
    this.dividerColor,
    this.selectedLabelStyle,
    this.unselectedLabelStyle,
    this.indicatorWidth,
    this.labelPadding,
  });

  final Decoration? selectedIndicator;

  final Decoration? unselectedIndicator;

  final Color? selectedIndicatorColor;

  final Color? unselectedIndicatorColor;

  final Color? selectedLabelColor;

  final Color? unselectedLabelColor;

  final Color? dividerColor;

  final TextStyle? selectedLabelStyle;

  final TextStyle? unselectedLabelStyle;

  final double? indicatorWidth;

  final EdgeInsets? labelPadding;

  @override
  bool operator ==(Object other) =>
      other is EasyDevTabsThemeData &&
      selectedIndicator == other.selectedIndicator &&
      unselectedIndicator == other.unselectedIndicator &&
      selectedIndicatorColor == other.selectedIndicatorColor &&
      unselectedIndicatorColor == other.unselectedIndicatorColor &&
      selectedLabelColor == other.selectedLabelColor &&
      unselectedLabelColor == other.unselectedLabelColor &&
      dividerColor == other.dividerColor &&
      selectedLabelStyle == other.selectedLabelStyle &&
      unselectedLabelStyle == other.unselectedLabelStyle &&
      indicatorWidth == other.indicatorWidth &&
      labelPadding == other.labelPadding;

  @override
  int get hashCode => Object.hash(
        selectedIndicator,
        unselectedIndicator,
        selectedIndicatorColor,
        unselectedIndicatorColor,
        selectedLabelColor,
        unselectedLabelColor,
        dividerColor,
        selectedLabelStyle,
        unselectedLabelStyle,
        indicatorWidth,
        labelPadding,
      );

  EasyDevTabsThemeData copyWith({
    Decoration? selectedIndicator,
    Decoration? unselectedIndicator,
    Color? selectedIndicatorColor,
    Color? unselectedIndicatorColor,
    Color? selectedLabelColor,
    Color? unselectedLabelColor,
    Color? dividerColor,
    TextStyle? selectedLabelStyle,
    TextStyle? unselectedLabelStyle,
    double? indicatorWidth,
    double? indicatorThickness,
    EdgeInsets? labelPadding,
  }) =>
      EasyDevTabsThemeData(
        selectedIndicator: selectedIndicator ?? this.selectedIndicator,
        unselectedIndicator: unselectedIndicator ?? this.unselectedIndicator,
        selectedIndicatorColor: selectedIndicatorColor ?? this.selectedIndicatorColor,
        unselectedIndicatorColor: unselectedIndicatorColor ?? this.unselectedIndicatorColor,
        selectedLabelColor: selectedLabelColor ?? this.selectedLabelColor,
        unselectedLabelColor: unselectedLabelColor ?? this.unselectedLabelColor,
        dividerColor: dividerColor ?? this.dividerColor,
        selectedLabelStyle: selectedLabelStyle ?? this.selectedLabelStyle,
        unselectedLabelStyle: unselectedLabelStyle ?? this.unselectedLabelStyle,
        indicatorWidth: indicatorWidth ?? this.indicatorWidth,
        labelPadding: labelPadding ?? this.labelPadding,
      );
}
