import 'dart:ui';
import 'package:easydev_base_ui/src/widgets/modal_widgets/show_modal_widget/modal_layout_delegate.dart';
import 'package:easydev_base_ui/src/widgets/modal_widgets/show_modal_widget/modal_widget_route.dart';
import 'package:flutter/widgets.dart';

class ModalRoutePage<T> extends StatelessWidget {
  const ModalRoutePage({
    super.key,
    required this.route,
    required this.constraints,
    required this.child,
    required this.buttonRect,
    required this.transitionDuration,
    required this.modalAlignment,
    required this.modalOffset,
    required this.barrierDismissible,
    required this.barrierColor,
    required this.centered,
    this.correctPosition = false,
    this.blurBackground = false,
  });

  final ModalWidgetRoute<T> route;
  final BoxConstraints constraints;
  final Widget child;
  final Rect buttonRect;
  final Duration transitionDuration;
  final Alignment modalAlignment;
  final Offset modalOffset;
  final bool barrierDismissible;
  final Color? barrierColor;
  final bool centered;
  final bool correctPosition;
  final bool blurBackground;

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      removeBottom: true,
      removeLeft: true,
      removeRight: true,
      child: Builder(
        builder: (BuildContext context) {
          return Stack(
            children: [
              if (blurBackground)
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(),
                  ),
                ),
              ColoredBox(color: barrierColor ?? const Color(0x00000000)),
              CustomSingleChildLayout(
                delegate: ModalLayoutDelegate<T>(
                  buttonRect: buttonRect,
                  offset: modalOffset,
                  centered: centered,
                  alignment: modalAlignment,
                  route: route,
                  context: context,
                  correctPosition: correctPosition,
                ),
                child: child,
              ),
            ],
          );
        },
      ),
    );
  }
}
