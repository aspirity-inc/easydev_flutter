import 'package:flutter/painting.dart';

class EasyDevSliderThemeData {
  const EasyDevSliderThemeData({
    this.handleColor,
    this.showEdgeValues,
    this.showTooltip,
    this.showButtons,
    this.padding,
    this.buttonSpacing,
    this.buttonSize,
    this.disabledColor,
    this.tooltipColor,
    this.tooltipTextColor,
    this.buttonsColor,
    this.selectedTrackColor,
    this.unselectedTrackColor,
    this.sliderTrackThickness,
    this.sliderHandleSize,
    this.sliderHandleWidth,
  });

  final Color? handleColor;

  final bool? showEdgeValues;

  final bool? showTooltip;

  final bool? showButtons;

  final EdgeInsets? padding;

  final double? buttonSpacing;

  final double? buttonSize;

  final Color? disabledColor;

  final Color? tooltipColor;

  final Color? tooltipTextColor;

  final Color? buttonsColor;

  final Color? selectedTrackColor;

  final Color? unselectedTrackColor;

  final double? sliderTrackThickness;

  final double? sliderHandleSize;

  final double? sliderHandleWidth;

  @override
  bool operator ==(Object other) =>
      other is EasyDevSliderThemeData &&
      handleColor == other.handleColor &&
      showEdgeValues == other.showEdgeValues &&
      showTooltip == other.showTooltip &&
      showButtons == other.showButtons &&
      padding == other.padding &&
      buttonSpacing == other.buttonSpacing &&
      buttonSize == other.buttonSize &&
      disabledColor == other.disabledColor &&
      tooltipColor == other.tooltipColor &&
      tooltipTextColor == other.tooltipTextColor &&
      buttonsColor == other.buttonsColor &&
      selectedTrackColor == other.selectedTrackColor &&
      unselectedTrackColor == other.unselectedTrackColor &&
      sliderTrackThickness == other.sliderTrackThickness &&
      sliderHandleSize == other.sliderHandleSize &&
      sliderHandleWidth == other.sliderHandleWidth;

  @override
  int get hashCode => Object.hash(
        handleColor,
        showEdgeValues,
        showTooltip,
        showButtons,
        padding,
        buttonSpacing,
        buttonSize,
        disabledColor,
        tooltipColor,
        tooltipTextColor,
        buttonsColor,
        selectedTrackColor,
        unselectedTrackColor,
        sliderTrackThickness,
        sliderHandleSize,
        sliderHandleWidth,
      );

  EasyDevSliderThemeData copyWith({
    Color? handleColor,
    bool? showEdgeValues,
    bool? showTooltip,
    bool? showButtons,
    EdgeInsets? padding,
    double? buttonSpacing,
    double? buttonSize,
    Color? disabledColor,
    Color? tooltipColor,
    Color? tooltipTextColor,
    Color? buttonsColor,
    Color? selectedTrackColor,
    Color? unselectedTrackColor,
    double? sliderTrackThickness,
    double? sliderHandleSize,
    double? sliderHandleWidth,
  }) =>
      EasyDevSliderThemeData(
        handleColor: handleColor ?? this.handleColor,
        showEdgeValues: showEdgeValues ?? this.showEdgeValues,
        showTooltip: showTooltip ?? this.showTooltip,
        showButtons: showButtons ?? this.showButtons,
        padding: padding ?? this.padding,
        buttonSpacing: buttonSpacing ?? this.buttonSpacing,
        buttonSize: buttonSize ?? this.buttonSize,
        disabledColor: disabledColor ?? this.disabledColor,
        tooltipColor: tooltipColor ?? this.tooltipColor,
        tooltipTextColor: tooltipTextColor ?? this.tooltipTextColor,
        buttonsColor: buttonsColor ?? this.buttonsColor,
        selectedTrackColor: selectedTrackColor ?? this.selectedTrackColor,
        unselectedTrackColor: unselectedTrackColor ?? this.unselectedTrackColor,
        sliderTrackThickness: sliderTrackThickness ?? this.sliderTrackThickness,
        sliderHandleSize: sliderHandleSize ?? this.sliderHandleSize,
        sliderHandleWidth: sliderHandleWidth ?? this.sliderHandleWidth,
      );
}
