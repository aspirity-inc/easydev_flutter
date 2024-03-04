import 'package:easydev_forms/src/easy_dev_scrollbar/easy_dev_scrollbar.dart';
import 'package:easydev_forms/easydev_forms.dart';
import 'package:easydev_forms/src/indexed_list/indexed_list.dart';
import 'package:flutter/widgets.dart';

/// [MonthPicker] is internal widget, that used in [EasyDevDatePicker] to pick month in
/// date.
class MonthPicker extends StatelessWidget {
  const MonthPicker({
    super.key,
    required this.onTap,
    required this.monthsList,
    required this.selectedMonth,
    required this.decoration,
    required this.endMonth,
    this.gap = 26,
  });

  /// Callback on selecting month.
  final ValueChanged<int> onTap;

  /// Localized list of months.
  final List<String> monthsList;

  /// Currently selected month will be highlighted.
  final int selectedMonth;

  /// Index of last month to show.
  final int endMonth;

  /// {@macro easydev_forms.widgets.easydev_date_picker.date_picker_decoration}
  final DatePickerDecoration decoration;

  /// Distance between two month in logical pixels.
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
        itemCount: endMonth,
        positionedIndex: _calculatePositionedIndex(selectedMonth - 1),
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => onTap(index),
                behavior: HitTestBehavior.translucent,
                child: Text(
                  monthsList[index],
                  style: decoration.monthsTextStyle?.copyWith(
                      color: index + 1 == selectedMonth
                          ? decoration.selectedMonthColor
                          : decoration.unselectedMonthColor),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                height: gap,
              ),
            ],
          );
        },
      ),
    );
  }

  int _calculatePositionedIndex(
    int positionedIndex,
  ) {
    if (positionedIndex >= endMonth - 6 && endMonth - 6 > 0) {
      return endMonth - 6;
    } else {
      return positionedIndex;
    }
  }
}
