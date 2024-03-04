import 'package:easydev_forms/src/easy_dev_scrollbar/easy_dev_scrollbar.dart';
import 'package:easydev_forms/src/widgets/easydev_multiselect/easydev_multiselect_item.dart';
import 'package:easydev_forms/src/widgets/easydev_multiselect/multiselect_decoration.dart';
import 'package:easydev_forms/src/widgets/easydev_multiselect/multiselect_values_widget.dart';
import 'package:flutter/widgets.dart';

const _animationDuration = Duration(milliseconds: 175);

/// Creates overlay content, that shows [EasyDevMultiselectItem] values as overlay content.
/// It is returned in builder function of [OverlayEntry], that is called in [EasyDevMultiselect],
/// if select is shows overlay instead of bottom sheet.
class MultiselectOverlay<T> extends StatefulWidget {
  const MultiselectOverlay({
    super.key,
    required this.onTap,
    required this.selectedValues,
    required this.maxHeight,
    required this.values,
    required this.itemRect,
    required this.decoration,
  });

  final ValueChanged<List<T>> onTap;
  final List<T> selectedValues;
  final double? maxHeight;
  final Rect itemRect;
  final MultiselectDecoration decoration;
  final List<EasyDevMultiselectItem> values;

  @override
  State<MultiselectOverlay<T>> createState() => _MultiselectOverlayState<T>();
}

class _MultiselectOverlayState<T> extends State<MultiselectOverlay<T>> {
  late List<T> _selectedValues;

  @override
  void initState() {
    _selectedValues = widget.selectedValues;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      final contentHeight = constraints.maxHeight;
      final totalHeightNeeded = widget.itemRect.bottom + widget.maxHeight!;
      final bottomPadding =
          totalHeightNeeded > contentHeight ? totalHeightNeeded - contentHeight : 0.0;

      return MultiselectValuesWidget(
        selectedValues: _selectedValues,
        onValueChanged: (value) {
          if (_selectedValues.contains(value as T)) {
            setState(() {
              _selectedValues = _selectedValues.where((element) => element != value).toList();
            });
          } else {
            setState(() {
              _selectedValues = [..._selectedValues, value];
            });
          }
        },
        child: Stack(
          children: [
            GestureDetector(
              onTap: () => widget.onTap(_selectedValues),
              behavior: HitTestBehavior.opaque,
            ),
            Positioned(
              top: widget.itemRect.bottom + 1,
              left: widget.itemRect.left,
              child: PhysicalShape(
                color: const Color(0x00000000),
                clipper: ShapeBorderClipper(
                  shape: RoundedRectangleBorder(
                    borderRadius: widget.decoration.borderRadius,
                  ),
                ),
                elevation: 8,
                child: SizedBox(
                  width: widget.itemRect.width,
                  height: widget.maxHeight,
                  child: EasyDevScrollbar(
                    scrollbarColor: widget.decoration.scrollbarColor,
                    child: ListView.separated(
                      physics: const ClampingScrollPhysics(
                        parent: BouncingScrollPhysics(),
                      ),
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => index != widget.values.length
                          ? widget.values[index]
                          : SizedBox(
                              height: bottomPadding,
                            ),
                      separatorBuilder: (context, index) => AnimatedContainer(
                        duration: _animationDuration,
                        height: 1,
                        color: widget.decoration.dividerColor,
                      ),
                      itemCount: widget.values.length + 1,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
