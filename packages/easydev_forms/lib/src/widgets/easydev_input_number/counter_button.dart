import 'package:easydev_forms/easydev_forms.dart';
import 'package:flutter/widgets.dart';

/// Internal widget for displaying plus and minus buttons on [EasyDevInputNumber].
class CounterButton extends StatelessWidget {
  const CounterButton({
    super.key,
    required this.icon,
    required this.onTap,
    required this.size,
    required this.enabled,
    required this.enabledColor,
    required this.disabledColor,
    required this.counterIconColor,
    required this.radius,
  });

  final IconData icon;
  final VoidCallback onTap;
  final double size;
  final bool enabled;
  final Color enabledColor;
  final Color disabledColor;
  final Color counterIconColor;
  final BorderRadius radius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (enabled) {
          onTap();
        }
      },
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: enabled ? enabledColor : disabledColor,
          borderRadius: radius,
        ),
        child: Center(
          child: Icon(
            icon,
            size: 30,
            color: counterIconColor,
          ),
        ),
      ),
    );
  }
}
