import 'dart:ui';

class GreySwatch {
  final Color greyColor;
  final Color surfaceColor;
  final Color onSurfaceColor;
  final Color? backgroundColor;
  final Color? onBackgroundColor;
  final Color? tappedSurfaceColor;
  final Color? unselectedColor;
  final Color? disabledColor;
  final Color? dividerColor;
  final Color? onSurfaceBright;
  final Color? onPrimary;

  GreySwatch({
    required this.surfaceColor,
    required this.onSurfaceColor,
    required this.greyColor,
    this.backgroundColor,
    this.onBackgroundColor,
    this.tappedSurfaceColor,
    this.unselectedColor,
    this.disabledColor,
    this.dividerColor,
    this.onSurfaceBright,
    this.onPrimary,
  });

  @override
  bool operator ==(Object other) =>
      other is GreySwatch &&
      backgroundColor == other.backgroundColor &&
      onBackgroundColor == other.onBackgroundColor &&
      surfaceColor == other.surfaceColor &&
      onSurfaceColor == other.onSurfaceColor &&
      tappedSurfaceColor == other.tappedSurfaceColor &&
      unselectedColor == other.unselectedColor &&
      disabledColor == other.disabledColor &&
      onSurfaceBright == other.onSurfaceBright &&
      dividerColor == other.dividerColor &&
      greyColor == other.greyColor &&
      onPrimary == other.onPrimary;

  @override
  int get hashCode => Object.hash(
        surfaceColor,
        onSurfaceColor,
        greyColor,
        backgroundColor,
        onBackgroundColor,
        tappedSurfaceColor,
        unselectedColor,
        disabledColor,
        dividerColor,
        onSurfaceBright,
        onPrimary,
      );

  GreySwatch copyWith({
    Color? backgroundColor,
    Color? onBackgroundColor,
    Color? surfaceColor,
    Color? onSurfaceColor,
    Color? greyColor,
    Color? tappedSurfaceColor,
    Color? unselectedColor,
    Color? disabledColor,
    Color? dividerColor,
    Color? onSurfaceBright,
    Color? onPrimary,
  }) =>
      GreySwatch(
        surfaceColor: surfaceColor ?? this.surfaceColor,
        onSurfaceColor: onSurfaceColor ?? this.onSurfaceColor,
        greyColor: greyColor ?? this.greyColor,
        backgroundColor: backgroundColor ?? this.backgroundColor,
        onBackgroundColor: onBackgroundColor ?? this.onBackgroundColor,
        tappedSurfaceColor: tappedSurfaceColor ?? this.tappedSurfaceColor,
        unselectedColor: unselectedColor ?? this.unselectedColor,
        disabledColor: disabledColor ?? this.disabledColor,
        dividerColor: dividerColor ?? this.dividerColor,
        onSurfaceBright: onSurfaceBright ?? this.onSurfaceBright,
        onPrimary: onPrimary ?? this.onPrimary,
      );
}
