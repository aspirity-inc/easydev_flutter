import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/painting.dart';

enum Brightness {
  light(surfaceColor: lightThemeGrey50, onSurfaceColor: lightThemeGrey900),
  dark(surfaceColor: darkThemeGrey900, onSurfaceColor: darkThemeGrey50);

  const Brightness({
    required this.surfaceColor,
    required this.onSurfaceColor,
  });

  final Color surfaceColor;
  final Color onSurfaceColor;
}
