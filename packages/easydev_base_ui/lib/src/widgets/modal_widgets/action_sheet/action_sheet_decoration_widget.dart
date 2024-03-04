import 'package:easydev_base_ui/src/widgets/modal_widgets/action_sheet/action_sheet_decoration.dart';
import 'package:flutter/widgets.dart';

/// Widget used to provide decoration for [EasyDevActionSheet].
class ActionSheetDecorationWidget extends InheritedWidget {
  const ActionSheetDecorationWidget({
    super.key,
    required this.decoration,
    required super.child,
  });

  final ActionSheetDecoration decoration;

  static ActionSheetDecorationWidget of(BuildContext context) {
    final ActionSheetDecorationWidget? actionSheetDecoration =
        context.dependOnInheritedWidgetOfExactType<ActionSheetDecorationWidget>();
    assert(actionSheetDecoration != null, 'No ActionSheetDecoration found in context');
    return actionSheetDecoration!;
  }

  @override
  bool updateShouldNotify(ActionSheetDecorationWidget oldWidget) =>
      decoration != oldWidget.decoration;
}
