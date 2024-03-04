import 'package:easydev_base_ui/src/widgets/modal_widgets/action_sheet/action_sheet_decoration_widget.dart';
import 'package:easydev_base_ui/src/widgets/modal_widgets/action_sheet/easydev_action_sheet.dart';
import 'package:flutter/widgets.dart';

const _animationDuration = Duration(milliseconds: 175);

class EasyDevActionSheetItem extends StatefulWidget {
  const EasyDevActionSheetItem({
    super.key,
    required this.onTap,
    required this.text,
    this.last = false,
    this.icon,
    this.backgroundColor,
    this.tappedColor,
    this.iconColor,
    this.iconSize,
    this.iconSpacing,
    this.padding,
    this.actionStyle,
    this.popOnTap = false,
  });

  /// Callback on action tap.
  final VoidCallback onTap;

  /// Text of action.
  final String text;

  /// Last action, is overridden in [EasyDevActionSheet].
  final bool last;

  /// Leading icon of action.
  final IconData? icon;

  /// Background [Color] of action, when not provided, takes it from [EasyDevActionSheet].
  final Color? backgroundColor;

  /// [Color] of action when tapped on it,
  /// when not provided, takes it from [EasyDevActionSheet].
  final Color? tappedColor;

  /// [Color] of action when tapped on it,
  /// when not provided, takes it from  [EasyDevActionSheet].
  final Color? iconColor;

  /// Size of [icon], when not provided it takes it from [EasyDevActionSheet].
  final double? iconSize;

  /// Spacing between [icon] and text, when not provided it takes it from [EasyDevActionSheet].
  final double? iconSpacing;

  /// Padding of action, when not provided it takes it from [EasyDevActionSheet].
  final EdgeInsets? padding;

  /// Text style of [text], when not provided it takes it from [EasyDevActionSheet].
  final TextStyle? actionStyle;

  /// If true, [Navigator] will pop when this item is tapped
  final bool popOnTap;

  EasyDevActionSheetItem copyAndOverrideLast({
    required bool last,
  }) =>
      EasyDevActionSheetItem(
        onTap: onTap,
        text: text,
        last: last,
        icon: icon,
        backgroundColor: backgroundColor,
        tappedColor: tappedColor,
        iconColor: iconColor,
        iconSize: iconSize,
        iconSpacing: iconSpacing,
        padding: padding,
        actionStyle: actionStyle,
      );

  @override
  State<EasyDevActionSheetItem> createState() => _EasyDevActionSheetItemState();
}

class _EasyDevActionSheetItemState extends State<EasyDevActionSheetItem> {
  bool tapped = false;

  @override
  Widget build(BuildContext context) {
    final decoration = ActionSheetDecorationWidget.of(context).decoration;

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
        if (widget.popOnTap) Navigator.of(context).pop();
        widget.onTap();
        setState(() {
          tapped = false;
        });
      },
      child: AnimatedContainer(
        padding: widget.padding ?? decoration.padding,
        duration: _animationDuration,
        decoration: BoxDecoration(
          color: tapped
              ? widget.tappedColor ?? decoration.tappedColor
              : widget.backgroundColor ?? decoration.backgroundColor,
          borderRadius: widget.last
              ? BorderRadius.only(
                  bottomLeft: decoration.modalRadius.bottomLeft,
                  bottomRight: decoration.modalRadius.bottomRight,
                )
              : BorderRadius.zero,
        ),
        child: Row(
          mainAxisAlignment:
              widget.icon != null ? MainAxisAlignment.start : MainAxisAlignment.center,
          children: [
            if (widget.icon != null) ...[
              Icon(
                widget.icon,
                color: widget.iconColor ?? decoration.iconColor,
                size: widget.iconSize ?? decoration.iconSize,
              ),
              SizedBox(
                width: widget.iconSpacing ?? decoration.iconSpacing,
              )
            ],
            Text(
              widget.text,
              style: widget.actionStyle ?? decoration.actionStyle,
            ),
          ],
        ),
      ),
    );
  }
}
