import 'package:flutter/widgets.dart';

import 'dart:math' as math;

class EasyDevTabController extends ChangeNotifier {
  EasyDevTabController({
    int initialIndex = 0,
    Duration? animationDuration,
    required this.length,
    required TickerProvider vsync,
  })  : assert(length >= 0),
        assert(initialIndex >= 0 && (length == 0 || initialIndex < length)),
        _index = initialIndex,
        _previousIndex = initialIndex,
        _animationDuration = animationDuration ?? const Duration(milliseconds: 300),
        _animationController = AnimationController.unbounded(
          value: initialIndex.toDouble(),
          vsync: vsync,
        );

  EasyDevTabController._({
    required int index,
    required int previousIndex,
    required AnimationController? animationController,
    required Duration animationDuration,
    required this.length,
  })  : _index = index,
        _previousIndex = previousIndex,
        _animationController = animationController,
        _animationDuration = animationDuration;

  EasyDevTabController _copyWith({
    required int? index,
    required int? length,
    required int? previousIndex,
    required Duration? animationDuration,
  }) {
    if (index != null) {
      _animationController!.value = index.toDouble();
    }
    return EasyDevTabController._(
      index: index ?? _index,
      length: length ?? this.length,
      animationController: _animationController,
      previousIndex: previousIndex ?? _previousIndex,
      animationDuration: animationDuration ?? _animationDuration,
    );
  }

  /// An animation whose value represents the current position [EasyDevTabBar]
  /// indicator of the selected tab.
  Animation<double>? get animation => _animationController?.view;
  AnimationController? _animationController;

  /// Controls the duration of [EasyDevDefaultTabBar] and  [EasyDevTabBarView] animations.
  Duration get animationDuration => _animationDuration;
  final Duration _animationDuration;

  /// The total number of tabs
  /// Must match [EasyDevTabBar.tabs]'s and [EasyDevTabBarView.children]'s length.
  final int length;

  /// The index of the currently selected tab.
  int get index => _index;
  int _index;

  set index(int value) {
    _changeIndex(value);
  }

  /// The index of the previously selected tab.
  int get previousIndex => _previousIndex;
  int _previousIndex;

  /// True while an animation is happening.
  bool get indexIsChanging => _indexIsChangingCount != 0;
  int _indexIsChangingCount = 0;

  /// The difference between the [animation]'s value and [index].
  double get offset => _animationController!.value - _index.toDouble();

  set offset(double value) {
    if (value == offset) {
      return;
    }
    _animationController!.value = value + _index.toDouble();
  }

  void _changeIndex(int value, {Duration? duration, Curve? curve}) {
    if (value == _index || length < 2) {
      return;
    }
    _previousIndex = index;
    _index = value;
    if (duration != null && duration > Duration.zero) {
      _indexIsChangingCount += 1;
      notifyListeners();
      _animationController!
          .animateTo(_index.toDouble(), duration: duration, curve: curve!)
          .whenCompleteOrCancel(() {
        if (_animationController != null) {
          _indexIsChangingCount -= 1;
          notifyListeners();
        }
      });
    } else {
      _indexIsChangingCount += 1;
      _animationController!.value = _index.toDouble();
      _indexIsChangingCount -= 1;
      notifyListeners();
    }
  }

  void animateTo(int value, {Duration? duration, Curve curve = Curves.ease}) {
    _changeIndex(value, duration: duration ?? _animationDuration, curve: curve);
  }

  @override
  void dispose() {
    _animationController?.dispose();
    _animationController = null;
    super.dispose();
  }
}

class _TabControllerScope extends InheritedWidget {
  const _TabControllerScope({
    required this.controller,
    required this.enabled,
    required super.child,
  });

  final EasyDevTabController controller;
  final bool enabled;

  @override
  bool updateShouldNotify(_TabControllerScope old) {
    return enabled != old.enabled || controller != old.controller;
  }
}

class EasyDevDefaultTabController extends StatefulWidget {
  const EasyDevDefaultTabController({
    super.key,
    required this.length,
    this.initialIndex = 0,
    required this.child,
    this.animationDuration,
  })  : assert(length >= 0),
        assert(length == 0 || (initialIndex >= 0 && initialIndex < length));

  /// The total number of tabs
  /// Must match [EasyDevTabBar.tabs]'s and [EasyDevTabBarView.children]'s length.
  final int length;

  /// The initial index of the selected tab. Defaults to zero.
  final int initialIndex;

  /// Controls the duration of [EasyDevDefaultTabBar] and  [EasyDevTabBarView] animations.
  final Duration? animationDuration;

  /// The widget below this widget in the tree.
  final Widget child;

  static EasyDevTabController? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_TabControllerScope>()?.controller;
  }

  static EasyDevTabController of(BuildContext context) {
    final EasyDevTabController? controller = maybeOf(context);
    assert(() {
      if (controller == null) {
        throw FlutterError(
            'EasyDevDefaultTabController.of() was called with a context that does not contain a EasyDevDefaultTabController widget.');
      }
      return true;
    }());
    return controller!;
  }

  @override
  State<EasyDevDefaultTabController> createState() => _EasyDevDefaultTabControllerState();
}

class _EasyDevDefaultTabControllerState extends State<EasyDevDefaultTabController>
    with SingleTickerProviderStateMixin {
  late EasyDevTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = EasyDevTabController(
      vsync: this,
      length: widget.length,
      initialIndex: widget.initialIndex,
      animationDuration: widget.animationDuration,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _TabControllerScope(
      controller: _controller,
      enabled: TickerMode.of(context),
      child: widget.child,
    );
  }

  @override
  void didUpdateWidget(EasyDevDefaultTabController oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.length != widget.length) {
      int? newIndex;
      int previousIndex = _controller.previousIndex;
      if (_controller.index >= widget.length) {
        newIndex = math.max(0, widget.length - 1);
        previousIndex = _controller.index;
      }
      _controller = _controller._copyWith(
        length: widget.length,
        animationDuration: widget.animationDuration,
        index: newIndex,
        previousIndex: previousIndex,
      );
    }

    if (oldWidget.animationDuration != widget.animationDuration) {
      _controller = _controller._copyWith(
        length: widget.length,
        animationDuration: widget.animationDuration,
        index: _controller.index,
        previousIndex: _controller.previousIndex,
      );
    }
  }
}
