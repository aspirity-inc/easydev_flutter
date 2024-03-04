import 'package:easydev_base_ui/src/widgets/modal_widgets/action_sheet/action_sheet_decoration_widget.dart';
import 'package:flutter/widgets.dart';

const _animationDuration = Duration(milliseconds: 175);

/// Button that appears above [EasyDevActionSheet].
class CancelActionSheetButton extends StatefulWidget {
  const CancelActionSheetButton({
    super.key,
    required this.title,
    required this.iconData,
    required this.borderRadius,
    this.popOnTap = false,
  });

  /// Text of this button.
  final String title;

  /// Icon of this button.
  final IconData? iconData;

  /// Border radius of this button.
  final BorderRadius borderRadius;
  final bool popOnTap;

  @override
  State<CancelActionSheetButton> createState() => _CancelActionSheetButtonState();
}

class _CancelActionSheetButtonState extends State<CancelActionSheetButton> {
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
        setState(() {
          tapped = false;
        });
      },
      child: PhysicalShape(
        clipper: ShapeBorderClipper(
          shape: RoundedRectangleBorder(
            borderRadius: widget.borderRadius,
          ),
        ),
        color: tapped ? decoration.tappedColor : decoration.backgroundColor,
        elevation: 8,
        child: AnimatedContainer(
          padding: decoration.padding,
          duration: _animationDuration,
          child: Row(
            mainAxisAlignment:
                widget.iconData != null ? MainAxisAlignment.start : MainAxisAlignment.center,
            children: [
              if (widget.iconData != null) ...[
                Icon(
                  widget.iconData,
                  color: decoration.iconColor,
                  size: decoration.iconSize,
                ),
                SizedBox(
                  width: decoration.iconSpacing,
                )
              ],
              Text(
                widget.title,
                style: decoration.actionStyle,
              )
            ],
          ),
        ),
      ),
    );
  }
}
