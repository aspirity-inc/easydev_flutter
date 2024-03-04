import 'dart:ui';

import 'package:flutter/animation.dart';

import 'package:easydev_base_ui/src/widgets/tabs/easydev_tab_controller.dart';

class ChangeAnimation extends Animation<double> with AnimationWithParentMixin<double> {
  ChangeAnimation(this.controller);

  final EasyDevTabController controller;

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
    final double controllerValue = controller.animation!.value;
    final double previousIndex = controller.previousIndex.toDouble();
    final double currentIndex = controller.index.toDouble();

    if (!controller.indexIsChanging) {
      return clampDouble((currentIndex - controllerValue).abs(), 0.0, 1.0);
    }

    return (controllerValue - currentIndex).abs() / (currentIndex - previousIndex).abs();
  }
}
