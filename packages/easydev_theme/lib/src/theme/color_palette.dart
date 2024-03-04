import 'package:easydev_theme/src/theme/grey_swatch.dart';
import 'package:flutter/painting.dart';

class ColorPalette {
  const ColorPalette({
    required this.primarySwatch,
    required this.greySwatch,
    this.secondarySwatch,
    this.tertiarySwatch,
    this.errorSwatch,
    this.successSwatch,
    this.warningSwatch,
    this.linksSwatch,
  });

  final ColorSwatch primarySwatch;

  final GreySwatch greySwatch;

  final ColorSwatch? secondarySwatch;

  final ColorSwatch? tertiarySwatch;

  final ColorSwatch? errorSwatch;

  final ColorSwatch? successSwatch;

  final ColorSwatch? warningSwatch;

  final ColorSwatch? linksSwatch;

  @override
  bool operator ==(Object other) =>
      other is ColorPalette &&
      primarySwatch == other.primarySwatch &&
      secondarySwatch == other.secondarySwatch &&
      tertiarySwatch == other.tertiarySwatch &&
      greySwatch == other.greySwatch &&
      errorSwatch == other.errorSwatch &&
      successSwatch == other.successSwatch &&
      warningSwatch == other.warningSwatch &&
      linksSwatch == other.linksSwatch;

  @override
  int get hashCode => Object.hash(
        primarySwatch,
        secondarySwatch,
        tertiarySwatch,
        greySwatch,
        errorSwatch,
        successSwatch,
        warningSwatch,
        linksSwatch,
      );

  ColorPalette copyWith({
    ColorSwatch? primarySwatch,
    ColorSwatch? secondarySwatch,
    ColorSwatch? tertiarySwatch,
    GreySwatch? greySwatch,
    ColorSwatch? errorSwatch,
    ColorSwatch? successSwatch,
    ColorSwatch? warningSwatch,
    ColorSwatch? linksSwatch,
  }) =>
      ColorPalette(
        primarySwatch: primarySwatch ?? this.primarySwatch,
        secondarySwatch: secondarySwatch ?? this.successSwatch,
        tertiarySwatch: tertiarySwatch ?? this.tertiarySwatch,
        greySwatch: greySwatch ?? this.greySwatch,
        errorSwatch: errorSwatch ?? this.errorSwatch,
        successSwatch: successSwatch ?? this.successSwatch,
        warningSwatch: warningSwatch ?? this.warningSwatch,
        linksSwatch: linksSwatch ?? this.linksSwatch,
      );
}
