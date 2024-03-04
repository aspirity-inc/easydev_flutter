import 'package:easydev_forms/src/easy_dev_scrollbar/easy_dev_scrollbar.dart';
import 'package:easydev_forms/src/indexed_list/indexed_list.dart';

import 'date_picker_decoration.dart';
import 'package:flutter/widgets.dart';

/// Creates index list of years, that uses [EasyDevScrollbar] and [IndexedList]
/// for displaying lists. And required to use [DatePickerDecoration].
class YearPicker extends StatelessWidget {
  const YearPicker({
    super.key,
    required this.onTap,
    required this.endYear,
    required this.startYear,
    required this.selectedYear,
    required this.decoration,
    this.gap = 26,
  });

  /// Callback on year selected.
  final ValueChanged<int> onTap;

  /// Last year that shown on list.
  final int endYear;

  /// First year that shown on list.
  final int startYear;

  /// Currently selected year will be highlighted.
  final int selectedYear;

  /// {@macro easydev_forms.widgets.easydev_date_picker.date_picker_decoration}
  final DatePickerDecoration decoration;

  /// Distance between two years in logical pixels.
  final double? gap;

  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();

    return EasyDevScrollbar(
      controller: controller,
      thumbVisibility: true,
      child: IndexedList(
        controller: controller,
        physics: const BouncingScrollPhysics(),
        reverse: true,
        itemCount: endYear - startYear + 1,
        positionedIndex: _calculatePositionedIndex(
          endYear - selectedYear,
          endYear - startYear + 1,
        ),
        itemBuilder: (context, index) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => onTap(index),
              behavior: HitTestBehavior.translucent,
              child: Text(
                (endYear - index).toString(),
                style: decoration.monthsTextStyle?.copyWith(
                  color: endYear - index == selectedYear
                      ? decoration.selectedMonthColor
                      : decoration.unselectedMonthColor,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              height: gap,
            )
          ],
        ),
      ),
    );
  }

  int _calculatePositionedIndex(int positionedIndex, int itemCount) {
    if (positionedIndex >= itemCount - 6) {
      return itemCount - 6;
    } else {
      return positionedIndex;
    }
  }
}
