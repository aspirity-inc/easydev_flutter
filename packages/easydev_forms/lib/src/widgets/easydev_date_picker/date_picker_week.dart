import 'package:easydev_forms/src/widgets/easydev_date_picker/date_picker_calendar.dart';

import 'date_picker_decoration.dart';
import 'package:flutter/widgets.dart';

/// Internal widget that shows list of localized days in week on top of [DatePickerCalendar].
class DatePickerWeek extends StatelessWidget {
  const DatePickerWeek({
    super.key,
    required this.weekdaysList,
    required this.decoration,
  });

  /// Localized name of weekdays.
  final List<String> weekdaysList;

  /// {@macro easydev_forms.widgets.easydev_date_picker.date_picker_decoration}
  final DatePickerDecoration decoration;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 1.2,
      ),
      shrinkWrap: true,
      itemCount: 7,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        return Center(
          child: Text(
            weekdaysList[index],
            style: decoration.daysTextStyle?.copyWith(color: decoration.weekdayColor),
            overflow: TextOverflow.ellipsis,
          ),
        );
      },
    );
  }
}
