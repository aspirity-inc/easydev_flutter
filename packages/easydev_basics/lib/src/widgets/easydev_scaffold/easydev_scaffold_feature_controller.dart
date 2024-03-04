import 'dart:async';

import 'package:easydev_basics/easydev_basics.dart';
import 'package:flutter/widgets.dart';

/// EasyDevScaffoldFeatureController is used in [EasyDevScaffold] and [EasyDevScaffoldMessenger]
/// to message information about [EasyDevToast]s and [EasyDevSnackBar] closing and completing.
class EasyDevScaffoldFeatureController<T extends Widget> {
  const EasyDevScaffoldFeatureController(
    this.widget,
    this.completer,
    this.close,
  );

  final T widget;
  final Completer<CloseReason> completer;

  /// Completes when the feature controlled by this object is no longer visible.
  Future<CloseReason> get closed => completer.future;

  /// Remove the feature (e.g., bottom sheet, snack bar, or material banner) from the scaffold.
  final VoidCallback close;
}
