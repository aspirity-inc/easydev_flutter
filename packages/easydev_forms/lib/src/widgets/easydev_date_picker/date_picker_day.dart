import 'package:flutter/widgets.dart';

/// Internal widget for showing day.
class DatePickerDay extends StatelessWidget {
  const DatePickerDay({
    super.key,
    required this.text,
    this.borderRadius,
    this.border,
    this.color,
    this.style,
  });

  /// Text displayed in widget.
  final String text;

  /// Text style of [text] property.
  final TextStyle? style;

  /// [Color] of widget.
  final Color? color;

  /// [Border] of widget.
  final Border? border;

  /// [BorderRadius] os widget.
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: border,
        borderRadius: borderRadius,
        color: color,
      ),
      child: Center(
        child: Text(
          text,
          style: style,
        ),
      ),
    );
  }
}
