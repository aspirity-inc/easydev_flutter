import 'dart:math';

import 'package:easydev_basics/easydev_basics.dart';
import 'package:easydev_forms/src/widgets/easydev_multiselect/easydev_multiselect_item.dart';
import 'package:easydev_forms/src/widgets/easydev_multiselect/multiselect_bottom_sheet_content.dart';
import 'package:easydev_forms/src/widgets/easydev_multiselect/multiselect_decoration.dart';
import 'package:easydev_forms/src/widgets/easydev_multiselect/multiselect_decoration_widget.dart';
import 'package:easydev_forms/src/widgets/easydev_multiselect/multiselect_overlay.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';

const _animationDuration = Duration(milliseconds: 175);

/// Internal widget, that displays hints, it can be different, depending on [selectedValues] is not
/// empty. Widget in becomes active and changes icon from [icon] to [activeIcon] and calling
/// [EasyDevBottomSheet] or [OverlayEntry] depending on [withBottomSheet] property.
/// This widget can be disabled by providing turning [enabled] field to false.
class MultiselectWidget<T> extends StatefulWidget {
  const MultiselectWidget({
    super.key,
    required this.items,
    required this.valuesChanged,
    required this.selectedValues,
    required this.icon,
    required this.activeIcon,
    required this.selectedItemHint,
    required this.hint,
    required this.enabled,
    required this.withBottomSheet,
    required this.itemsSelected,
    required this.decoration,
    required this.maxHeight,
    required this.bottomSheetTitle,
    required this.confirmAction,
    required this.barrierColor,
  });

  final List<EasyDevMultiselectItem> items;
  final ValueChanged<List<T>> valuesChanged;
  final List<T> selectedValues;
  final IconData icon;
  final IconData activeIcon;
  final String selectedItemHint;
  final String hint;
  final bool enabled;
  final bool withBottomSheet;
  final bool itemsSelected;
  final MultiselectDecoration decoration;
  final double? maxHeight;
  final String? bottomSheetTitle;
  final String? confirmAction;
  final Color? barrierColor;

  @override
  State<MultiselectWidget<T>> createState() => _MultiselectWidgetState<T>();
}

class _MultiselectWidgetState<T> extends State<MultiselectWidget<T>> {
  OverlayEntry? _overlayEntry;
  bool active = false;
  bool tapped = false;

  @override
  Widget build(BuildContext context) {
    final theme = context.easyDevTheme;
    final barrierColor = widget.barrierColor ??
        (theme.brightness == Brightness.dark
            ? (theme.colorPalette.secondarySwatch?[400]?.withOpacity(0.42) ??
                const Color(0x6BFFFFFF))
            : const Color(0x6B000000));

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
        widget.withBottomSheet
            ? _showBottomSheet(widget.decoration, barrierColor)
            : _showOverlay(widget.decoration);
        setState(() {
          tapped = false;
        });
      },
      child: AnimatedContainer(
        duration: _animationDuration,
        padding: widget.decoration.itemPadding,
        decoration: BoxDecoration(
          color: tapped ? widget.decoration.selectedColor : widget.decoration.backgroundColor,
          borderRadius: widget.decoration.borderRadius,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.itemsSelected ? widget.selectedItemHint : widget.hint,
              style: widget.decoration.textStyle.copyWith(
                color: widget.enabled
                    ? widget.decoration.textColor
                    : widget.decoration.disabledTextColor,
              ),
            ),
            Icon(
              active ? widget.activeIcon : widget.icon,
              color: widget.enabled
                  ? widget.decoration.iconColor
                  : widget.decoration.disabledTextColor,
            ),
          ],
        ),
      ),
    );
  }

  void _showOverlay(MultiselectDecoration decoration) {
    setState(() {
      active = true;
    });
    final NavigatorState navigator = Navigator.of(context);
    assert(_overlayEntry == null);
    final RenderBox itemBox = context.findRenderObject()! as RenderBox;
    final Rect rect = itemBox.localToGlobal(
          Offset.zero,
          ancestor: navigator.context.findRenderObject(),
        ) &
        itemBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return MultiselectDecorationWidget(
          decoration: decoration,
          child: MultiselectOverlay(
            onTap: (values) {
              _overlayEntry?.remove();

              _overlayEntry = null;
              setState(() {
                active = false;
              });
              widget.valuesChanged(values);
            },
            maxHeight: widget.maxHeight,
            decoration: decoration,
            itemRect: rect,
            values: widget.items,
            selectedValues: widget.selectedValues,
          ),
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _showBottomSheet(MultiselectDecoration decoration, Color barrierColor) async {
    setState(() {
      active = true;
    });
    final RenderBox itemBox = context.findRenderObject()! as RenderBox;
    final Rect itemRect = itemBox.localToGlobal(
          Offset.zero,
          ancestor: Navigator.of(context).context.findRenderObject(),
        ) &
        itemBox.size;
    final mediaQueryHeight = MediaQuery.of(context).size.height;

    final height = widget.maxHeight ?? max(mediaQueryHeight - itemRect.top, mediaQueryHeight * 0.5);

    final result = await showEasyDevBottomSheet(
      context: context,
      barrierDismissible: true,
      barrierColor: barrierColor,
      builder: (context) => EasyDevBottomSheet(
        maxHeight: height,
        child: MultiselectBottomSheetContent(
          selectedValues: widget.selectedValues,
          decoration: decoration,
          values: widget.items,
          maxHeight: height,
          action: widget.confirmAction ?? 'Confirm',
          titleStyle: widget.decoration.bottomSheetTitleStyle,
          title: widget.bottomSheetTitle ?? widget.hint,
        ),
      ),
    );
    if (result is List<T>) {
      widget.valuesChanged(result);
    }
    setState(() {
      active = false;
    });
  }
}
