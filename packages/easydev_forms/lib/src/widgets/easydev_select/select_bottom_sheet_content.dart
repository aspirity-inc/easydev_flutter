import 'package:community_material_icon/community_material_icon.dart';
import 'package:easydev_base_ui/easydev_base_ui.dart';
import 'package:easydev_forms/src/easy_dev_scrollbar/easy_dev_scrollbar.dart';
import 'package:easydev_forms/easydev_forms.dart';
import 'package:easydev_forms/src/widgets/easydev_select/easydev_select_decoration.dart';
import 'package:easydev_forms/src/widgets/easydev_select/easydev_select_decoration_widget.dart';
import 'package:easydev_forms/src/widgets/easydev_select/select_info_widget.dart';
import 'package:flutter/widgets.dart';

const _animationDuration = Duration(milliseconds: 175);

/// [SelectBottomSheetContent] is shown by [EasyDevSelect] when withBottomSheet is true.
/// Bottom sheet contains [title], list of [values] and [action] button.
/// When pressed on [action] or "Confirm" button pops back with selected value.
/// Bottom sheet height is can be defined manually in maxHeight property of [EasyDevSelect].
/// Or if not defined, it takes value of distance between top of [EasyDevSelect] and bottom
/// of screen or half of screen height, depending what is large.
class SelectBottomSheetContent<T> extends StatefulWidget {
  const SelectBottomSheetContent({
    super.key,
    required this.selectedValue,
    required this.decoration,
    required this.values,
    required this.maxHeight,
    required this.action,
    required this.titleStyle,
    required this.title,
  });

  final T? selectedValue;
  final EasyDevSelectDecoration decoration;
  final List<EasyDevSelectItem> values;
  final double maxHeight;
  final String? action;
  final TextStyle titleStyle;
  final String? title;

  @override
  State<SelectBottomSheetContent<T>> createState() => _SelectBottomSheetContentState<T>();
}

class _SelectBottomSheetContentState<T> extends State<SelectBottomSheetContent<T>> {
  T? _selectedValue;

  @override
  void initState() {
    _selectedValue = widget.selectedValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return EasyDevSelectDecorationWidget(
      decoration: widget.decoration,
      child: SizedBox(
        height: widget.maxHeight - 34,
        child: Column(
          children: [
            Text(
              widget.title ?? '',
              style: widget.titleStyle,
            ),
            const SizedBox(
              height: 8,
            ),
            SelectInfoWidget(
              selectedValue: _selectedValue,
              onValueChanged: (value) {
                setState(() {
                  _selectedValue = value;
                });
              },
              child: Expanded(
                child: EasyDevScrollbar(
                  scrollbarColor: widget.decoration.scrollbarColor,
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => widget.values[index],
                    separatorBuilder: (context, index) => AnimatedContainer(
                      duration: _animationDuration,
                      height: 1,
                      color: widget.values[index].enabled
                          ? widget.decoration.dividerColor
                          : widget.decoration.disabledTextColor,
                    ),
                    itemCount: widget.values.length,
                  ),
                ),
              ),
            ),
            EasyDevButton(
              text: widget.action ?? 'Confirm',
              onTap: () {
                Navigator.of(context).pop(_selectedValue);
              },
              disabled: _selectedValue == null,
              icon: CommunityMaterialIcons.arrow_right,
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
