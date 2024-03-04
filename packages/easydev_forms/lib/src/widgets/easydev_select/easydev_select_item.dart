import 'package:easydev_forms/src/widgets/easydev_select/easydev_select.dart';
import 'package:easydev_forms/src/widgets/easydev_select/easydev_select_decoration.dart';
import 'package:easydev_forms/src/widgets/easydev_select/easydev_select_decoration_widget.dart';
import 'package:easydev_forms/src/widgets/easydev_select/select_info_widget.dart';
import 'package:flutter/widgets.dart';

const _animationDuration = Duration(milliseconds: 175);

/// Widget that is used to pass options to [EasyDevSelect]. It contains of [value],
/// name that is displayed instead of value, and can be disabled to disallow selection.
/// Callbacks and currently selected widget is provided by [SelectInfoWidget], decorations
/// is provided by [EasyDevSelectDecorationWidget]. So using it outside of select is not
/// recommended.
class EasyDevSelectItem<T> extends StatefulWidget {
  const EasyDevSelectItem({
    super.key,
    required this.value,
    this.enabled = true,
    this.name,
  });

  /// Value of widget.
  final T value;

  /// Is widget enabled.
  final bool enabled;

  /// Name that shows instead of value.
  final String? name;

  @override
  State<EasyDevSelectItem<T>> createState() => _EasyDevSelectItemState<T>();
}

class _EasyDevSelectItemState<T> extends State<EasyDevSelectItem<T>> {
  bool tapped = false;

  Color _getColor(EasyDevSelectDecoration decoration, SelectInfoWidget selectInfoWidget) {
    if (tapped) {
      return decoration.disabledTextColor;
    }
    if ((selectInfoWidget.selectedValue as T?) == widget.value) {
      return decoration.selectedTextColor;
    }
    if (widget.enabled) {
      return decoration.unselectedTextColor;
    }
    return decoration.disabledTextColor;
  }

  @override
  Widget build(BuildContext context) {
    final info = SelectInfoWidget.of(context);
    final decoration = EasyDevSelectDecorationWidget.of(context).decoration;

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
        info.onValueChanged(widget.value);
        setState(() {
          tapped = false;
        });
      },
      child: Row(
        children: [
          Expanded(
            child: AnimatedContainer(
              duration: _animationDuration,
              padding: decoration.itemPadding,
              decoration: BoxDecoration(
                color: tapped ? decoration.tappedColor : null,
                borderRadius: decoration.borderRadius,
              ),
              child: Text(
                widget.name ?? widget.value.toString(),
                style: decoration.textStyle.copyWith(
                  color: _getColor(decoration, info),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
