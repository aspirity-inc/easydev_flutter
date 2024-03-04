import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';

const _animationDuration = Duration(milliseconds: 175);

/// Items of [EasyDevActionMenu], which represented by generic type.
class EasyDevActionMenuItem<T> extends StatefulWidget {
  /// Create menu item.
  const EasyDevActionMenuItem({
    super.key,
    required this.actionName,
    required this.value,
    this.selected = false,
    this.backgroundColor,
    this.tappedColor,
    this.selectedActionColor,
    this.unselectedActionColor,
    this.style,
    this.padding,
    this.content,
    this.borderRadius,
  });

  /// Name of [EasyDevActionMenuItem].
  final String actionName;

  /// Value of [EasyDevActionMenuItem]. Returned when selected.
  final T value;

  /// Is this widget selected. Selected widget changes style of [actionName].
  final bool selected;

  /// Color of background of widget.
  final Color? backgroundColor;

  /// Color of background of tapped widget.
  final Color? tappedColor;

  /// [Color] of text of [actionName] when [selected] is true.
  final Color? selectedActionColor;

  /// [Color] of text of [actionName] when [selected] is false.
  final Color? unselectedActionColor;

  /// [TextStyle] of [actionName].
  /// Uses [selectedActionColor] and [unselectedActionColor].
  final TextStyle? style;

  /// Padding of widget.
  final EdgeInsets? padding;

  /// If provided what widget is placed instead [Text] with [actionName].
  final Widget? content;

  /// Border radius of widget, overriden in [EasyDevActionMenu].
  final BorderRadius? borderRadius;

  EasyDevActionMenuItem copyWithBorderRadius({
    required BorderRadius borderRadius,
  }) =>
      EasyDevActionMenuItem(
        actionName: actionName,
        value: value,
        selected: selected,
        backgroundColor: backgroundColor,
        tappedColor: tappedColor,
        selectedActionColor: selectedActionColor,
        unselectedActionColor: unselectedActionColor,
        style: style,
        padding: padding,
        content: content,
        borderRadius: borderRadius,
      );

  @override
  State<EasyDevActionMenuItem<T>> createState() => _EasyDevActionMenuItemState<T>();
}

class _EasyDevActionMenuItemState<T> extends State<EasyDevActionMenuItem<T>> {
  bool tapped = false;

  late Color _backgroundColor;
  late Color _tappedColor;
  late TextStyle _selectedActionTextStyle;
  late TextStyle _unselectedActionTextStyle;
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
    final theme = context.easyDevTheme;
    final actionMenuTheme = theme.actionMenuThemeData;
    final greySwatch = theme.colorPalette.greySwatch;
    final light = theme.brightness == Brightness.light;

    _backgroundColor = widget.backgroundColor ??
        actionMenuTheme?.backgroundColor ??
        (light ? greySwatch.surfaceColor : greySwatch.disabledColor ?? greySwatch.surfaceColor);
    _tappedColor = widget.tappedColor ??
        actionMenuTheme?.tappedColor ??
        greySwatch.tappedSurfaceColor ??
        greySwatch.surfaceColor;
    final textStyle = widget.style ??
        actionMenuTheme?.actionStyle ??
        theme.typography?.body1Style?.copyWith(
          fontWeight: FontWeight.w400,
        ) ??
        const TextStyle(fontSize: 18, fontWeight: FontWeight.w400);

    _selectedActionTextStyle = textStyle.copyWith(
      color: light
          ? (theme.colorPalette.primarySwatch[800] ?? theme.colorPalette.primarySwatch)
          : theme.colorPalette.primarySwatch,
    );

    _unselectedActionTextStyle = textStyle.copyWith(
      color: light
          ? (greySwatch.onSurfaceBright ?? greySwatch.onSurfaceColor)
          : greySwatch.dividerColor ?? greySwatch.onSurfaceColor,
    );
    _padding = widget.padding ?? actionMenuTheme?.padding ?? const EdgeInsets.all(16);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        if (!mounted) return;
        setState(() {
          tapped = true;
        });
      },
      onTapCancel: () {
        if (!mounted) return;
        setState(() {
          tapped = false;
        });
      },
      onTapUp: (_) {
        if (!mounted) return;
        Navigator.of(context).pop(widget.value);
        setState(() {
          tapped = false;
        });
      },
      child: AnimatedContainer(
        duration: _animationDuration,
        padding: _padding,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: tapped ? _tappedColor : _backgroundColor,
          borderRadius: widget.borderRadius,
        ),
        child: widget.content ??
            AnimatedDefaultTextStyle(
              duration: _animationDuration,
              style: widget.selected ? _selectedActionTextStyle : _unselectedActionTextStyle,
              child: Text(
                widget.actionName,
              ),
            ),
      ),
    );
  }
}
