import 'package:easydev_basics/easydev_basics.dart';
import 'package:easydev_basics/src/widgets/easydev_bottom_sheet/bottom_sheet_route.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';

/// Method for showing modal bottom sheet.
/// Widget that will be shown on bottom sheet needs to be returned
/// from result of [builder] function.
/// [barrierColor] is color that colors rest of content, displaing that bottom sheet is
/// in modal route, not just on top of other widgets.
/// [barrierDismissible] property allows to dismiss [BottomSheetRoute] by clicking in barrier
/// area.
/// This sample shows calling bottom sheet with showEasyDevBottomSheet function
///
/// See code in example/lib/pages/easydev_bottom_sheet_examples/easydev_bottom_sheet_example.dart
/// See also:
///
///  * [EasyDevBottomSheet], bottom sheet widget for EasyDev.
showEasyDevBottomSheet({
  required BuildContext context,
  required Widget Function(BuildContext) builder,
  Color? barrierColor,
  bool barrierDismissible = true,
}) async {
  final navigator = Navigator.of(context);
  final theme = context.easyDevTheme;

  return await navigator.push(
    BottomSheetRoute(
      child: Builder(builder: builder),
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor ??
          (theme.brightness == Brightness.light
              ? theme.colorPalette.greySwatch.tappedSurfaceColor?.withOpacity(0.5)
              : theme.brightness.surfaceColor.withOpacity(0.5)),
    ),
  );
}
