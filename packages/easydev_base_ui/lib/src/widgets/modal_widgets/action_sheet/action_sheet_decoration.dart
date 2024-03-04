import 'package:flutter/widgets.dart';

/// Decoration of [EasyDevActionSheet].
class ActionSheetDecoration {
  ActionSheetDecoration({
    required this.backgroundColor,
    required this.tappedColor,
    required this.iconColor,
    required this.iconSize,
    required this.iconSpacing,
    required this.padding,
    required this.titleStyle,
    required this.actionStyle,
    required this.borderRadius,
    required this.modalRadius,
  });

  /// Background color of upper element of [EasyDevActionSheet],
  /// [CancelActionSheetButton] and [EasyDevActionSheetItem].
  final Color backgroundColor;

  /// Color of upper element of [EasyDevActionSheet], [CancelActionSheetButton]
  /// and [EasyDevActionSheetItem] when they are tapped.
  final Color tappedColor;

  /// Color of icons of upper element of [EasyDevActionSheet],
  ///  [CancelActionSheetButton] and [EasyDevActionSheetItem].
  final Color iconColor;

  /// Size of icons of upper element of [EasyDevActionSheet],
  /// [CancelActionSheetButton] and [EasyDevActionSheetItem].
  final double iconSize;

  /// Spacing of icons of upper element of [EasyDevActionSheet],
  /// [CancelActionSheetButton] [EasyDevActionSheetItem].
  final double iconSpacing;

  /// Padding of upper element of [EasyDevActionSheet],
  /// [CancelActionSheetButton] and [EasyDevActionSheetItem].
  final EdgeInsets padding;

  /// TextStyle used in upper element of [EasyDevActionSheet].
  final TextStyle titleStyle;

  /// TextStyle used in [EasyDevActionSheetItem] and [CancelActionSheetButton].
  final TextStyle actionStyle;

  /// Border radius that used in upper element of [EasyDevActionSheet].
  final BorderRadius borderRadius;

  /// Border radius that used in [EasyDevActionSheetItem].
  final BorderRadius modalRadius;

  @override
  bool operator ==(Object other) =>
      other is ActionSheetDecoration &&
      backgroundColor == other.backgroundColor &&
      tappedColor == other.tappedColor &&
      iconColor == other.iconColor &&
      iconSize == other.iconSize &&
      iconSpacing == other.iconSpacing &&
      padding == other.padding &&
      borderRadius == other.borderRadius &&
      titleStyle == other.titleStyle &&
      actionStyle == other.actionStyle &&
      modalRadius == other.modalRadius;

  @override
  int get hashCode => Object.hash(
        backgroundColor,
        tappedColor,
        iconColor,
        iconSize,
        iconSpacing,
        padding,
        titleStyle,
        actionStyle,
        borderRadius,
        modalRadius,
      );

  ActionSheetDecoration copyWith({
    Color? backgroundColor,
    Color? tappedColor,
    Color? iconColor,
    double? iconSize,
    double? iconSpacing,
    EdgeInsets? padding,
    TextStyle? titleStyle,
    TextStyle? actionStyle,
    BorderRadius? borderRadius,
    BorderRadius? modalRadius,
  }) =>
      ActionSheetDecoration(
        backgroundColor: backgroundColor ?? this.backgroundColor,
        tappedColor: tappedColor ?? this.tappedColor,
        iconColor: iconColor ?? this.iconColor,
        iconSize: iconSize ?? this.iconSize,
        iconSpacing: iconSpacing ?? this.iconSpacing,
        padding: padding ?? this.padding,
        titleStyle: titleStyle ?? this.titleStyle,
        actionStyle: actionStyle ?? this.actionStyle,
        borderRadius: borderRadius ?? this.borderRadius,
        modalRadius: modalRadius ?? this.modalRadius,
      );
}
