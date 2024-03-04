import 'package:easydev_base_ui/easydev_base_ui.dart';
import 'package:easydev_forms/src/indexed_list/indexed_grid_with_fixed_cross_axis_count.dart';
import '../easydev_date_picker/date_picker_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// [DateRangePickerMonth] is internal widget, that used in [EasyDevDateRangePicker]
/// to pick start and end month of [DateRange].
class DateRangeYearPicker extends StatefulWidget {
  const DateRangeYearPicker({
    super.key,
    required this.endYear,
    required this.startYear,
    required this.onCancelTap,
    required this.onOkTap,
    required this.selectedYear,
    required this.decoration,
    this.okButtonText,
    this.cancelButtonText,
    this.gap = 26,
  });

  /// Year of endDate.
  final int endYear;

  /// Year of start date.
  final int startYear;

  /// Callback on cancel button tap.
  final VoidCallback onCancelTap;

  /// Callback on ok button tap.
  final ValueChanged<int> onOkTap;

  /// Selected year will be highlighted.
  final int selectedYear;

  /// {@macro easydev_forms.widgets.easydev_date_picker.date_picker_decoration}
  final DatePickerDecoration decoration;

  /// Distance between
  final double? gap;

  /// Text of "OK" button, reacting on [onOkTap].
  final String? okButtonText;

  /// Text of "Cancel" button, reacting on [onCancelTap].
  final String? cancelButtonText;

  @override
  State<DateRangeYearPicker> createState() => _DateRangeYearPickerState();
}

class _DateRangeYearPickerState extends State<DateRangeYearPicker> {
  late int selectedYear;

  @override
  void initState() {
    selectedYear = widget.selectedYear;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 270,
          height: 270,
          child: IndexedGridWithFixedCrossAxisCount(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.57,
              ),
              physics: const BouncingScrollPhysics(),
              reverse: true,
              positionedIndex: _calculatePositionedIndex(
                widget.endYear - widget.selectedYear,
                widget.endYear - widget.startYear + 1,
              ),
              itemCount: widget.endYear - widget.startYear + 1,
              itemBuilder: (context, index) {
                var year = index % 3 == 0
                    ? widget.endYear - index - 2
                    : (index - 1) % 3 == 0
                        ? widget.endYear - index
                        : widget.endYear - index + 2;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedYear = year;
                    });
                  },
                  behavior: HitTestBehavior.translucent,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: year == selectedYear
                          ? widget.decoration.selectedYearBackgroundColor
                          : null,
                      borderRadius: year == selectedYear ? BorderRadius.circular(8) : null,
                    ),
                    child: Center(
                      child: Text(
                        year.toString(),
                        style: widget.decoration.yearsTextStyle?.copyWith(
                          color: year == selectedYear
                              ? widget.decoration.selectedYearColor
                              : widget.decoration.unselectedYearColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                );
              }),
        ),
        const SizedBox(
          height: 24,
        ),
        Row(
          children: [
            const Spacer(),
            EasyDevButton.text(
              onTap: widget.onCancelTap,
              text: widget.cancelButtonText ?? 'Cancel',
            ),
            const SizedBox(
              width: 30,
            ),
            EasyDevButton.text(
              onTap: () => widget.onOkTap(selectedYear),
              text: widget.okButtonText ?? 'Ok',
            ),
          ],
        ),
      ],
    );
  }

  int _calculatePositionedIndex(int positionedIndex, int itemCount) {
    if (positionedIndex >= itemCount - 15) {
      return itemCount - 15;
    } else {
      return positionedIndex;
    }
  }
}
