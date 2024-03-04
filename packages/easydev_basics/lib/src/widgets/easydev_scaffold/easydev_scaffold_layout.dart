import 'dart:math' as math;
import 'dart:ui';

import 'package:easydev_basics/src/widgets/easydev_scaffold/scaffold_body_box_constraints.dart';
import 'package:easydev_basics/src/widgets/easydev_scaffold/scaffold_children.dart';
import 'package:flutter/widgets.dart';

/// [EasyDevScaffoldLayout] is internal widget, for performing child layout.
/// It uses [ScaffoldChildren] to for performing layout for different scaffold slots.
class EasyDevScaffoldLayout extends MultiChildLayoutDelegate {
  final bool extendBody;
  final EdgeInsets minInsets;
  final EdgeInsets minViewPadding;
  final TextDirection textDirection;
  final Offset fabOffset;
  final bool addBodySafeArea;

  EasyDevScaffoldLayout({
    super.relayout,
    required this.extendBody,
    required this.minInsets,
    required this.minViewPadding,
    required this.textDirection,
    required this.fabOffset,
    required this.addBodySafeArea,
  });

  @override
  void performLayout(Size size) {
    final BoxConstraints looseConstraints = BoxConstraints.loose(size);

    final BoxConstraints fullWidthConstraints = looseConstraints.tighten(width: size.width);
    final double bottom = size.height;
    double contentTop = 0.0;
    double bottomWidgetsHeight = 0.0;
    double appBarHeight = 0.0;

    if (hasChild(ScaffoldChildren.appbar)) {
      appBarHeight = layoutChild(ScaffoldChildren.appbar, fullWidthConstraints).height;
      contentTop = appBarHeight;
      positionChild(ScaffoldChildren.appbar, Offset.zero);
    }

    double? bottomNavigationBarTop;
    if (hasChild(ScaffoldChildren.bottomNavigationBar)) {
      final double bottomNavigationBarHeight =
          layoutChild(ScaffoldChildren.bottomNavigationBar, fullWidthConstraints).height;
      bottomWidgetsHeight += bottomNavigationBarHeight;
      bottomNavigationBarTop = math.max(0.0, bottom - bottomWidgetsHeight);
      positionChild(ScaffoldChildren.bottomNavigationBar, Offset(0.0, bottomNavigationBarTop));
    }

    final double contentBottom =
        math.max(0.0, bottom - math.max(minInsets.bottom, bottomWidgetsHeight));

    if (hasChild(ScaffoldChildren.body)) {
      double bodyMaxHeight = math.max(0.0, (contentBottom - contentTop));

      if (extendBody) {
        bodyMaxHeight += bottomWidgetsHeight;
        if (addBodySafeArea) {
          bodyMaxHeight -= minViewPadding.bottom;
        }

        bodyMaxHeight = clampDouble(bodyMaxHeight, 0.0, looseConstraints.maxHeight - contentTop);

        assert(bodyMaxHeight <= math.max(0.0, looseConstraints.maxHeight - contentTop));
      }
      if (!extendBody && addBodySafeArea) {
        bodyMaxHeight -= minViewPadding.bottom;
      }
      final BoxConstraints bodyConstraints = ScaffoldBodyBoxConstraints(
        maxWidth: fullWidthConstraints.maxWidth,
        maxHeight: bodyMaxHeight,
        bottomWidgetsHeight: extendBody ? 0 : 0,
        appBarHeight: appBarHeight,
      );

      layoutChild(ScaffoldChildren.body, bodyConstraints);
      positionChild(ScaffoldChildren.body, Offset(0.0, contentTop));
    }

    if (hasChild(ScaffoldChildren.fab)) {
      layoutChild(ScaffoldChildren.fab, looseConstraints);

      Offset bottomNavigationBarOffset = const Offset(0, 0);
      if (hasChild(ScaffoldChildren.bottomNavigationBar)) {
        bottomNavigationBarOffset = Offset(0, -bottomWidgetsHeight - 16);
      }
      final offset = Offset(
        fabOffset.dx,
        math.min(fabOffset.dy, bottomNavigationBarOffset.dy),
      );

      positionChild(
        ScaffoldChildren.fab,
        offset,
      );
    }
    if (hasChild(ScaffoldChildren.toast)) {
      final toastSize = layoutChild(ScaffoldChildren.toast, looseConstraints);

      Offset bottomNavigationBarOffset =
          Offset(0, bottom - toastSize.height - minInsets.bottom - minViewPadding.bottom);
      if (hasChild(ScaffoldChildren.bottomNavigationBar)) {
        bottomNavigationBarOffset = Offset(0, bottom - bottomWidgetsHeight - toastSize.height);
      }

      positionChild(
        ScaffoldChildren.toast,
        bottomNavigationBarOffset,
      );
    }
    if (hasChild(ScaffoldChildren.snackBar)) {
      final snackbarSize = layoutChild(ScaffoldChildren.snackBar, looseConstraints);

      Offset bottomNavigationBarOffset =
          Offset(0, bottom - snackbarSize.height - minInsets.bottom - minViewPadding.bottom);
      if (hasChild(ScaffoldChildren.bottomNavigationBar)) {
        bottomNavigationBarOffset = Offset(0, bottom - bottomWidgetsHeight - snackbarSize.height);
      }
      positionChild(
        ScaffoldChildren.snackBar,
        bottomNavigationBarOffset,
      );
    }
  }

  @override
  bool shouldRelayout(EasyDevScaffoldLayout oldDelegate) {
    return extendBody != oldDelegate.extendBody ||
        minInsets != oldDelegate.minInsets ||
        minViewPadding != oldDelegate.minViewPadding ||
        textDirection != oldDelegate.textDirection;
  }
}
