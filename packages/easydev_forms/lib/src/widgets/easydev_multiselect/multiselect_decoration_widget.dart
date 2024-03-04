import 'package:easydev_forms/src/widgets/easydev_multiselect/easydev_multiselect_item.dart';
import 'package:easydev_forms/src/widgets/easydev_multiselect/multiselect_bottom_sheet_content.dart';
import 'package:easydev_forms/src/widgets/easydev_multiselect/multiselect_decoration.dart';
import 'package:flutter/widgets.dart';

/// Internal [InheritedWidget] containing [MultiselectDecoration] providing it to widgets down
/// to widget tree. Used in [EasyDevMultiselectItem] and [MultiselectBottomSheetContent].
class MultiselectDecorationWidget extends InheritedWidget {
  const MultiselectDecorationWidget({
    super.key,
    required this.decoration,
    required super.child,
  });

  final MultiselectDecoration decoration;

  static MultiselectDecorationWidget of(BuildContext context) {
    final MultiselectDecorationWidget? decorationWidget =
        context.dependOnInheritedWidgetOfExactType<MultiselectDecorationWidget>();
    assert(decorationWidget != null, 'No EasyDevSelectDecorationWidget found in context');
    return decorationWidget!;
  }

  @override
  bool updateShouldNotify(MultiselectDecorationWidget oldWidget) =>
      decoration != oldWidget.decoration;
}
