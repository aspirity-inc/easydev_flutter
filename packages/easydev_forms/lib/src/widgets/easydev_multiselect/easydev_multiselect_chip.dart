import 'package:community_material_icon/community_material_icon.dart';
import 'package:easydev_forms/easydev_forms.dart';
import 'package:easydev_forms/src/widgets/easydev_multiselect/multiselect_widget.dart';
import 'package:flutter/widgets.dart';

const _animationDuration = Duration(milliseconds: 175);

/// [EasyDevMultiselectChip] is widget displayed under [MultiselectWidget]
/// in [EasyDevMultiSelect]. contains delete icon, that is calling [onDelete] callback when
/// tapped.
class EasyDevMultiselectChip<T> extends StatefulWidget {
  const EasyDevMultiselectChip({
    super.key,
    required this.value,
    required this.enabled,
    required this.name,
    required this.icon,
    required this.onDelete,
    required this.padding,
    required this.radius,
    required this.color,
    required this.tappedColor,
    required this.disabledColor,
    required this.iconColor,
    required this.style,
  });

  /// Value of widget.
  final T value;

  /// Is widget enabled.
  final bool enabled;

  /// Name that shows instead of value.
  final String? name;

  /// Overrides icon on selected widget.
  final IconData? icon;

  /// Callback on chip delete.
  final ValueChanged<T> onDelete;

  /// Inner padding of chip.
  final EdgeInsets padding;

  /// Border radius of chip.
  final BorderRadius radius;

  /// Color of chip.
  final Color color;

  /// Color of tapped chip.
  final Color tappedColor;

  /// Color of disabled chip.
  final Color disabledColor;

  /// Colors of delete icon in chip.
  final Color iconColor;

  /// Style of chip texts.
  final TextStyle style;

  @override
  State<EasyDevMultiselectChip<T>> createState() => _EasyDevMultiselectChipState<T>();
}

class _EasyDevMultiselectChipState<T> extends State<EasyDevMultiselectChip<T>> {
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
        widget.onDelete(widget.value);
        setState(() {
          tapped = false;
        });
      },
      child: AnimatedContainer(
        duration: _animationDuration,
        padding: widget.padding,
        decoration: BoxDecoration(
          color: !widget.enabled
              ? widget.disabledColor
              : tapped
                  ? widget.tappedColor
                  : widget.color,
          borderRadius: widget.radius,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                widget.name ?? widget.value.toString(),
                style: widget.style,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Icon(widget.icon ?? CommunityMaterialIcons.close, color: widget.iconColor),
          ],
        ),
      ),
    );
  }
}
