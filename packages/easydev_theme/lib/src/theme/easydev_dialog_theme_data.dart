import 'package:easydev_theme/src/theme/dialog_background_mode.dart';
import 'package:flutter/painting.dart';

class EasyDevDialogThemeData {
  const EasyDevDialogThemeData({
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.borderRadius,
    this.titleTextStyle,
    this.subtitleTextStyle,
    this.backgroundColor,
    this.dismissable,
    this.swipeable,
    this.elevation,
    this.outOfDialogColor,
    this.dialogBackgroundMode = DialogBackgroundMode.blur,
  });

  final EdgeInsets? padding;

  final EdgeInsets? margin;

  final double? width;

  final double? height;

  final BorderRadius? borderRadius;

  final TextStyle? titleTextStyle;

  final TextStyle? subtitleTextStyle;

  final Color? backgroundColor;

  final bool? dismissable;

  final bool? swipeable;

  final double? elevation;

  final Color? outOfDialogColor;

  final DialogBackgroundMode dialogBackgroundMode;

  @override
  bool operator ==(Object other) =>
      other is EasyDevDialogThemeData &&
      padding == other.padding &&
      margin == other.margin &&
      width == other.width &&
      height == other.height &&
      borderRadius == other.borderRadius &&
      titleTextStyle == other.titleTextStyle &&
      subtitleTextStyle == other.subtitleTextStyle &&
      backgroundColor == other.backgroundColor &&
      dismissable == other.dismissable &&
      swipeable == other.swipeable &&
      elevation == other.elevation &&
      outOfDialogColor == other.outOfDialogColor &&
      dialogBackgroundMode == other.dialogBackgroundMode;

  @override
  int get hashCode => Object.hash(
        padding,
        margin,
        width,
        height,
        borderRadius,
        titleTextStyle,
        subtitleTextStyle,
        backgroundColor,
        dismissable,
        swipeable,
        elevation,
        outOfDialogColor,
        dialogBackgroundMode,
      );

  EasyDevDialogThemeData copyWith({
    EdgeInsets? padding,
    EdgeInsets? margin,
    double? width,
    double? height,
    BorderRadius? borderRadius,
    TextStyle? titleTextStyle,
    TextStyle? subtitleTextStyle,
    Color? backgroundColor,
    bool? dismissable,
    bool? swipeable,
    double? elevation,
    Color? outOfDialogColor,
    DialogBackgroundMode? dialogBackgroundMode,
  }) =>
      EasyDevDialogThemeData(
        padding: padding ?? this.padding,
        margin: margin ?? this.margin,
        width: width ?? this.width,
        height: height ?? this.height,
        borderRadius: borderRadius ?? this.borderRadius,
        titleTextStyle: titleTextStyle ?? this.titleTextStyle,
        subtitleTextStyle: subtitleTextStyle ?? this.subtitleTextStyle,
        backgroundColor: backgroundColor ?? this.backgroundColor,
        dismissable: dismissable ?? this.dismissable,
        swipeable: swipeable ?? this.swipeable,
        elevation: elevation ?? this.elevation,
        outOfDialogColor: outOfDialogColor ?? this.outOfDialogColor,
        dialogBackgroundMode: dialogBackgroundMode ?? this.dialogBackgroundMode,
      );
}
