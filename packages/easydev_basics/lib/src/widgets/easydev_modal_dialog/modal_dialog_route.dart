import 'package:easydev_basics/src/widgets/easydev_modal_dialog/modal_dialog_route_page.dart';
import 'package:flutter/widgets.dart';

/// Internal route for showing modal dialogs
class ModalDialogRoute<T> extends PopupRoute<T?> {
  ModalDialogRoute({
    required this.child,
    required this.barrierDismissible,
    required this.barrierColor,
    required this.alignment,
    this.barrierHitTestBehavior = HitTestBehavior.deferToChild,
    this.transitionDuration = const Duration(milliseconds: 300),
    this.barrierLabel,
  });

  final Widget child;
  final HitTestBehavior barrierHitTestBehavior;
  final Alignment alignment;

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
      return ModalDialogRoutePage(
        route: this,
        behavior: barrierHitTestBehavior,
        transitionDuration: transitionDuration,
        barrierDismissible: barrierDismissible,
        barrierColor: barrierColor,
        alignment: alignment,
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
