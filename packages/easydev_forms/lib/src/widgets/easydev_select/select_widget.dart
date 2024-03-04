import 'package:easydev_forms/src/widgets/easydev_select/easydev_select_decoration.dart';
import 'package:easydev_forms/src/widgets/easydev_select/easydev_select_item.dart';
import 'package:flutter/widgets.dart';

const _animationDuration = Duration(milliseconds: 175);

/// Internal widget for displaying selected value or hint.
class SelectWidget extends StatefulWidget {
  const SelectWidget({
    super.key,
    required this.icon,
    required this.item,
    required this.hint,
    required this.enabled,
    required this.active,
    required this.decoration,
    required this.onTap,
  });

  /// Trailing icon of widget.
  final IconData icon;

  /// Selected item of widget.
  final EasyDevSelectItem? item;

  /// Hint that shown when value is not selected.
  final String hint;

  /// Is this widget enabled or it do not react on pressing.
  final bool enabled;

  /// Active widget means that widget is currently showing bottom sheet or overlay.
  final bool active;

  /// {@macro easydev_forms.widgets.easydev_select.easydev_select_decoration}
  final EasyDevSelectDecoration decoration;

  /// Callback on [enabled] widget tap.
  final VoidCallback onTap;

  @override
  State<SelectWidget> createState() => _SelectWidgetState();
}

class _SelectWidgetState extends State<SelectWidget> {
  bool tapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        if (!mounted || !widget.enabled) return;
        setState(() {
          tapped = true;
        });
      },
      onTapCancel: () {
        if (!mounted || !widget.enabled) return;
        setState(() {
          tapped = false;
        });
      },
      onTapUp: (_) {
        if (!mounted || !widget.enabled) return;
        widget.onTap();
        setState(() {
          tapped = false;
        });
      },
      child: AnimatedContainer(
        duration: _animationDuration,
        padding: widget.decoration.itemPadding,
        decoration: BoxDecoration(
          color: tapped ? widget.decoration.tappedColor : widget.decoration.backgroundColor,
          borderRadius: widget.decoration.borderRadius,
          border: Border.fromBorderSide(
            BorderSide(
              color: widget.active
                  ? widget.decoration.activeBorderColor
                  : widget.enabled
                      ? widget.decoration.borderColor
                      : widget.decoration.disabledColor,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (widget.item != null)
              Text(
                widget.item!.name ?? widget.item!.value.toString(),
                style: widget.decoration.textStyle.copyWith(
                  color: widget.enabled
                      ? widget.decoration.textColor
                      : widget.decoration.disabledTextColor,
                ),
              )
            else
              Text(
                widget.hint,
                style: widget.decoration.textStyle.copyWith(
                  color: widget.enabled
                      ? widget.decoration.textColor
                      : widget.decoration.disabledTextColor,
                ),
              ),
            Icon(
              widget.icon,
              color: widget.enabled ? widget.decoration.iconColor : widget.decoration.disabledColor,
            ),
          ],
        ),
      ),
    );
  }
}
