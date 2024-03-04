import 'package:flutter/widgets.dart';

class EasyDevBottomSheetThemeData {
  const EasyDevBottomSheetThemeData({
    this.maxHeight,
    this.minHeight,
    this.backgroundColor,
    this.borderRadius,
    this.dragHandleColor,
    this.elevation,
    this.dragHandleWidth,
    this.dragHandleThickness,
    this.enableDragHandle,
    this.padding,
  });

  final Color? backgroundColor;

  final double? maxHeight;

  final double? minHeight;

  final Color? dragHandleColor;

  final BorderRadius? borderRadius;

  final double? elevation;

  final double? dragHandleWidth;

  final double? dragHandleThickness;

  final bool? enableDragHandle;

  final EdgeInsets? padding;

  @override
  bool operator ==(Object other) =>
      other is EasyDevBottomSheetThemeData &&
      backgroundColor == other.backgroundColor &&
      maxHeight == other.maxHeight &&
      minHeight == other.minHeight &&
      borderRadius == other.borderRadius &&
      dragHandleColor == other.dragHandleColor &&
      elevation == other.elevation &&
      dragHandleWidth == other.dragHandleWidth &&
      dragHandleThickness == other.dragHandleThickness &&
      enableDragHandle == other.enableDragHandle &&
      padding == other.padding;

  @override
  int get hashCode => Object.hash(
        backgroundColor,
        maxHeight,
        minHeight,
        dragHandleColor,
        borderRadius,
        elevation,
        dragHandleWidth,
        dragHandleThickness,
        enableDragHandle,
        padding,
      );

  EasyDevBottomSheetThemeData copyWith({
    Color? backgroundColor,
    double? maxHeight,
    double? minHeight,
    BorderRadius? borderRadius,
    Color? dragHandleColor,
    double? elevation,
    double? dragHandleWidth,
    double? dragHandleThickness,
    bool? enableDragHandle,
    EdgeInsets? padding,
  }) =>
      EasyDevBottomSheetThemeData(
        backgroundColor: backgroundColor ?? this.backgroundColor,
        maxHeight: maxHeight ?? this.maxHeight,
        minHeight: minHeight ?? this.minHeight,
        borderRadius: borderRadius ?? this.borderRadius,
        dragHandleColor: dragHandleColor ?? this.dragHandleColor,
        elevation: elevation ?? this.elevation,
        dragHandleWidth: dragHandleWidth ?? this.dragHandleWidth,
        dragHandleThickness: dragHandleThickness ?? this.dragHandleThickness,
        enableDragHandle: enableDragHandle ?? this.enableDragHandle,
        padding: padding ?? this.padding,
      );
}
