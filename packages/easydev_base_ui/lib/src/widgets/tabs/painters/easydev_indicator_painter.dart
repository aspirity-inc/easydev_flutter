import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:easydev_base_ui/src/widgets/tabs/easydev_tab_controller.dart';

class EasyDevIndicatorPainter extends CustomPainter {
  EasyDevIndicatorPainter({
    required this.controller,
    required this.selectedIndicator,
    required this.tabKeys,
    required EasyDevIndicatorPainter? old,
    required this.indicatorPadding,
    this.dividerColor,
    this.unselectedIndicator,
  }) : super(repaint: controller.animation) {
    if (old != null) {
      saveTabOffsets(old._currentTabOffsets, old._currentTextDirection);
    }
  }

  final EasyDevTabController controller;
  final Decoration selectedIndicator;
  final Decoration? unselectedIndicator;

  final EdgeInsetsGeometry indicatorPadding;
  final List<GlobalKey> tabKeys;
  final Color? dividerColor;
  List<double>? _currentTabOffsets;
  TextDirection? _currentTextDirection;

  BoxPainter? _selectedIndicatorPainter;
  BoxPainter? _unselectedIndicatorPainter;

  void dispose() {
    _selectedIndicatorPainter?.dispose();
    _unselectedIndicatorPainter?.dispose();
  }

  void saveTabOffsets(List<double>? tabOffsets, TextDirection? textDirection) {
    _currentTabOffsets = tabOffsets;
    _currentTextDirection = textDirection;
  }

  int get maxTabIndex => _currentTabOffsets!.length - 2;

  Rect _indicatorRect(Size tabBarSize, int tabIndex) {
    double tabLeft, tabRight;
    switch (_currentTextDirection!) {
      case TextDirection.rtl:
        tabLeft = _currentTabOffsets![tabIndex + 1];
        tabRight = _currentTabOffsets![tabIndex];
        break;
      case TextDirection.ltr:
        tabLeft = _currentTabOffsets![tabIndex];
        tabRight = _currentTabOffsets![tabIndex + 1];
        break;
    }

    final EdgeInsets insets = indicatorPadding.resolve(_currentTextDirection);
    final Rect rect = Rect.fromLTWH(tabLeft, 0.0, tabRight - tabLeft, tabBarSize.height);
    return insets.deflateRect(rect);
  }

  @override
  void paint(Canvas canvas, Size size) {
    Rect? currentRect;

    _selectedIndicatorPainter ??= selectedIndicator.createBoxPainter();

    final double index = controller.index.toDouble();
    final double animationValue = controller.animation!.value;
    final bool ltr = index > animationValue;
    final int from = (ltr ? animationValue.floor() : animationValue.ceil())
        .clamp(0, maxTabIndex); // ignore_clamp_double_lint
    final int to = (ltr ? from + 1 : from - 1).clamp(0, maxTabIndex); // ignore_clamp_double_lint
    final Rect fromRect = _indicatorRect(size, from);
    final Rect toRect = _indicatorRect(size, to);
    currentRect = Rect.lerp(fromRect, toRect, (animationValue - from).abs());

    final ImageConfiguration configuration = ImageConfiguration(
      size: currentRect!.size,
      textDirection: _currentTextDirection,
    );

    if (dividerColor != null) {
      final Paint dividerPaint = Paint()
        ..color = dividerColor!
        ..strokeWidth = 1;
      canvas.drawLine(Offset(0, size.height), Offset(size.width, size.height), dividerPaint);
    }

    if (unselectedIndicator != null) {
      _unselectedIndicatorPainter ??= unselectedIndicator!.createBoxPainter();
      for (int index = 0; index < _currentTabOffsets!.length - 1; index += 1) {
        final Rect unselectedRect = _indicatorRect(size, index);
        final ImageConfiguration configuration = ImageConfiguration(
          size: unselectedRect.size,
          textDirection: _currentTextDirection,
        );
        _unselectedIndicatorPainter!.paint(canvas, unselectedRect.topLeft, configuration);
      }
    }

    _selectedIndicatorPainter!.paint(canvas, currentRect.topLeft, configuration);
  }

  @override
  bool shouldRepaint(EasyDevIndicatorPainter oldDelegate) {
    return controller != oldDelegate.controller ||
        selectedIndicator != oldDelegate.selectedIndicator ||
        unselectedIndicator != oldDelegate.unselectedIndicator ||
        indicatorPadding != oldDelegate.indicatorPadding ||
        tabKeys.length != oldDelegate.tabKeys.length ||
        dividerColor != oldDelegate.dividerColor ||
        (!listEquals(_currentTabOffsets, oldDelegate._currentTabOffsets)) ||
        _currentTextDirection != oldDelegate._currentTextDirection;
  }
}
