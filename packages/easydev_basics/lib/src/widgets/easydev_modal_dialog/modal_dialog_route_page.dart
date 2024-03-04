import 'package:easydev_basics/src/widgets/easydev_modal_dialog/modal_dialog_route.dart';
import 'package:flutter/widgets.dart';

/// Internal widget that provides ability to add barrier color and dismiss barrier by tapping on it.
class ModalDialogRoutePage<T> extends StatelessWidget {
  const ModalDialogRoutePage({
    super.key,
    required this.route,
    required this.behavior,
    required this.child,
    required this.transitionDuration,
    required this.barrierDismissible,
    required this.barrierColor,
    required this.alignment,
  });

  final ModalDialogRoute<T> route;
  final HitTestBehavior behavior;
  final Widget child;
  final Duration transitionDuration;
  final bool barrierDismissible;
  final Color? barrierColor;
  final Alignment alignment;

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
            fit: StackFit.expand,
            children: [
              GestureDetector(
                behavior: behavior,
                onTap: () {
                  if (barrierDismissible) {
                    Navigator.of(context).pop();
                  }
                },
                child: Container(
                  color: barrierColor ?? const Color(0x00000000),
                ),
              ),
              Align(
                alignment: alignment,
                child: child,
              ),
            ],
          );
        },
      ),
    );
  }
}
