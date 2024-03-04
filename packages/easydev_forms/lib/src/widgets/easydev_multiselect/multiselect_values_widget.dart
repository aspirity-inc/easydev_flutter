import 'package:easydev_forms/easydev_forms.dart';
import 'package:flutter/widgets.dart';

/// Internal [InheritedWidget] that allows passing [onValueChanged] callback
/// and currently selected value to [EasyDevMultiselectItem]s. That widget is created to remove
/// passing [selectedValues] and callback on value selected to [EasyDevMultiselectItem].
class MultiselectValuesWidget extends InheritedWidget {
  const MultiselectValuesWidget({
    super.key,
    required this.selectedValues,
    required this.onValueChanged,
    required super.child,
  });

  /// Parameter of generic type T, from [EasyDevMultiSelect]
  /// Is dynamic because passing generic parameters have some issues when they are passed
  /// from inherited widget.
  final List<dynamic> selectedValues;

  /// Parameter with inner type T (ValueChanged<T>), from [EasyDevMultiSelect].
  /// Is dynamic because passing generic parameters have some issues when they are passed
  /// from inherited widget.
  final ValueChanged onValueChanged;

  static MultiselectValuesWidget of(BuildContext context) {
    final MultiselectValuesWidget? valuesWidget =
        context.dependOnInheritedWidgetOfExactType<MultiselectValuesWidget>();

    assert(valuesWidget != null, 'No MultiselectValuesWidget found in context');
    return valuesWidget!;
  }

  @override
  bool updateShouldNotify(MultiselectValuesWidget oldWidget) =>
      selectedValues != oldWidget.selectedValues;
}
