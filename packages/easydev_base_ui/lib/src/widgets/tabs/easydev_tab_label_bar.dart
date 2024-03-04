import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';

// TabLabelBar and TabLabelBarRenderer only exist to report the widths of the tabs upon layout.
class TabLabelBar extends Flex {
  const TabLabelBar({
    super.key,
    super.children,
    required this.onPerformLayout,
  }) : super(
          direction: Axis.horizontal,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          verticalDirection: VerticalDirection.down,
        );

  final void Function(
          List<double> xOffsets, TextDirection textDirection, double width)
      onPerformLayout;

  @override
  RenderFlex createRenderObject(BuildContext context) {
    return TabLabelBarRenderer(
      direction: direction,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: getEffectiveTextDirection(context)!,
      verticalDirection: verticalDirection,
      onPerformLayout: onPerformLayout,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, TabLabelBarRenderer renderObject) {
    super.updateRenderObject(context, renderObject);
    renderObject.onPerformLayout = onPerformLayout;
  }
}

class TabLabelBarRenderer extends RenderFlex {
  TabLabelBarRenderer({
    required super.direction,
    required super.mainAxisSize,
    required super.mainAxisAlignment,
    required super.crossAxisAlignment,
    required TextDirection super.textDirection,
    required super.verticalDirection,
    required this.onPerformLayout,
  });

  void Function(
          List<double> xOffsets, TextDirection textDirection, double width)
      onPerformLayout;

  @override
  void performLayout() {
    super.performLayout();

    RenderBox? child = firstChild;
    final List<double> xOffsets = <double>[];
    while (child != null) {
      final FlexParentData childParentData =
          child.parentData! as FlexParentData;
      xOffsets.add(childParentData.offset.dx);
      child = childParentData.nextSibling;
    }
    switch (textDirection!) {
      case TextDirection.rtl:
        xOffsets.insert(0, size.width);
        break;
      case TextDirection.ltr:
        xOffsets.add(size.width);
        break;
    }
    onPerformLayout(xOffsets, textDirection!, size.width);
  }
}
