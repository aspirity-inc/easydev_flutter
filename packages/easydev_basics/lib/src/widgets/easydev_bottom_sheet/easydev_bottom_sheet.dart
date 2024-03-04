import 'package:easydev_basics/src/widgets/easydev_bottom_sheet/show_easydev_bottom_sheet.dart';
import 'package:flutter/widgets.dart';
import 'package:easydev_theme/easydev_theme.dart';

/// [EasyDevBottomSheet] is widget, that can be used as widget on top of app content, or shown
/// with modal dialog using [showEasyDevBottomSheet] function.
/// If it used not with modal route and [closeByDragging], [onClose] property should be overriden,
/// as it will try to pop current route using Navigator.of(context).pop(). Dragging bottom sheet
/// can be disabled using [draggable] property.
/// This sample shows calling bottom sheet with showEasyDevBottomSheet function
///
/// See code in example/lib/pages/easydev_bottom_sheet_examples/easydev_bottom_sheet_example.dart
/// Bottom sheet can be persistent, if it passed as simple widget.
///
/// This sample shows persistent bottom sheet.
///
/// See code in example/lib/pages/easydev_bottom_sheet_examples/easydev_bottom_sheet_example2.dart
///
/// See also:
///
///  * [showEasyDevBottomSheet], method for showing modal bottom sheet.
///  * [show], method for showing modal bottom sheet.
///
class EasyDevBottomSheet extends StatefulWidget {
  /// Create a bottom sheet.
  const EasyDevBottomSheet({
    super.key,
    required this.child,
    this.maxHeight,
    this.minHeight,
    this.draggable = true,
    this.closeByDragging = true,
    this.enableDragHandle,
    this.backgroundColor,
    this.borderRadius,
    this.dragHandleColor,
    this.elevation,
    this.dragHandleWidth,
    this.dragHandleThickness,
    this.padding,
    this.onClose,
    this.closeDistance = 64,
    this.addSafeArea = true,
  });

  /// Child [Widget] of bottom sheet.
  final Widget child;

  /// Shows whether bottom sheet can be dragged. Defaults to true.
  final bool draggable;

  /// Shows whether bottom sheet can be closed by dragging. [EasyDevBottomSheet] closed
  /// by popping route when it reaches height of 150 logical pixels.
  final bool closeByDragging;

  /// Background color of bottom sheet.
  final Color? backgroundColor;

  /// Maximum height of bottom sheet
  final double? maxHeight;

  /// Minimum height of bottom sheet
  final double? minHeight;

  /// Color of [EasyDevBottomSheet] handle.
  final Color? dragHandleColor;

  /// Border radius of bottom sheet, defaults to BorderRadius.circular(42).
  final BorderRadius? borderRadius;

  /// Show whether should show handle on top of bottom sheet. Defaults to true.
  final bool? enableDragHandle;

  /// Elevation of bottom sheet. Can be less then zero, defaults to 0.
  final double? elevation;

  /// Width of the drag handle on upper part of bottom sheet. Defaults to 40.
  final double? dragHandleWidth;

  /// Thickness of the handle on upper part of bottom sheet. Defaults to 4.
  final double? dragHandleThickness;

  /// Padding of bottom sheet. Defaults to EdgeInsets.symmetric(horizontal: 16).
  final EdgeInsets? padding;

  /// Callback on [EasyDevBottomSheet] closed by dragging it. Only works when [draggable] is true.
  /// If this [VoidCallback] is not provided it will use [Navigator].of(context).pop()
  /// to close itself, this function adds ability to override it as bottom sheet can be called
  /// as non modal widget.
  final VoidCallback? onClose;

  /// If [closeByDragging], bottom sheet will be closed on release, by moved
  /// more or equal than this distance, defaults to 64.
  final double closeDistance;

  /// Adds [SafeArea] to bottom part of bottom sheet.
  final bool addSafeArea;

  @override
  State<EasyDevBottomSheet> createState() => _EasyDevCarouselState();
}

class _EasyDevCarouselState extends State<EasyDevBottomSheet> {
  late Color _backgroundColor;
  late double _minHeight;
  late double _maxHeight;
  late Color? _dragHandleColor;
  late BorderRadius _borderRadius;
  late double _elevation;
  late double _dragHandleThickness;
  late double _dragHandleWidth;
  late bool _enableDragHandle;
  late EdgeInsets _padding;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setAndUpdateFields();
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    setAndUpdateFields();
  }

  void setAndUpdateFields() {
    final theme = EasyDevTheme.of(context);
    final colorPalette = theme.colorPalette;
    final bottomSheetTheme = theme.bottomSheetTheme;

    _backgroundColor = widget.backgroundColor ??
        bottomSheetTheme?.backgroundColor ??
        (theme.brightness == Brightness.light
            ? colorPalette.greySwatch.backgroundColor ?? colorPalette.greySwatch.greyColor
            : colorPalette.greySwatch.disabledColor ?? colorPalette.greySwatch.greyColor);

    _dragHandleColor = widget.dragHandleColor ??
        bottomSheetTheme?.dragHandleColor ??
        (theme.brightness == Brightness.light
            ? colorPalette.greySwatch.onBackgroundColor
            : colorPalette.greySwatch.onSurfaceBright);

    _maxHeight =
        widget.maxHeight ?? bottomSheetTheme?.maxHeight ?? MediaQuery.of(context).size.height / 2;
    _minHeight = widget.minHeight ?? bottomSheetTheme?.minHeight ?? 0;
    _borderRadius = widget.borderRadius ??
        bottomSheetTheme?.borderRadius ??
        const BorderRadius.only(
          topLeft: Radius.circular(42),
          topRight: Radius.circular(42),
        );
    _elevation = widget.elevation ?? bottomSheetTheme?.elevation ?? 0;
    _dragHandleWidth = widget.dragHandleWidth ?? bottomSheetTheme?.dragHandleWidth ?? 40;
    _dragHandleThickness = widget.dragHandleThickness ?? bottomSheetTheme?.dragHandleThickness ?? 4;
    _padding =
        widget.padding ?? bottomSheetTheme?.padding ?? const EdgeInsets.symmetric(horizontal: 16);
    _enableDragHandle = widget.enableDragHandle ?? bottomSheetTheme?.enableDragHandle ?? true;

    _currentPosition = 0;
  }

  Duration _updateDuration = Duration.zero;
  bool _needToPop = false;
  late double _currentPosition;

  @override
  Widget build(BuildContext context) {
    final bottomSafeArea = MediaQuery.of(context).viewPadding.bottom;

    return AnimatedPositioned(
      duration: _updateDuration,
      curve: Curves.easeOut,
      bottom: _currentPosition,
      onEnd: () {
        if (_needToPop) {
          if (widget.onClose != null) {
            widget.onClose!.call();
          } else {
            Navigator.of(context).pop();
          }
        }
      },
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onVerticalDragUpdate: widget.draggable ? _onVerticalDragUpdate : (value) {},
        onVerticalDragEnd: _onVerticalDragEnd,
        child: PhysicalShape(
          color: _backgroundColor,
          clipper: ShapeBorderClipper(
            shape: RoundedRectangleBorder(
              borderRadius: _borderRadius,
            ),
          ),
          elevation: _elevation,
          child: Container(
            padding: _padding,
            constraints: BoxConstraints(
              minHeight: _minHeight,
              maxHeight: _maxHeight,
            ),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                if (_enableDragHandle) ...[
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: _dragHandleThickness,
                    width: _dragHandleWidth,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        100,
                      ),
                      color: _dragHandleColor,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
                widget.child,
                if (widget.addSafeArea)
                  SizedBox(
                    height: bottomSafeArea,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    // This function updates position of bottom sheet when it dragged.
    final primaryDelta = details.primaryDelta ?? 0;
    if (_currentPosition >= 0 && primaryDelta < 0) {
      setState(() {
        _currentPosition = 0;
        _updateDuration = Duration.zero;
      });
    } else if (_currentPosition <= _minHeight - _maxHeight && primaryDelta > 0) {
      setState(() {
        _currentPosition = _minHeight - _maxHeight;
        _updateDuration = Duration.zero;
      });
    } else {
      final delta = details.delta.dy;
      setState(() {
        _currentPosition -= delta;
        _updateDuration = Duration.zero;
      });
    }
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    if (_currentPosition.abs() < widget.closeDistance.abs()) {
      setState(() {
        _currentPosition = 0;
        _updateDuration = const Duration(milliseconds: 300);
      });
    } else {
      setState(() {
        _currentPosition = -_maxHeight;
        _updateDuration = const Duration(milliseconds: 150);
        _needToPop = true;
      });
    }
  }
}
