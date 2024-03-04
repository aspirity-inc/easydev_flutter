import 'package:community_material_icon/community_material_icon.dart';
import 'package:easydev_base_ui/easydev_base_ui.dart';
import 'package:easydev_forms/src/easy_dev_scrollbar/easy_dev_scrollbar.dart';
import 'package:easydev_forms/easydev_forms.dart';
import 'package:easydev_forms/src/widgets/easydev_multiselect/multiselect_decoration.dart';
import 'package:easydev_forms/src/widgets/easydev_multiselect/multiselect_decoration_widget.dart';
import 'package:easydev_forms/src/widgets/easydev_multiselect/multiselect_values_widget.dart';
import 'package:flutter/widgets.dart';

const _animationDuration = Duration(milliseconds: 175);

/// [MultiselectBottomSheetContent] is shown by [EasyDevMultiSelect] when withBottomSheet is true.
/// Bottom sheet contains [title], list of [values] and [action] button.
/// When pressed on [action] or "Confirm" button pops back with selected value.
/// Bottom sheet height is can be defined manually in maxHeight property of [EasyDevMultiSelect].
/// Or if not defined, it takes value of distance between top of [EasyDevMultiSelect] and bottom
/// of screen or half of screen height, depending what is large.
class MultiselectBottomSheetContent<T> extends StatefulWidget {
  const MultiselectBottomSheetContent({
    super.key,
    required this.selectedValues,
    required this.decoration,
    required this.values,
    required this.maxHeight,
    required this.action,
    required this.titleStyle,
    required this.title,
  });

  final List<T> selectedValues;
  final MultiselectDecoration decoration;
  final List<EasyDevMultiselectItem> values;
  final double maxHeight;
  final String? action;
  final TextStyle titleStyle;
  final String? title;

  @override
  State<MultiselectBottomSheetContent<T>> createState() => _MultiselectBottomSheetContentState<T>();
}

class _MultiselectBottomSheetContentState<T> extends State<MultiselectBottomSheetContent<T>> {
  List<T> _selectedValues = [];

  @override
  void initState() {
    _selectedValues = widget.selectedValues;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiselectDecorationWidget(
      decoration: widget.decoration,
      child: SizedBox(
        height: widget.maxHeight - 34,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: widget.decoration.itemPadding.left,
                ),
                Flexible(
                  child: Text(
                    widget.title ?? '',
                    style: widget.titleStyle,
                  ),
                ),
                SizedBox(
                  width: widget.decoration.itemPadding.right,
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            MultiselectValuesWidget(
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
                      color: widget.decoration.dividerColor,
                    ),
                    itemCount: widget.values.length,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            EasyDevButton(
              text: widget.action ?? 'Confirm',
              onTap: () {
                Navigator.of(context).pop(_selectedValues);
              },
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
