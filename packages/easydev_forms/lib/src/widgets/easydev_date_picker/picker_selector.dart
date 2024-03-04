import 'package:easydev_forms/easydev_forms.dart';
import 'package:flutter/widgets.dart';

/// [PickerSelector] is internal [EasyDevDatePicker] widget, that used as month and year field,
/// so user can click on it and go to previous step.
class PickerSelector extends StatelessWidget {
  const PickerSelector({
    super.key,
    required this.onTap,
    required this.text,
    required this.isActive,
    required this.decoration,
    this.icon,
  });

  /// Callback on picker tapped.
  final VoidCallback onTap;

  /// Text displayed in picker.
  final String text;

  /// Icon on the picker.
  final IconData? icon;

  /// When picker is selected it is inactive and do not react on user tap.
  final bool isActive;

  /// {@macro easydev_forms.widgets.easydev_date_picker.date_picker_decoration}
  final DatePickerDecoration decoration;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Row(
        children: [
          Text(
            text,
            style: decoration.monthsTextStyle?.copyWith(
              color: isActive ? decoration.activeColor : decoration.inactiveColor,
            ),
          ),
          const SizedBox(
            width: 9,
          ),
          if (icon != null) ...[
            Icon(
              icon,
              color: decoration.iconColor,
              size: 24,
            ),
            const SizedBox(
              width: 5,
            )
          ],
        ],
      ),
    );
  }
}
