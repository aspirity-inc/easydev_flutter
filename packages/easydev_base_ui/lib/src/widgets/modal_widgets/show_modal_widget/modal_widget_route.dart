import 'package:easydev_base_ui/src/widgets/modal_widgets/show_modal_widget/modal_route_page.dart';
import 'package:flutter/widgets.dart';

class ModalWidgetRoute<T> extends PopupRoute<T?> {
  ModalWidgetRoute({
    required this.modalOffset,
    required this.modalAlignment,
    required this.child,
    required this.barrierDismissible,
    required this.barrierColor,
    required this.rect,
    required this.centered,
    this.barrierHitTestBehavior = HitTestBehavior.deferToChild,
    this.transitionDuration = const Duration(milliseconds: 300),
    this.barrierLabel,
    this.correctPosition = false,
    this.blurBackground = false,
  });

  final Widget child;
  final Rect rect;
  final bool centered;
  final HitTestBehavior barrierHitTestBehavior;
  final Offset modalOffset;
  final Alignment modalAlignment;
  final bool correctPosition;

  final bool blurBackground;

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
      return ModalRoutePage(
        route: this,
        constraints: constraints,
        buttonRect: rect,
        centered: centered,
        transitionDuration: transitionDuration,
        modalAlignment: modalAlignment,
        modalOffset: modalOffset,
        barrierDismissible: barrierDismissible,
        barrierColor: barrierColor,
        correctPosition: correctPosition,
        blurBackground: blurBackground,
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
