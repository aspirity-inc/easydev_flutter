import 'package:easydev_forms/easydev_forms.dart';
import 'package:flutter/widgets.dart';

/// List used [EasyDevDateRangePicker]. Creates [CustomScrollView] with 3
/// [SliverGrid] widgets.
class IndexedGridWithFixedCrossAxisCount extends StatelessWidget {
  /// Create an indexed list.
  IndexedGridWithFixedCrossAxisCount({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    required this.gridDelegate,
    this.controller,
    this.positionedIndex = 0,
    this.reverse = false,
    this.physics,
  })  : assert((positionedIndex == 0) || (positionedIndex < itemCount));

  /// Number of items the [itemBuilder] can produce.
  final int itemCount;

  /// Called to build children for the list with
  /// 0 <= index < itemCount.
  final IndexedWidgetBuilder itemBuilder;

  /// Index of an item
  final int positionedIndex;

  /// SliverGridDelegateWithFixedCrossAxisCount for SliverGrid
  final SliverGridDelegateWithFixedCrossAxisCount gridDelegate;

  /// Whether the view scrolls in the reading direction.
  final bool reverse;

  /// Physics of the scroll
  final ScrollPhysics? physics;

  /// Scroll controller
  final ScrollController? controller;

  final Key _centerKey = UniqueKey();

  @override
  Widget build(BuildContext context) => CustomScrollView(
        controller: controller,
        center: _centerKey,
        reverse: reverse,
        physics: physics,
        slivers: [
          if (positionedIndex > gridDelegate.crossAxisCount - 1)
            SliverGrid(
              gridDelegate: gridDelegate,
              delegate: SliverChildBuilderDelegate(
                (context, index) => _buildItem(
                  context,
                  _getIndexForStartGird(index),
                ),
                childCount: (_getRowFromIndex - 1) * gridDelegate.crossAxisCount,
                addSemanticIndexes: false,
              ),
            ),
          SliverGrid(
            key: _centerKey,
            gridDelegate: gridDelegate,
            delegate: SliverChildBuilderDelegate(
              (context, index) => _buildItem(
                context,
                _getFirstElementFromPositionedRow + index,
              ),
              childCount: itemCount != 0 ? gridDelegate.crossAxisCount : 0,
              addSemanticIndexes: false,
            ),
          ),
          if (positionedIndex >= 0 && positionedIndex < itemCount - 1)
            SliverGrid(
              gridDelegate: gridDelegate,
              delegate: SliverChildBuilderDelegate(
                (context, index) => _buildItem(context,
                    _getFirstElementFromPositionedRow + gridDelegate.crossAxisCount + index),
                childCount: itemCount - positionedIndex - gridDelegate.crossAxisCount,
                addSemanticIndexes: false,
              ),
            ),
        ],
      );

  Widget _buildItem(BuildContext context, int index) {
    return IndexedSemantics(index: index, child: itemBuilder(context, index));
  }

  int get _getRowFromIndex {
    return (positionedIndex ~/ gridDelegate.crossAxisCount) + 1;
  }

  int get _getFirstElementFromPositionedRow {
    return (positionedIndex ~/ gridDelegate.crossAxisCount) * gridDelegate.crossAxisCount;
  }

  int _getIndexForStartGird(int index) {
    final element = _getFirstElementFromPositionedRow - index - 1;

    final positionInRow = element % gridDelegate.crossAxisCount;

    return element + gridDelegate.crossAxisCount - 2 * positionInRow - 1;
  }
}
