import 'dart:async';
import 'dart:collection';
import 'package:easydev_basics/src/widgets/easydev_scaffold/easydev_scaffold.dart';
import 'package:easydev_basics/src/widgets/easydev_scaffold/easydev_scaffold_feature_controller.dart';
import 'package:easydev_basics/src/widgets/easydev_scaffold/scaffold_messanger_inherited_widget.dart';
import 'package:easydev_basics/src/widgets/easydev_snackbar/easydev_snackbar.dart';
import 'package:easydev_basics/src/widgets/easydev_toast/easy_dev_toast.dart';
import 'package:flutter/widgets.dart';

/// [EasyDevScaffoldMessenger] allows user to call [EasyDevToast]s and [EasyDevSnackBar]s.
/// It is required having at least one [EasyDevScaffold] for it to work, as it uses scaffold
/// for showing toasts and snackbars.
/// Scaffold messenger have method showing toast and snackbars. It has similar api for
/// showing toasts and snackbars, hideCurrentToast and hideCurrentSnackbar are used to
/// play animation of toast/snackbar disappearing and then removes it.
/// removeCurrentToast and removeCurrentSnackbar instanly removes it.
/// clearSnackBars and clearToasts clears all entries and plays hide animation for last toast
/// or snackbar.
///
/// See also:
///
///  * [EasyDevScaffold], main layout widget of Easydev.
///  * [EasyDevToast], android style pop up messages.
///  * [EasyDevSnackBar], another way of displaying info to user.
class EasyDevScaffoldMessenger extends StatefulWidget {
  const EasyDevScaffoldMessenger({
    super.key,
    required this.child,
  });
  final Widget child;
  static EasyDevScaffoldMessengerState of(BuildContext context) {
    final ScaffoldMessengerInheritedWidget scope =
        context.dependOnInheritedWidgetOfExactType<ScaffoldMessengerInheritedWidget>()!;
    return scope.messengerState;
  }

  static EasyDevScaffoldMessengerState? maybeOf(BuildContext context) {
    final ScaffoldMessengerInheritedWidget? scope =
        context.dependOnInheritedWidgetOfExactType<ScaffoldMessengerInheritedWidget>();
    return scope?.messengerState;
  }

  @override
  State<EasyDevScaffoldMessenger> createState() => EasyDevScaffoldMessengerState();
}

class EasyDevScaffoldMessengerState extends State<EasyDevScaffoldMessenger>
    with TickerProviderStateMixin {
  final LinkedHashSet<EasyDevScaffoldState> _scaffolds = LinkedHashSet<EasyDevScaffoldState>();

  /// Do not use outside easydev_base_ui library. It's internal scaffold messenger variable.
  final Queue<EasyDevScaffoldFeatureController<EasyDevToast>> toasts =
      Queue<EasyDevScaffoldFeatureController<EasyDevToast>>();

  /// Do not use outside easydev_base_ui library. It's internal scaffold messenger variable.
  final Queue<EasyDevScaffoldFeatureController<EasyDevSnackBar>> snackBars =
      Queue<EasyDevScaffoldFeatureController<EasyDevSnackBar>>();
  AnimationController? _snackBarController;
  Timer? _snackBarTimer;
  AnimationController? _toastController;
  Timer? _toastTimer;

  /// Do not use outside easydev_base_ui library. It's internal scaffold messenger method.
  void register(EasyDevScaffoldState scaffold) {
    _scaffolds.add(scaffold);
    if (_isRoot(scaffold)) {
      if (snackBars.isNotEmpty) {
        scaffold.updateSnackBar();
      }
      if (toasts.isNotEmpty) {
        scaffold.updateToast();
      }
    }
  }

// SNACKBAR API
  /// Method for showing snackBars.
  EasyDevScaffoldFeatureController<EasyDevSnackBar> showSnackBar(
    EasyDevSnackBar snackBar, [
    Duration? duration,
  ]) {
    assert(
      _scaffolds.isNotEmpty,
      'EasyDevScaffoldMessenger.showSnackBar was called, but there are currently no '
      'descendant EasyDevScaffolds to present to.',
    );
    _snackBarController ??= EasyDevSnackBar.createAnimationController(
      vsync: this,
      animationDuration: duration,
    )..addStatusListener(_handleSnackBarStatusChanged);
    if (snackBars.isEmpty) {
      assert(_snackBarController!.isDismissed);
      _snackBarController!.forward();
    }
    late EasyDevScaffoldFeatureController<EasyDevSnackBar> controller;
    controller = EasyDevScaffoldFeatureController<EasyDevSnackBar>(
      snackBar.withAnimation(_snackBarController!, fallbackKey: UniqueKey()),
      Completer<CloseReason>(),
      () {
        assert(snackBars.first == controller);
        hideCurrentSnackBar();
      },
    );
    setState(() {
      snackBars.addLast(controller);
    });
    updateScaffolds();
    return controller;
  }

  void _handleSnackBarStatusChanged(AnimationStatus status) {
    switch (status) {
      case AnimationStatus.dismissed:
        assert(snackBars.isNotEmpty);
        setState(() {
          snackBars.removeFirst();
        });
        updateScaffolds();
        if (snackBars.isNotEmpty) {
          _snackBarController!.forward();
        }
      case AnimationStatus.completed:
        setState(() {
          assert(_snackBarTimer == null);
// build will create a new timer if necessary to dismiss the snackBar.
        });
        updateScaffolds();
      case AnimationStatus.forward:
        break;
      case AnimationStatus.reverse:
        break;
    }
  }

  /// Removes current snackbar instantly.
  void removeCurrentSnackBar({CloseReason reason = CloseReason.remove}) {
    if (snackBars.isEmpty) {
      return;
    }
    final Completer<CloseReason> completer = snackBars.first.completer;
    if (!completer.isCompleted) {
      completer.complete(reason);
    }
    _snackBarTimer?.cancel();
    _snackBarTimer = null;
    _snackBarController!.value = 0.0;
  }

  /// Plays animation for snackbar disappearing and removes snackbar.
  void hideCurrentSnackBar({CloseReason reason = CloseReason.hide}) {
    if (snackBars.isEmpty || _snackBarController!.status == AnimationStatus.dismissed) {
      return;
    }
    final Completer<CloseReason> completer = snackBars.first.completer;
    _snackBarController!.reverse().then<void>((void value) {
      assert(mounted);
      if (!completer.isCompleted) {
        completer.complete(reason);
      }
    });
    _snackBarTimer?.cancel();
    _snackBarTimer = null;
  }

  /// Removes all snackbars from snackbar queue.
  void clearSnackBars() {
    if (snackBars.isEmpty || _snackBarController!.status == AnimationStatus.dismissed) {
      return;
    }
    final EasyDevScaffoldFeatureController<EasyDevSnackBar> currentSnackbar = snackBars.first;
    snackBars.clear();
    snackBars.add(currentSnackbar);
    hideCurrentSnackBar();
  }

// END OF TOAST API
// TOAST API
  /// Method for showing toasts.
  EasyDevScaffoldFeatureController<EasyDevToast> showToast(
    EasyDevToast toast, [
    Duration? duration,
  ]) {
    assert(
      _scaffolds.isNotEmpty,
      'EasyDevScaffoldMessenger.showToast was called, but there are currently no '
      'descendant EasyDevScaffolds to present to.',
    );
    _toastController ??= EasyDevToast.createAnimationController(
      vsync: this,
      animationDuration: duration,
    )..addStatusListener(_handleToastStatusChanged);
    if (toasts.isEmpty) {
      assert(_toastController!.isDismissed);
      _toastController!.forward();
    }
    late EasyDevScaffoldFeatureController<EasyDevToast> controller;
    controller = EasyDevScaffoldFeatureController<EasyDevToast>(
      toast.withAnimation(_toastController!, fallbackKey: UniqueKey()),
      Completer<CloseReason>(),
      () {
        assert(toasts.first == controller);
        hideCurrentToast();
      },
    );
    setState(() {
      toasts.addLast(controller);
    });
    updateScaffolds();
    return controller;
  }

  void _handleToastStatusChanged(AnimationStatus status) {
    switch (status) {
      case AnimationStatus.dismissed:
        assert(toasts.isNotEmpty);
        setState(() {
          toasts.removeFirst();
        });
        updateScaffolds();
        if (toasts.isNotEmpty) {
          _toastController!.forward();
        }
      case AnimationStatus.completed:
        setState(() {
          assert(_toastTimer == null);
// build will create a new timer if necessary to dismiss the snackBar.
        });
        updateScaffolds();
      case AnimationStatus.forward:
        break;
      case AnimationStatus.reverse:
        break;
    }
  }

  /// Removes current toast instantly.
  void removeCurrentToast({CloseReason reason = CloseReason.remove}) {
    if (toasts.isEmpty) {
      return;
    }
    final Completer<CloseReason> completer = toasts.first.completer;
    if (!completer.isCompleted) {
      completer.complete(reason);
    }
    _toastTimer?.cancel();
    _toastTimer = null;
// This will trigger the animation's status callback.
    _toastController!.value = 0.0;
  }

  /// Plays animation for toast disappearing and removes it.
  void hideCurrentToast({CloseReason reason = CloseReason.hide}) {
    if (toasts.isEmpty || _toastController!.status == AnimationStatus.dismissed) {
      return;
    }
    final Completer<CloseReason> completer = toasts.first.completer;
    _toastController!.reverse().then<void>((void value) {
      assert(mounted);
      if (!completer.isCompleted) {
        completer.complete(reason);
      }
    });
    _toastTimer?.cancel();
    _toastTimer = null;
  }

  /// Removes all toasts from toast queue.
  void clearToasts() {
    if (toasts.isEmpty || _snackBarController!.status == AnimationStatus.dismissed) {
      return;
    }
    final EasyDevScaffoldFeatureController<EasyDevToast> currentSnackbar = toasts.first;
    toasts.clear();
    toasts.add(currentSnackbar);
    hideCurrentSnackBar();
  }

// END OF TOAST API
  /// Do not use outside easydev_base_ui library. It's internal scaffold messenger method.
  void unregister(EasyDevScaffoldState scaffold) {
    final bool removed = _scaffolds.remove(scaffold);
    assert(removed);
  }

  /// Do not use outside easydev_base_ui library. It's internal scaffold messenger method.
  void updateScaffolds() {
    for (final EasyDevScaffoldState scaffold in _scaffolds) {
      if (_isRoot(scaffold)) {
        scaffold.updateSnackBar();
        scaffold.updateToast();
      }
    }
  }

  bool _isRoot(EasyDevScaffoldState scaffold) {
    final EasyDevScaffoldState? parent =
        scaffold.context.findAncestorStateOfType<EasyDevScaffoldState>();
    return parent == null || !_scaffolds.contains(parent);
  }

  @override
  Widget build(BuildContext context) {
    if (snackBars.isNotEmpty) {
      final ModalRoute<dynamic>? route = ModalRoute.of(context);
      if (route == null || route.isCurrent) {
        if (_snackBarController!.isCompleted && _snackBarTimer == null) {
          final EasyDevSnackBar snackBar = snackBars.first.widget;
          _snackBarTimer = Timer(snackBar.duration, () {
            assert(
              _snackBarController!.status == AnimationStatus.forward ||
                  _snackBarController!.status == AnimationStatus.completed,
            );
            hideCurrentSnackBar(reason: CloseReason.timeout);
          });
        }
      }
    }
    if (toasts.isNotEmpty) {
      final ModalRoute<dynamic>? route = ModalRoute.of(context);
      if (route == null || route.isCurrent) {
        if (_toastController!.isCompleted && _snackBarTimer == null) {
          final EasyDevToast toast = toasts.first.widget;
          _toastTimer = Timer(toast.duration, () {
            assert(
              _toastController!.status == AnimationStatus.forward ||
                  _toastController!.status == AnimationStatus.completed,
            );
            hideCurrentToast(reason: CloseReason.timeout);
          });
        }
      }
    }
    return ScaffoldMessengerInheritedWidget(
      messengerState: this,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _snackBarController?.dispose();
    _snackBarTimer?.cancel();
    _snackBarTimer = null;
    _toastController?.dispose();
    _toastTimer?.cancel();
    _toastTimer = null;
    super.dispose();
  }
}
