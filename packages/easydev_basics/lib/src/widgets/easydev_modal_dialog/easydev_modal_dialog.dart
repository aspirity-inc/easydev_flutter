import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';

/// [EasyDevModalDialog] is widget that contains base layout for modal dialog it can be
/// pushed on top of other apps by using [showEasyDevModalDialog] method by passing
/// it to modal property.
class EasyDevModalDialog extends StatefulWidget {
  /// Create modal dialog
  const EasyDevModalDialog({
    super.key,
    this.title,
    this.subtitle,
    this.child,
    this.width,
    this.height,
    this.backgroundColor,
    this.borderRadius,
    this.padding,
    this.margin,
    this.elevation,
    this.titleTextStyle,
    this.subtitleTextStyle,
  });

  /// Title for modal dialog.
  final String? title;

  /// Subtitle for modal dialog.
  final String? subtitle;

  /// Child for modal dialog.
  final Widget? child;

  /// Width of modal dialog.
  final double? width;

  /// Height of modal dialog.
  final double? height;

  /// Elevation of modal dialog.
  final double? elevation;

  /// Background color of modal dialog.
  final Color? backgroundColor;

  /// Border radius of modal dialog.
  final BorderRadius? borderRadius;

  /// Padding of modal dialog.
  final EdgeInsets? padding;

  /// Margin of modal dialog.
  final EdgeInsets? margin;

  /// Text style of title.
  final TextStyle? titleTextStyle;

  /// Text style of subtitle.
  final TextStyle? subtitleTextStyle;

  @override
  State<EasyDevModalDialog> createState() => _EasyDevModalDialogState();
}

class _EasyDevModalDialogState extends State<EasyDevModalDialog> {
  late double? _width;
  late double? _height;
  late double _elevation;
  late Color _backgroundColor;
  late BorderRadius _borderRadius;
  late EdgeInsets _padding;
  late EdgeInsets _margin;
  late TextStyle _titleTextStyle;
  late TextStyle _subtitleTextStyle;

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
    final dialogTheme = theme.dialogTheme;

    _backgroundColor = widget.backgroundColor ??
        dialogTheme?.backgroundColor ??
        (theme.brightness == Brightness.light
            ? colorPalette.greySwatch.surfaceColor
            : colorPalette.greySwatch.disabledColor ?? colorPalette.greySwatch.greyColor);
    _titleTextStyle = widget.titleTextStyle ??
        dialogTheme?.titleTextStyle ??
        theme.typography?.heading2Style ??
        const TextStyle();
    _subtitleTextStyle = widget.subtitleTextStyle ??
        dialogTheme?.subtitleTextStyle ??
        theme.typography?.body1Style ??
        const TextStyle();
    _width = widget.width ?? dialogTheme?.width ?? double.infinity;
    _height = widget.height ?? dialogTheme?.height;
    _margin = widget.margin ?? dialogTheme?.margin ?? EdgeInsets.zero;
    _padding = widget.padding ??
        dialogTheme?.padding ??
        const EdgeInsets.symmetric(vertical: 40, horizontal: 16);
    _borderRadius = widget.borderRadius ?? dialogTheme?.borderRadius ?? BorderRadius.circular(8);
    _elevation = widget.elevation ?? dialogTheme?.elevation ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _margin,
      child: PhysicalShape(
        color: _backgroundColor,
        clipper: ShapeBorderClipper(
          shape: RoundedRectangleBorder(
            borderRadius: _borderRadius,
          ),
        ),
        elevation: _elevation,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: Container(
            padding: _padding,
            height: _height,
            width: _width,
            child: Column(
              children: [
                if (widget.title != null) ...[
                  Text(
                    widget.title!,
                    style: _titleTextStyle,
                  ),
                  SizedBox(
                    height: widget.subtitle != null ? 8 : 40,
                  )
                ],
                if (widget.subtitle != null) ...[
                  Text(
                    widget.subtitle!,
                    style: _subtitleTextStyle,
                  ),
                  if (widget.child != null)
                    const SizedBox(
                      height: 40,
                    ),
                ],
                if (widget.child != null) widget.child!,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
