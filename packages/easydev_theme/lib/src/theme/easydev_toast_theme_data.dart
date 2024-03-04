import 'package:flutter/painting.dart';

class EasyDevToastThemeData {
  const EasyDevToastThemeData({
    this.padding,
    this.margin,
    this.multilineToastPadding,
    this.alignment,
    this.iconSpacing,
    this.textSpacing,
    this.height,
    this.width,
    this.closeByDragging,
    this.closeButton,
    this.duration,
    this.titleStyle,
    this.subtitleStyle,
    this.toastColor,
  });

  final EdgeInsets? padding;

  final EdgeInsets? multilineToastPadding;

  final EdgeInsets? margin;

  final Alignment? alignment;

  final double? iconSpacing;

  final double? textSpacing;

  final double? height;

  final double? width;

  final bool? closeByDragging;

  final bool? closeButton;

  final Duration? duration;

  final TextStyle? titleStyle;

  final TextStyle? subtitleStyle;

  final Color? toastColor;

  @override
  bool operator ==(Object other) =>
      other is EasyDevToastThemeData &&
      padding == other.padding &&
      multilineToastPadding == other.multilineToastPadding &&
      margin == other.margin &&
      alignment == other.alignment &&
      textSpacing == other.textSpacing &&
      iconSpacing == other.iconSpacing &&
      height == other.height &&
      width == other.width &&
      closeByDragging == other.closeByDragging &&
      closeButton == other.closeButton &&
      duration == other.duration &&
      titleStyle == other.titleStyle &&
      subtitleStyle == other.subtitleStyle &&
      toastColor == other.toastColor;

  @override
  int get hashCode => Object.hash(
        padding,
        multilineToastPadding,
        margin,
        alignment,
        iconSpacing,
        textSpacing,
        height,
        width,
        closeByDragging,
        closeButton,
        duration,
        titleStyle,
        subtitleStyle,
        toastColor,
      );

  EasyDevToastThemeData copyWith({
    EdgeInsets? padding,
    EdgeInsets? multilineToastPadding,
    EdgeInsets? margin,
    Alignment? alignment,
    double? iconSpacing,
    double? textSpacing,
    double? height,
    double? width,
    bool? closeByDragging,
    bool? closeButton,
    Duration? duration,
    TextStyle? titleStyle,
    TextStyle? subtitleStyle,
    Color? toastColor,
  }) =>
      EasyDevToastThemeData(
        padding: padding ?? this.padding,
        multilineToastPadding: multilineToastPadding ?? this.multilineToastPadding,
        margin: margin ?? this.margin,
        alignment: alignment ?? this.alignment,
        iconSpacing: iconSpacing ?? this.iconSpacing,
        textSpacing: textSpacing ?? this.textSpacing,
        height: height ?? this.height,
        width: width ?? this.width,
        closeByDragging: closeByDragging ?? this.closeByDragging,
        closeButton: closeButton ?? this.closeButton,
        duration: duration ?? this.duration,
        titleStyle: titleStyle ?? this.titleStyle,
        subtitleStyle: subtitleStyle ?? this.subtitleStyle,
        toastColor: toastColor ?? this.toastColor,
      );
}
