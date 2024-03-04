import 'package:easydev_basics/easydev_basics.dart';
import 'package:flutter/widgets.dart';

/// Internal widget for providing access to [EasyDevScaffoldMessenger] state.
/// [EasyDevScaffoldMessengerState] have methods for calling, removing and hiding [EasyDevSnackBar]
/// and [EasyDevToast].
/// See also:
///
///  * [EasyDevScaffoldMessenger], that have methods
///  for calling [EasyDevToast] and [EasyDevSnackBar]
///  * [EasyDevToast], android style pop-up message.
///  * [EasyDevSnackBar], pop-up message in bottom of the screen for displaying message to user.
class ScaffoldMessengerInheritedWidget extends InheritedWidget {
  const ScaffoldMessengerInheritedWidget({
    super.key,
    required super.child,
    required this.messengerState,
  });

  final EasyDevScaffoldMessengerState messengerState;

  @override
  bool updateShouldNotify(ScaffoldMessengerInheritedWidget oldWidget) {
    return messengerState != oldWidget.messengerState;
  }
}
