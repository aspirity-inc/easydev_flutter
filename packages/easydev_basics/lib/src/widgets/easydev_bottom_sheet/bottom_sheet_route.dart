import 'package:easydev_basics/src/widgets/easydev_bottom_sheet/bottom_sheet_route_page.dart';
import 'package:flutter/widgets.dart';

/// Internal route for showing bottom sheets.
class BottomSheetRoute<T> extends PopupRoute<T?> {
  BottomSheetRoute({
    required this.child,
    required this.barrierDismissible,
    required this.barrierColor,
    this.barrierHitTestBehavior = HitTestBehavior.deferToChild,
    this.transitionDuration = const Duration(milliseconds: 300),
    this.barrierLabel,
  });

  final Widget child;
  final HitTestBehavior barrierHitTestBehavior;

  @override
  final Duration transitionDuration;

  @override
  final bool barrierDismissible;

  @override
  final Color? barrierColor;

  @override
  final String? barrierLabel;

  @override
  Widget buildPage(
      BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return LayoutBuilder(builder: (context, constraints) {
      return BottomSheetRoutePage(
        route: this,
        behavior: barrierHitTestBehavior,
        transitionDuration: transitionDuration,
        barrierDismissible: barrierDismissible,
        barrierColor: barrierColor,
        child: child,
      );
    });
  }

  void dismiss() {
    if (isActive) {
      navigator?.removeRoute(this);
    }
  }
}
