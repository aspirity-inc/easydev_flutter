import 'package:community_material_icon/community_material_icon.dart';
import 'package:easydev_forms/src/widgets/easydev_multiselect/multiselect_decoration.dart';
import 'package:easydev_forms/src/widgets/easydev_multiselect/multiselect_decoration_widget.dart';
import 'package:easydev_forms/src/widgets/easydev_multiselect/multiselect_values_widget.dart';
import 'package:flutter/widgets.dart';

const _animationDuration = Duration(milliseconds: 175);

/// Widget that is used to pass options to [EasydevMultiselect]. It contains of [value],
/// name that is displayed instead of value, and can be disabled to disallow selection.
/// Callbacks and currently selected widget is provided by [MultiselectValuesWidget], decorations
/// is provided by [MultiselectDecorationWidget]. So using it outside of select is not
/// recommended.
class EasyDevMultiselectItem<T> extends StatefulWidget {
  const EasyDevMultiselectItem({
    super.key,
    required this.value,
    this.enabled = true,
    this.name,
    this.icon,
  });

  /// Value of widget.
  final T value;

  /// Is widget enabled.
  final bool enabled;

  /// Name that shows instead of value.
  final String? name;

  /// Overrides icon on selected widget.
  final IconData? icon;

  @override
  State<EasyDevMultiselectItem<T>> createState() => _EasyDevMultiselectItemState<T>();
}

class _EasyDevMultiselectItemState<T> extends State<EasyDevMultiselectItem<T>> {
  bool tapped = false;

  Color _getTextColor(MultiselectDecoration decoration, bool selected) {
    if (!widget.enabled) {
      return decoration.disabledTextColor;
    }
    if (selected) {
      return decoration.selectedTextColor;
    }
    return decoration.textColor;
  }

  Color _getColor(MultiselectDecoration decoration, bool selected) {
    if (tapped) {
      return selected ? decoration.backgroundColor : decoration.selectedColor;
    }
    return selected ? decoration.selectedColor : decoration.backgroundColor;
  }

  @override
  Widget build(BuildContext context) {
    final decoration = MultiselectDecorationWidget.of(context).decoration;
    final valuesWidget = MultiselectValuesWidget.of(context);
    final selected = valuesWidget.selectedValues.contains(widget.value);

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
        valuesWidget.onValueChanged(widget.value);
        setState(() {
          tapped = false;
        });
      },
      child: AnimatedContainer(
        duration: _animationDuration,
        padding: decoration.itemPadding,
        decoration: BoxDecoration(
          color: _getColor(decoration, selected),
          borderRadius: decoration.borderRadius,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.name ?? widget.value.toString(),
              style: decoration.textStyle.copyWith(
                color: _getTextColor(decoration, selected),
              ),
            ),
            if (selected)
              Icon(
                widget.icon ?? CommunityMaterialIcons.check,
                color: decoration.iconColor,
              )
            else
              const SizedBox(
                height: 24,
              ),
          ],
        ),
      ),
    );
  }
}
