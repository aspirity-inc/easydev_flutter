import 'package:flutter/painting.dart';

class EasyDevAssetsTableThemeData {
  const EasyDevAssetsTableThemeData({
    this.cardColor,
    this.tappedCardColor,
    this.growthColor,
    this.declineColor,
    this.actionColor,
    this.onActionColor,
    this.titleTextStyle,
    this.subtitleTextStyle,
    this.spacing,
    this.imageSize,
    this.borderRadius,
    this.padding,
  });

  final Color? cardColor;

  final Color? tappedCardColor;

  final Color? growthColor;

  final Color? declineColor;

  final Color? actionColor;

  final Color? onActionColor;

  final TextStyle? titleTextStyle;

  final TextStyle? subtitleTextStyle;

  final double? spacing;

  final double? imageSize;

  final BorderRadius? borderRadius;

  final EdgeInsets? padding;

  @override
  bool operator ==(Object other) =>
      other is EasyDevAssetsTableThemeData &&
      cardColor == other.cardColor &&
      tappedCardColor == other.tappedCardColor &&
      growthColor == other.declineColor &&
      actionColor == other.actionColor &&
      onActionColor == other.onActionColor &&
      titleTextStyle == other.titleTextStyle &&
      subtitleTextStyle == other.subtitleTextStyle &&
      spacing == other.spacing &&
      imageSize == other.imageSize &&
      borderRadius == other.borderRadius &&
      padding == other.padding;

  @override
  int get hashCode => Object.hash(
        cardColor,
        tappedCardColor,
        growthColor,
        actionColor,
        onActionColor,
        titleTextStyle,
        subtitleTextStyle,
        spacing,
        imageSize,
        borderRadius,
        padding,
      );

  EasyDevAssetsTableThemeData copyWith({
    Color? cardColor,
    Color? tappedCardColor,
    Color? growthColor,
    Color? declineColor,
    Color? actionColor,
    Color? onActionColor,
    TextStyle? titleTextStyle,
    TextStyle? subtitleTextStyle,
    double? spacing,
    double? imageSize,
    BorderRadius? borderRadius,
    EdgeInsets? padding,
  }) =>
      EasyDevAssetsTableThemeData(
        cardColor: cardColor ?? this.cardColor,
        tappedCardColor: tappedCardColor ?? this.tappedCardColor,
        growthColor: growthColor ?? this.growthColor,
        declineColor: declineColor ?? this.declineColor,
        actionColor: actionColor ?? this.actionColor,
        onActionColor: onActionColor ?? this.onActionColor,
        titleTextStyle: titleTextStyle ?? this.titleTextStyle,
        subtitleTextStyle: subtitleTextStyle ?? this.subtitleTextStyle,
        spacing: spacing ?? this.spacing,
        imageSize: imageSize ?? this.imageSize,
        borderRadius: borderRadius ?? this.borderRadius,
        padding: padding ?? this.padding,
      );
}
