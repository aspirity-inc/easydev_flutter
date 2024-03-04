import 'package:easydev_base_ui/src/widgets/modal_widgets/show_modal_widget/modal_widget_route.dart';
import 'package:flutter/widgets.dart';

class ModalLayoutDelegate<T> extends SingleChildLayoutDelegate {
  ModalLayoutDelegate({
    required this.buttonRect,
    required this.offset,
    required this.alignment,
    required this.route,
    required this.centered,
    required this.context,
    this.correctPosition = false,
  });

  final Rect buttonRect;
  final Offset offset;
  final bool centered;
  final Alignment alignment;
  final ModalWidgetRoute<T> route;
  final BuildContext context;
  final bool correctPosition;

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    final screenSize = MediaQuery.of(context).size;

    final alignedWidth = buttonRect.width * ((alignment.x + 1) * 0.5);
    final alignedHeight = buttonRect.height * ((alignment.y + 1) * 0.5);

    Offset childrenPosition = Offset(
      buttonRect.left + alignedWidth + offset.dx,
      buttonRect.top + alignedHeight + offset.dy,
    );

    if (centered) {
      return Offset(
        buttonRect.left,
        buttonRect.top +
            alignedHeight +
            offset.dy +
            _getPositionCorrection(
              childrenPosition,
              childSize,
              screenSize,
            ),
      );
    }

    childrenPosition = childrenPosition.translate(
      0,
      _getPositionCorrection(childrenPosition, childSize, screenSize),
    );

    return childrenPosition;
  }

  @override
  Size getSize(BoxConstraints constraints) {
    if (centered) {
      final size = super.getSize(constraints);

      return Size(buttonRect.width, size.height);
    }
    return super.getSize(constraints);
  }

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    if (centered) {
      return BoxConstraints(
        maxWidth: buttonRect.width,
        minWidth: constraints.minWidth,
        maxHeight: constraints.maxHeight,
        minHeight: constraints.minHeight,
      );
    }
    return super.getConstraintsForChild(constraints);
  }

  @override
  bool shouldRelayout(covariant ModalLayoutDelegate oldDelegate) {
    return buttonRect != oldDelegate.buttonRect ||
        offset != oldDelegate.offset ||
        alignment != oldDelegate.alignment;
  }

  double _getPositionCorrection(Offset childrenPosition, Size childSize, Size screenSize) {
    return childrenPosition.dy + childSize.height > screenSize.height && correctPosition
        ? screenSize.height - (childrenPosition.dy + childSize.height)
        : 0;
  }
}
