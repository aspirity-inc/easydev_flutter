import 'package:easydev_forms/easydev_forms.dart';
import 'package:flutter/widgets.dart';

/// Internal [InheritedWidget] that allows passing [onValueChanged] callback
/// and currently selected value to [EasyDevSelectItem]s. That widget is created to remove
/// passing current value and callback on value selected to [EasyDevSelectItem].
class SelectInfoWidget extends InheritedWidget {
  const SelectInfoWidget({
    super.key,
    required this.selectedValue,
    required this.onValueChanged,
    required super.child,
  });

  /// Parameter of generic type T, from [EasyDevSelect]
  /// Is dynamic because passing generic parameters have some issues when they are passed
  /// from inherited widget.
  final dynamic selectedValue;

  /// Parameter with inner type T (ValueChanged<T>), from [EasyDevSelect].
  /// Is dynamic because passing generic parameters have some issues when they are passed
  /// from inherited widget.
  final ValueChanged onValueChanged;

  static SelectInfoWidget of(BuildContext context) {
    final SelectInfoWidget? selectInfoWidget =
        context.dependOnInheritedWidgetOfExactType<SelectInfoWidget>();

    assert(selectInfoWidget != null, 'No SelectInfoWidget found in context');
    return selectInfoWidget!;
  }

  @override
  bool updateShouldNotify(SelectInfoWidget oldWidget) => selectedValue != oldWidget.selectedValue;
}
