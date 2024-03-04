import 'package:easydev_forms/easydev_forms.dart';
import 'package:flutter/widgets.dart';

/// Internal widget for displaying carets [EnterCodeWithKeyboard].
class CaretWidget extends StatefulWidget {
  const CaretWidget({
    super.key,
    required this.caretSize,
    required this.currentSymbol,
    required this.length,
    required this.caretColor,
    required this.size,
    required this.backgroundColor,
    required this.focused,
  });

  /// Size of caret, defaults to 22 and scales with text scale.
  final double? caretSize;

  /// Current position of caret.
  final int currentSymbol;

  /// Length of code.
  final int length;

  /// Color of caret.
  final Color caretColor;

  /// Color of background for caret to disappear.
  final Color? backgroundColor;

  /// Size of item, scales with text scale.
  final double size;

  /// Caret only shows when in has focus.
  final bool focused;

  @override
  State<CaretWidget> createState() => _CaretWidgetState();
}

class _CaretWidgetState extends State<CaretWidget> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _tween;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )
      ..forward()
      ..addStatusListener(
        (status) async {
          if (status == AnimationStatus.completed) {
            await Future.delayed(
              const Duration(
                milliseconds: 200,
              ),
            );
            if (mounted) {
              _controller.forward(from: 0);
            }
          }
        },
      );
    _tween = ColorTween(
      begin: widget.caretColor,
      end: widget.backgroundColor,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInQuad,
      ),
    );
  }

  @override
  void didUpdateWidget(covariant CaretWidget oldWidget) {
    _tween = ColorTween(
      begin: widget.caretColor,
      end: widget.backgroundColor,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInQuad,
      ),
    );
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final scaledSize = MediaQuery.of(context).textScaler.scale(widget.size);
    final scaledCaret = MediaQuery.of(context).textScaler.scale(22);

    if (!widget.focused) {
      return const SizedBox();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...List.generate(
          widget.length,
          (index) => Padding(
            padding: index - 1 == widget.length
                ? EdgeInsets.zero
                : const EdgeInsets.only(
                    right: 8,
                  ),
            child: SizedBox(
              height: scaledSize,
              width: scaledSize,
              child: index == widget.currentSymbol
                  ? Align(
                      alignment: Alignment.center,
                      child: AnimatedBuilder(
                        animation: _tween,
                        builder: (context, _) => Container(
                          margin: const EdgeInsets.only(left: 1),
                          width: 2,
                          height: widget.caretSize ?? scaledCaret,
                          color: _tween.value,
                        ),
                      ),
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
