import 'package:flutter/widgets.dart';

/// The content Page View controller, allows you to find out
/// [itemCount] - the number of pages in the content PageView.
class EasyDevContentPageController extends PageController {
  /// Creates a [EasyDevContentPageController] instance.
  EasyDevContentPageController({
    required this.itemCount,
    super.initialPage,
    super.keepPage,
    super.viewportFraction,
  });

  /// The number of items in the content PageView.
  final int itemCount;
}
