import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

const Duration _kScrollbarTimeToFade = Duration(milliseconds: 1200);
const Duration _kScrollbarFadeDuration = Duration(milliseconds: 250);

/// {@macro flutter.widgets.scrollbar}
/// Scrollbar used in scrollable widget. Overrides [RawScrollbar].
class EasyDevScrollbar extends RawScrollbar {
  const EasyDevScrollbar({
    super.key,
    required super.child,
    super.controller,
    bool? thumbVisibility,
    double super.thickness = 8,
    Radius super.radius = const Radius.circular(3),
    ScrollNotificationPredicate? notificationPredicate,
    this.scrollbarColor,
    super.scrollbarOrientation,
  })  : assert(thickness < double.infinity),
        super(
          thumbVisibility: thumbVisibility ?? false,
          fadeDuration: _kScrollbarFadeDuration,
          timeToFade: _kScrollbarTimeToFade,
          pressDuration: const Duration(milliseconds: 100),
          notificationPredicate: notificationPredicate ?? defaultScrollNotificationPredicate,
        );

  final Color? scrollbarColor;

  @override
  RawScrollbarState<EasyDevScrollbar> createState() => _EasyDevScrollbarState();
}

class _EasyDevScrollbarState extends RawScrollbarState<EasyDevScrollbar> {
  double _pressStartAxisPosition = 0.0;

  @override
  void updateScrollbarPainter() {
    scrollbarPainter
      ..color = _getColor(context)
      ..textDirection = Directionality.of(context)
      ..thickness = 8
      ..mainAxisMargin = 3
      ..crossAxisMargin = 0
      ..radius = widget.radius
      ..padding = MediaQuery.paddingOf(context)
      ..minLength = 112
      ..minOverscrollLength = 8
      ..scrollbarOrientation = widget.scrollbarOrientation;
  }

  @override
  void handleThumbPressStart(Offset localPosition) {
    super.handleThumbPressStart(localPosition);
    final Axis? direction = getScrollbarDirection();
    if (direction == null) {
      return;
    }
    switch (direction) {
      case Axis.vertical:
        _pressStartAxisPosition = localPosition.dy;
      case Axis.horizontal:
        _pressStartAxisPosition = localPosition.dx;
    }
  }

  @override
  void handleThumbPress() {
    if (getScrollbarDirection() == null) {
      return;
    }
    super.handleThumbPress();
  }

  @override
  void handleThumbPressEnd(Offset localPosition, Velocity velocity) {
    final Axis? direction = getScrollbarDirection();
    if (direction == null) {
      return;
    }
    super.handleThumbPressEnd(localPosition, velocity);
    switch (direction) {
      case Axis.vertical:
        if (velocity.pixelsPerSecond.dy.abs() < 10 &&
            (localPosition.dy - _pressStartAxisPosition).abs() > 0) {
          HapticFeedback.mediumImpact();
        }
      case Axis.horizontal:
        if (velocity.pixelsPerSecond.dx.abs() < 10 &&
            (localPosition.dx - _pressStartAxisPosition).abs() > 0) {
          HapticFeedback.mediumImpact();
        }
    }
  }

  Color _getColor(BuildContext context) {
    final theme = context.easyDevTheme;
    final light = theme.brightness == Brightness.light;

    return widget.scrollbarColor ??
        (light
            ? (theme.colorPalette.greySwatch.unselectedColor ??
                theme.colorPalette.greySwatch.onSurfaceColor)
            : theme.colorPalette.secondarySwatch ?? theme.colorPalette.primarySwatch);
  }
}
