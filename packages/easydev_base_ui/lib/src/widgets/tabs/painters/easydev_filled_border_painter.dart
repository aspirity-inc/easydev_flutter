import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:easydev_base_ui/src/widgets/tabs/easydev_tab_controller.dart';

class EasyDevFilledBorderPainter extends CustomPainter {
  EasyDevFilledBorderPainter({
    required this.controller,
    required this.tabKeys,
    required this.indicatorRadius,
    required this.selectedIndicator,
    required this.borderSide,
    required EasyDevFilledBorderPainter? old,
    required this.indicatorPadding,
  }) : super(repaint: controller.animation) {
    if (old != null) {
      saveTabOffsets(old._currentTabOffsets, old._currentTextDirection);
    }
  }

  final EasyDevTabController controller;

  final EdgeInsetsGeometry indicatorPadding;
  final List<GlobalKey> tabKeys;
  final BorderRadius indicatorRadius;
  final BorderSide borderSide;

  final Decoration selectedIndicator;

  List<double>? _currentTabOffsets;
  TextDirection? _currentTextDirection;

  BoxPainter? _selectedIndicatorPainter;

  void saveTabOffsets(List<double>? tabOffsets, TextDirection? textDirection) {
    _currentTabOffsets = tabOffsets;
    _currentTextDirection = textDirection;
  }

  int get maxTabIndex => _currentTabOffsets!.length - 2;

  void dispose() {
    _selectedIndicatorPainter?.dispose();
  }

  Rect _borderRect(Size tabBarSize) {
    double tabLeft, tabRight;
    switch (_currentTextDirection!) {
      case TextDirection.rtl:
        tabLeft = _currentTabOffsets!.last;
        tabRight = _currentTabOffsets!.first;
        break;
      case TextDirection.ltr:
        tabLeft = _currentTabOffsets!.first;
        tabRight = _currentTabOffsets!.last;
        break;
    }

    final EdgeInsets insets = indicatorPadding.resolve(_currentTextDirection);
    final Rect rect = Rect.fromLTWH(tabLeft, 0.0, tabRight - tabLeft, tabBarSize.height);
    return insets.deflateRect(rect);
  }

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
    final Rect rect = Rect.fromLTRB(
        tabLeft - borderSide.width * 3, 0.0, tabRight + borderSide.width * 3, tabBarSize.height);
    return insets.deflateRect(rect);
  }

  @override
  void paint(Canvas canvas, Size size) {
    Rect? currentRect;

    final double index = controller.index.toDouble();
    final double animationValue = controller.animation!.value;
    final bool ltr = index > animationValue;
    final int from = (ltr ? animationValue.floor() : animationValue.ceil())
        .clamp(0, maxTabIndex); // ignore_clamp_double_lint
    final int to = (ltr ? from + 1 : from - 1).clamp(0, maxTabIndex); // ignore_clamp_double_lint
    final Rect fromRect = _indicatorRect(size, from);
    final Rect toRect = _indicatorRect(size, to);
    currentRect = Rect.lerp(fromRect, toRect, (animationValue - from).abs());

    Paint borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderSide.width
      ..color = borderSide.color;

    final RRect rrectBorder = RRect.fromRectAndCorners(
      _borderRect(size),
      topLeft: indicatorRadius.topLeft,
      topRight: indicatorRadius.topRight,
      bottomLeft: indicatorRadius.bottomLeft,
      bottomRight: indicatorRadius.bottomRight,
    );

    canvas.drawRRect(rrectBorder, borderPaint);

    int length = _currentTabOffsets!.length - 1;

    canvas.saveLayer(Rect.largest, Paint());

    for (int index = 1; index < length; index++) {
      canvas.drawLine(Offset(_currentTabOffsets![index], size.height),
          Offset(_currentTabOffsets![index], 0), borderPaint);
    }

    final opacityOffsetPercentage = borderSide.width / (currentRect!.width / 100) / 100;

    final gr = LinearGradient(
      stops: [0, opacityOffsetPercentage * 2, 1 - opacityOffsetPercentage * 2, 1],
      colors: const [
        Color.fromARGB(0, 0, 0, 0),
        Color.fromARGB(255, 0, 0, 0),
        Color.fromARGB(255, 0, 0, 0),
        Color.fromARGB(0, 0, 0, 0),
      ],
    );

    canvas.drawRect(
        currentRect,
        Paint()
          ..shader = gr.createShader(currentRect)
          ..blendMode = BlendMode.dstOut);
    canvas.restore();
  }

  @override
  bool shouldRepaint(EasyDevFilledBorderPainter oldDelegate) {
    return controller != oldDelegate.controller ||
        indicatorRadius != oldDelegate.indicatorRadius ||
        borderSide != oldDelegate.borderSide ||
        selectedIndicator != oldDelegate.selectedIndicator ||
        indicatorPadding != oldDelegate.indicatorPadding ||
        tabKeys.length != oldDelegate.tabKeys.length ||
        (!listEquals(_currentTabOffsets, oldDelegate._currentTabOffsets)) ||
        _currentTextDirection != oldDelegate._currentTextDirection;
  }
}
