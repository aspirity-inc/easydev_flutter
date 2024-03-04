import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';

class BrightnessNotifier extends InheritedWidget {
  const BrightnessNotifier({
    required this.valueNotifier,
    required super.child,
    super.key,
  });

  final ValueNotifier<Brightness> valueNotifier;

  void updateBrightness() {
    valueNotifier.value =
        valueNotifier.value == Brightness.light ? Brightness.dark : Brightness.light;
  }

  @override
  bool updateShouldNotify(covariant BrightnessNotifier oldWidget) {
    return valueNotifier.value != oldWidget.valueNotifier.value;
  }
}
