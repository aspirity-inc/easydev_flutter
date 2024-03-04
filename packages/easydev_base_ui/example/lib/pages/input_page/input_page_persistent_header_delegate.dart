import 'package:flutter/widgets.dart';

class InputPagePersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final BuildContext context;

  InputPagePersistentHeaderDelegate(
    this.context,
    this.child,
  );

  @override
  Widget build(context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  double _calculateHeight(BuildContext context) {
    final textScale = MediaQuery.textScalerOf(context);
    return -120 + textScale.scale(280);
  }

  @override
  double get maxExtent => _calculateHeight(context);

  @override
  double get minExtent => _calculateHeight(context);

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
