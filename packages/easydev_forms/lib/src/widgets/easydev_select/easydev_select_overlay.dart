import 'package:easydev_forms/src/easy_dev_scrollbar/easy_dev_scrollbar.dart';
import 'package:easydev_forms/src/widgets/easydev_select/easydev_select_decoration.dart';

import 'easydev_select_item.dart';
import 'package:flutter/widgets.dart';

const _animationDuration = Duration(milliseconds: 175);

/// Creates overlay content, that shows [EasyDevSelectItem] values as overlay content.
/// It is returned in builder function of [OverlayEntry], that is called in [EasyDevSelect],
/// if select is shows overlay instead of bottom sheet.
class SelectOverlayContent extends StatelessWidget {
  const SelectOverlayContent({
    super.key,
    required this.onTap,
    required this.maxHeight,
    required this.values,
    required this.itemRect,
    required this.decoration,
  });

  /// Callback on tapping on area, outside of overlay list.
  final VoidCallback onTap;

  /// Max height of overlay decorated list.
  final double? maxHeight;

  /// [Rect] of [EasyDevSelect], used to align decorated list to bottom left of widget.
  final Rect itemRect;

  /// {@macro easydev_forms.widgets.easydev_select.easydev_select_decoration}
  final EasyDevSelectDecoration decoration;

  /// Values provided by [EasyDevSelect].
  final List<EasyDevSelectItem> values;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      final contentHeight = constraints.maxHeight;
      final totalHeightNeeded = itemRect.bottom + maxHeight!;
      final bottomPadding =
          totalHeightNeeded > contentHeight ? totalHeightNeeded - contentHeight : 0.0;

      return Stack(
        children: [
          GestureDetector(
            onTap: onTap,
            behavior: HitTestBehavior.opaque,
          ),
          Positioned(
            top: itemRect.bottom,
            left: itemRect.left,
            child: PhysicalShape(
              color: decoration.backgroundColor,
              clipper: const ShapeBorderClipper(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
              elevation: 8,
              child: SizedBox(
                width: itemRect.width,
                height: maxHeight,
                child: EasyDevScrollbar(
                  scrollbarColor: decoration.scrollbarColor,
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                    itemBuilder: (context, index) => index != values.length
                        ? values[index]
                        : SizedBox(
                            height: bottomPadding,
                          ),
                    separatorBuilder: (context, index) => AnimatedContainer(
                      duration: _animationDuration,
                      height: 1,
                      color: values[index].enabled
                          ? decoration.dividerColor
                          : decoration.disabledTextColor,
                    ),
                    itemCount: values.length + 1,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
