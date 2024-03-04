import 'dart:ui';

import 'package:flutter/animation.dart';

import 'package:easydev_base_ui/src/widgets/tabs/easydev_tab_controller.dart';

class DragAnimation extends Animation<double> with AnimationWithParentMixin<double> {
  DragAnimation(this.controller, this.index);

  final EasyDevTabController controller;
  final int index;

  @override
  Animation<double> get parent => controller.animation!;

  @override
  void removeStatusListener(AnimationStatusListener listener) {
    if (controller.animation != null) {
      super.removeStatusListener(listener);
    }
  }

  @override
  void removeListener(VoidCallback listener) {
    if (controller.animation != null) {
      super.removeListener(listener);
    }
  }

  @override
  double get value {
    assert(!controller.indexIsChanging);
    final double controllerMaxValue = (controller.length - 1).toDouble();
    final double controllerValue =
        clampDouble(controller.animation!.value, 0.0, controllerMaxValue);
    return clampDouble((controllerValue - index.toDouble()).abs(), 0.0, 1.0);
  }
}
