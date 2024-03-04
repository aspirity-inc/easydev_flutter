import 'package:easydev_forms/easydev_forms.dart';
import 'package:flutter/widgets.dart';

/// List used [YearPicker] and [MonthPicker] widgets.
class IndexedList extends StatelessWidget {
  /// Create an indexed list.
  IndexedList({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
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
          if (positionedIndex > 0)
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => _buildItem(context, positionedIndex - (index + 1)),
                childCount: positionedIndex,
                addSemanticIndexes: false,
              ),
            ),
          SliverList(
            key: _centerKey,
            delegate: SliverChildBuilderDelegate(
              (context, index) => _buildItem(context, index + positionedIndex),
              childCount: itemCount != 0 ? 1 : 0,
              addSemanticIndexes: false,
            ),
          ),
          if (positionedIndex >= 0 && positionedIndex < itemCount - 1)
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => _buildItem(context, index + positionedIndex + 1),
                childCount: itemCount - positionedIndex - 1,
                addSemanticIndexes: false,
              ),
            ),
        ],
      );

  Widget _buildItem(BuildContext context, int index) {
    return IndexedSemantics(index: index, child: itemBuilder(context, index));
  }
}
