import 'package:easydev_basics/src/widgets/easydev_scaffold/easydev_scaffold_layout.dart';
import 'package:flutter/widgets.dart';

/// Internal widget for building [EasyDevScaffold] [MultiChildLayoutDelegate].
/// Scaffold child is wrapped into widget with corresponding [ScaffoldChildren] value.
/// So, [EasyDevScaffoldLayout] can distinguish one from another.
enum ScaffoldChildren {
  body,
  appbar,
  fab,
  bottomNavigationBar,
  snackBar,
  toast,
}
