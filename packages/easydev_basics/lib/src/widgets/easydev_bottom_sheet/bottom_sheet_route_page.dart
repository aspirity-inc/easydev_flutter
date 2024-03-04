import 'package:easydev_basics/src/widgets/easydev_bottom_sheet/bottom_sheet_route.dart';
import 'package:flutter/widgets.dart';

/// Internal widget that provides ability to add barrier color and dismiss barrier by tapping on it.
class BottomSheetRoutePage<T> extends StatelessWidget {
  const BottomSheetRoutePage({
    super.key,
    required this.route,
    required this.behavior,
    required this.child,
    required this.transitionDuration,
    required this.barrierDismissible,
    required this.barrierColor,
  });

  final BottomSheetRoute<T> route;
  final HitTestBehavior behavior;
  final Widget child;
  final Duration transitionDuration;
  final bool barrierDismissible;
  final Color? barrierColor;

  @override
  Widget build(BuildContext context) {
    return Builder(
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
            child,
          ],
        );
      },
    );
  }
}
