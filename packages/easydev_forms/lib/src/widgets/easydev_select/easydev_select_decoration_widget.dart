import 'package:easydev_forms/easydev_forms.dart';
import 'package:easydev_forms/src/widgets/easydev_select/easydev_select_decoration.dart';
import 'package:easydev_forms/src/widgets/easydev_select/select_bottom_sheet_content.dart';
import 'package:flutter/widgets.dart';

/// Internal [InheritedWidget] for providing [EasyDevSelectDecoration] to widgets down to widget
/// tree. Used in [EasyDevSelectItem] and [SelectBottomSheetContent].
class EasyDevSelectDecorationWidget extends InheritedWidget {
  const EasyDevSelectDecorationWidget({
    super.key,
    required this.decoration,
    required super.child,
  });

  /// {@macro easydev_forms.widgets.easydev_select.easydev_select_decoration}
  final EasyDevSelectDecoration decoration;

  static EasyDevSelectDecorationWidget of(BuildContext context) {
    final EasyDevSelectDecorationWidget? selectDecorationWidget =
        context.dependOnInheritedWidgetOfExactType<EasyDevSelectDecorationWidget>();
    assert(selectDecorationWidget != null, 'No EasyDevSelectDecorationWidget found in context');
    return selectDecorationWidget!;
  }

  @override
  bool updateShouldNotify(EasyDevSelectDecorationWidget oldWidget) =>
      decoration != oldWidget.decoration;
}
