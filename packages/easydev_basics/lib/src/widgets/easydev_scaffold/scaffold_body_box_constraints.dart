import 'package:flutter/widgets.dart';

/// Internal widget for providing [BoxConstraints] to [EasyDevScaffold].
/// Works same as material _ScaffoldBodyBoxConstraints in Scaffold widget.
class ScaffoldBodyBoxConstraints extends BoxConstraints {
  const ScaffoldBodyBoxConstraints({
    super.maxWidth,
    super.maxHeight,
    required this.bottomWidgetsHeight,
    required this.appBarHeight,
  })  : assert(bottomWidgetsHeight >= 0),
        assert(appBarHeight >= 0);

  final double bottomWidgetsHeight;
  final double appBarHeight;

  // RenderObject.layout() will only short-circuit its call to its performLayout
  // method if the new layout constraints are not == to the current constraints.
  // If the height of the bottom widgets has changed, even though the constraints'
  // min and max values have not, we still want performLayout to happen.
  @override
  bool operator ==(Object other) {
    if (super != other) {
      return false;
    }
    return other is ScaffoldBodyBoxConstraints &&
        other.bottomWidgetsHeight == bottomWidgetsHeight &&
        other.appBarHeight == appBarHeight;
  }

  @override
  int get hashCode => Object.hash(super.hashCode, bottomWidgetsHeight, appBarHeight);
}
