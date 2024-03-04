import 'package:flutter/painting.dart';

class EasyDevSwitchThemeData {
  const EasyDevSwitchThemeData({
    this.pinType = PinType.neutral,
    this.padding,
    this.selectedTrackColor,
    this.selectedKnobColor,
    this.unselectedTrackColor,
    this.unselectedKnobColor,
    this.disabledTrackColor,
    this.disabledKnobColor,
    this.width,
    this.height,
  });

  final PinType pinType;

  final EdgeInsets? padding;

  final Color? selectedTrackColor;

  final Color? selectedKnobColor;

  final Color? unselectedTrackColor;

  final Color? unselectedKnobColor;

  final Color? disabledTrackColor;

  final Color? disabledKnobColor;

  final double? width;

  final double? height;

  @override
  bool operator ==(Object other) =>
      other is EasyDevSwitchThemeData &&
      runtimeType == other.runtimeType &&
      pinType == other.pinType &&
      padding == other.padding &&
      selectedTrackColor == other.selectedTrackColor &&
      selectedKnobColor == other.selectedKnobColor &&
      unselectedTrackColor == other.unselectedTrackColor &&
      unselectedKnobColor == other.unselectedKnobColor &&
      disabledTrackColor == other.disabledTrackColor &&
      disabledKnobColor == other.disabledKnobColor &&
      width == other.width &&
      height == other.height;

  @override
  int get hashCode => Object.hash(
        pinType,
        padding,
        selectedTrackColor,
        selectedKnobColor,
        unselectedTrackColor,
        unselectedKnobColor,
        disabledTrackColor,
        disabledKnobColor,
        width,
        height,
      );

  EasyDevSwitchThemeData copyWith({
    PinType? pinType,
    EdgeInsets? padding,
    Color? selectedTrackColor,
    Color? selectedKnobColor,
    Color? unselectedTrackColor,
    Color? unselectedKnobColor,
    Color? disabledTrackColor,
    Color? disabledKnobColor,
    double? width,
    double? height,
  }) {
    return EasyDevSwitchThemeData(
      pinType: pinType ?? this.pinType,
      padding: padding ?? this.padding,
      selectedTrackColor: selectedTrackColor ?? this.selectedTrackColor,
      selectedKnobColor: selectedKnobColor ?? this.selectedKnobColor,
      unselectedTrackColor: unselectedTrackColor ?? this.unselectedTrackColor,
      unselectedKnobColor: unselectedKnobColor ?? this.unselectedKnobColor,
      disabledTrackColor: disabledTrackColor ?? this.disabledTrackColor,
      disabledKnobColor: disabledKnobColor ?? this.disabledKnobColor,
      width: width ?? this.width,
      height: height ?? this.height,
    );
  }
}

enum PinType {
  ios,
  android,
  neutral,
}
