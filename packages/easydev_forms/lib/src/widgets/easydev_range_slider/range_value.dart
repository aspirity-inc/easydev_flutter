import 'package:easydev_forms/easydev_forms.dart';
import 'package:flutter/foundation.dart';

/// RangeValue is simple class for containing [EasyDevRangeSlider] values.
class RangeValue {
  const RangeValue(this.start, this.end);

  final double start;
  final double end;

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is RangeValue && other.start == start && other.end == end;
  }

  @override
  int get hashCode => Object.hash(start, end);

  @override
  String toString() {
    return '${objectRuntimeType(this, 'RangeValues')}($start, $end)';
  }

  double get difference => end - start;
}
