import 'dart:async';

import 'package:easydev_forms/easydev_forms.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';

/// Widget for resending code, when timer is passed, button can be pressed again. Timer starts
/// on widget appearing. It is part of [EnterCodeField] and [EnterCodeWithKeyboard].
class ResendCodeTimer extends StatefulWidget {
  const ResendCodeTimer({
    super.key,
    required this.onSendPressed,
    required this.text,
    required this.buttonText,
    this.seconds = 30,
  });

  /// Initial for button to show up again.
  final int seconds;

  /// Text of timer widget, when time not passed.
  final String text;

  /// Text of button when time is passed.
  final String buttonText;

  /// Callback for button that shows after timer is passed.
  final VoidCallback onSendPressed;

  @override
  State<ResendCodeTimer> createState() => _ResendCodeTimerState();
}

class _ResendCodeTimerState extends State<ResendCodeTimer> {
  late Timer timer;
  late int seconds;

  @override
  void initState() {
    super.initState();
    seconds = widget.seconds;
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  void restartTimer() {
    setState(() {
      timer.cancel();
      seconds = widget.seconds;
    });
    timer = Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  void setCountDown() {
    setState(() {
      seconds--;
      if (seconds == 0) {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.easyDevTheme;

    return seconds != 0
        ? RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    text: widget.text,
                    style: theme.typography?.captionStyle?.copyWith(
                      color: theme.colorPalette.greySwatch.onSurfaceBright,
                    )),
                TextSpan(
                    text: ' ${_formatHours()}${_formatMinutes()}${_formatSeconds()}',
                    style: theme.typography?.captionStyle?.copyWith(
                      color: theme.colorPalette.greySwatch.onSurfaceBright,
                    ))
              ],
            ),
          )
        : GestureDetector(
            onTap: handleSendTap,
            child: Text(
              widget.buttonText,
              style: theme.typography?.captionStyle?.copyWith(
                color: theme.colorPalette.greySwatch.onBackgroundColor,
              ),
            ),
          );
  }

  String _formatSeconds() {
    if (seconds < 10) {
      return '0$seconds';
    }
    return (seconds % 60).toString();
  }

  String _formatMinutes() {
    if (seconds > 3600) {
      return '${((seconds % 3600) ~/ 60)}:';
    }
    return '${seconds ~/ 60}:';
  }

  String _formatHours() {
    if (seconds > 3600) {
      return '${seconds ~/ 60}:';
    }
    return '';
  }

  void handleSendTap() {
    widget.onSendPressed();
    restartTimer();
  }

  @override
  dispose() {
    timer.cancel();
    super.dispose();
  }
}
