import 'package:easydev_story_view/src/util/story_data_provider.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';

// Widget used to drag drag stories vertically and pop
class VerticalDragToPop extends StatefulWidget {
  final Widget child;

  final VoidCallback? onDragEndCallBack;

  final VoidCallback? onDragStartCallBack;

  const VerticalDragToPop({
    super.key,
    required this.child,
    this.onDragStartCallBack,
    this.onDragEndCallBack,
  });

  @override
  // ignore: library_private_types_in_public_api
  _VerticalDragToPopState createState() => _VerticalDragToPopState();
}

class _VerticalDragToPopState extends State<VerticalDragToPop> with SingleTickerProviderStateMixin {
  StoryDataProvider? _provider;

  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 250),
  )..addStatusListener(_onAnimationEnd);

  late Animation<Offset> _animation = Tween<Offset>(
    begin: Offset.zero,
    end: Offset.zero,
  ).animate(_animationController);

  Offset? _dragOffset;
  Offset? _previousPosition;
  bool _isDraggingToPop = false;

  @override
  void dispose() {
    _animationController.removeStatusListener(_onAnimationEnd);
    _animationController.dispose();
    super.dispose();
  }

  void _onAnimationEnd(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _animationController.reset();
      _reset();
    }
  }

  @override
  void didChangeDependencies() {
    _provider ??= StoryDataProvider.of(context)!;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, Widget? child) {
        Offset finalOffset = _dragOffset ?? const Offset(0.0, 0.0);
        if (_animation.status == AnimationStatus.forward) {
          finalOffset = _animation.value;
        }

        const maxOpacityWhenDrag = 0.75;
        final bgOpacity = finalOffset.distance == 0.0
            ? 1.0
            : maxOpacityWhenDrag - (finalOffset.dy / 100 / 6).abs();

        final scale = finalOffset.distance == 0.0 ? 1.0 : 1.0 - (finalOffset.dy / 3000).abs();

        return Container(
          color:
              context.easyDevTheme.brightness.surfaceColor.withOpacity(bgOpacity.clamp(0.0, 1.0)),
          child: Transform.scale(
            scale: scale,
            child: Transform.translate(
              offset: finalOffset,
              child: child,
            ),
          ),
        );
      },
      child: GestureDetector(
        onVerticalDragStart: _onDragStart,
        onVerticalDragUpdate: _onDragUpdate,
        onVerticalDragEnd: _onlDragEnd,
        child: widget.child,
      ),
    );
  }

  void _onDragStart(DragStartDetails dragDetails) {
    _isDraggingToPop = true;
    _previousPosition = dragDetails.globalPosition;
    widget.onDragStartCallBack?.call();
  }

  void _setDragOffset(DragUpdateDetails dragUpdateDetails) {
    if (_previousPosition == null) {
      _previousPosition = dragUpdateDetails.globalPosition;
      return;
    }

    final currentPosition = dragUpdateDetails.globalPosition;
    final previousPosition = _previousPosition!;

    final newY = (_dragOffset?.dy ?? 0.0) + (currentPosition.dy - previousPosition.dy);
    _previousPosition = currentPosition;
    setState(() {
      _dragOffset = Offset(0.0, newY);
    });
  }

  void _onDragUpdate(DragUpdateDetails dragUpdateDetails) {
    if (!_isDraggingToPop) return;

    return _setDragOffset(dragUpdateDetails);
  }

  void _onlDragEnd(DragEndDetails? dragEndDetails) {
    if (_dragOffset == null) return;
    final dragOffsetY = _dragOffset!.dy;

    final screenSize = MediaQuery.of(context).size;

    if (dragEndDetails != null) {
      if (dragOffsetY.abs() >= screenSize.height / 3) {
        _provider!.controller.cleanContentIndexes();
        Navigator.of(context).pop();
        return;
      }

      final velocityY = dragEndDetails.velocity.pixelsPerSecond.dy;

      if (velocityY.abs() > 150.0) {
        _provider!.controller.cleanContentIndexes();
        Navigator.of(context).pop();
        return;
      }
      widget.onDragEndCallBack?.call();
    }

    setState(() {
      _animation = Tween<Offset>(
        begin: Offset(0.0, dragOffsetY),
        end: const Offset(0.0, 0.0),
      ).animate(_animationController);
    });

    _animationController.forward();
  }

  void _reset() {
    setState(() {
      _dragOffset = null;
      _previousPosition = null;
      _isDraggingToPop = false;
    });
  }
}
