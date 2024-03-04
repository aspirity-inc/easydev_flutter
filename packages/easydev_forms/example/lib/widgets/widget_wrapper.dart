import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';

import 'dashed_border_paint.dart';

class WidgetWrapper extends StatelessWidget {
  const WidgetWrapper({
    super.key,
    required this.label,
    required this.child,
  });

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = EasyDevTheme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      child: CustomPaint(
        painter: DashPainter(
          color: EasyDevTheme.of(context).colorPalette.greySwatch.onBackgroundColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      label.toUpperCase(),
                      style: theme.typography?.heading4Style,
                      maxLines: 5,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
