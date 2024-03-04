import 'package:easydev_basics/easydev_basics.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';

/// Floating action button is widget that displays elevated button.
/// It should be used for the main action on a screen. It can be passed in
/// [EasyDevScaffold.floatingActionButton] field, and changed offset by using
/// [EasyDevScaffold.fabOffset] field. [EasyDevFloatingActionButton] changes it's color
/// on being pressed on unless it is [disabled].
/// [elevation], [disabledElevation] and [tapElevation] properties is
/// changing elevation of button, depending on button state.
/// Size of button depends on [isLarge] property, it defaults to 40 if it is small, and to 56
/// if [isLarge] is true.
///
/// This sample shows an [EasyDevApp] with [EasyDevFloatingActionButton] and counter
///
/// See code in example/lib/pages/examples/fab/easydev_fab_example.dart
///
class EasyDevFloatingActionButton extends StatefulWidget {
  /// Create a floating action button.
  const EasyDevFloatingActionButton({
    super.key,
    required this.onTap,
    this.color,
    this.tapColor,
    this.disabledColor,
    this.iconColor,
    this.isLarge = true,
    this.radius,
    this.elevation,
    this.tapElevation,
    this.disabledElevation,
    this.disabled = false,
    this.child,
  });

  /// Callback that will run on button tap.
  final VoidCallback onTap;

  /// Color of the button.
  final Color? color;

  /// Color of the button when it is tapped.
  final Color? tapColor;

  /// Color of the button when [disabled] is true.
  final Color? disabledColor;

  /// Color of icons when icons included in child widget
  final Color? iconColor;

  /// Whether the button should be large.
  /// Default value is true.
  final bool isLarge;

  /// Radius of the button's corners.
  final double? radius;

  /// Elevation of the button in z-axis.
  final double? elevation;

  /// Elevation of the button in z-axis when it is tapped.
  final double? tapElevation;

  /// Elevation of the button in z-axis when it is [disabled].
  final double? disabledElevation;

  /// Whether the button is [disabled].
  /// Default value is false.
  final bool disabled;

  /// Inner widget of the button.
  final Widget? child;

  @override
  State<EasyDevFloatingActionButton> createState() => _EasyDevFloatingActionButtonState();
}

class _EasyDevFloatingActionButtonState extends State<EasyDevFloatingActionButton> {
  bool isTapped = false;

  double _getSize(EasyDevThemeData theme) {
    if (widget.isLarge) {
      return theme.floatingActionButtonTheme?.largeButtonSize ?? 56;
    } else {
      return theme.floatingActionButtonTheme?.smallButtonSize ?? 40;
    }
  }

  Color _getDefaultColor(EasyDevThemeData theme) {
    return widget.color ??
        theme.floatingActionButtonTheme?.color ??
        (theme.brightness == Brightness.light
            ? theme.colorPalette.primarySwatch[500] ?? theme.brightness.surfaceColor
            : theme.colorPalette.primarySwatch[600] ?? theme.brightness.surfaceColor);
  }

  Color _getTapColor(EasyDevThemeData theme) {
    return widget.tapColor ??
        theme.floatingActionButtonTheme?.tapColor ??
        (theme.brightness == Brightness.light
            ? theme.colorPalette.primarySwatch[600] ?? theme.brightness.surfaceColor
            : theme.colorPalette.primarySwatch[800] ?? theme.brightness.surfaceColor);
  }

  Color _getDisabledColor(EasyDevThemeData theme) {
    return widget.disabledColor ??
        theme.floatingActionButtonTheme?.disabledColor ??
        (theme.brightness == Brightness.light
            ? theme.colorPalette.primarySwatch[50]
            : theme.colorPalette.primarySwatch[900]) ??
        theme.brightness.surfaceColor;
  }

  Color _getColor(EasyDevThemeData theme) {
    return widget.disabled
        ? _getDisabledColor(theme)
        : isTapped
            ? _getTapColor(theme)
            : _getDefaultColor(theme);
  }

  Color? _getIconColor(EasyDevThemeData theme) {
    return (widget.iconColor ?? theme.colorPalette.greySwatch.backgroundColor);
  }

  double _getRadius(EasyDevThemeData theme) {
    return widget.radius ?? theme.floatingActionButtonTheme?.radius ?? 8;
  }

  double _getDefaultElevation(EasyDevThemeData theme) {
    return widget.elevation ?? theme.floatingActionButtonTheme?.elevation ?? 4;
  }

  double _getTapElevation(EasyDevThemeData theme) {
    return widget.tapElevation ?? theme.floatingActionButtonTheme?.tapElevation ?? 16;
  }

  double _getDisabledElevation(EasyDevThemeData theme) {
    return widget.disabledElevation ??
        theme.floatingActionButtonTheme?.disabledElevation ??
        _getDefaultElevation(theme);
  }

  double _getElevation(EasyDevThemeData theme) {
    return widget.disabled
        ? _getDisabledElevation(theme)
        : isTapped
            ? _getTapElevation(theme)
            : _getDefaultElevation(theme);
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.easyDevTheme;
    final size = _getSize(theme);

    return GestureDetector(
      onTapDown: (_) {
        if (widget.disabled) return;
        setState(() => isTapped = true);
      },
      onTapCancel: () {
        if (widget.disabled) return;
        setState(() => isTapped = false);
      },
      onTapUp: (_) {
        if (widget.disabled) return;
        widget.onTap();
        setState(() => isTapped = false);
      },
      child: PhysicalShape(
        clipper: ShapeBorderClipper(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(_getRadius(theme))),
          ),
        ),
        elevation: _getElevation(theme),
        color: _getColor(theme),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          padding: const EdgeInsets.all(8),
          height: size,
          width: size,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _getColor(theme),
            borderRadius: BorderRadius.all(Radius.circular(_getRadius(theme))),
            boxShadow: [
              BoxShadow(
                color: const Color(0x42000000),
                offset: const Offset(0, 3),
                blurRadius: _getElevation(theme),
              )
            ],
          ),
          child: IconTheme(
            data: IconThemeData(
              color: _getIconColor(theme),
            ),
            child: widget.child ?? const SizedBox(),
          ),
        ),
      ),
    );
  }
}
