import 'dart:math';

import 'package:easydev_basics/src/widgets/easydev_scaffold/scaffold_body_box_constraints.dart';
import 'package:flutter/widgets.dart';

/// Internal widget for building scaffold layout.
class ScaffoldBodyBuilder extends StatelessWidget {
  const ScaffoldBodyBuilder({
    super.key,
    required this.body,
    required this.extendBody,
    required this.bottomInset,
    this.topPadding,
  });

  final Widget body;
  final bool extendBody;
  final double bottomInset;
  final double? topPadding;

  @override
  Widget build(BuildContext context) {
    if (!extendBody) {
      return body;
    }

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final ScaffoldBodyBoxConstraints bodyConstraints =
            constraints as ScaffoldBodyBoxConstraints;
        final MediaQueryData metrics = MediaQuery.of(context);

        final double bottom = extendBody
            ? max(metrics.padding.bottom, bodyConstraints.bottomWidgetsHeight)
            : metrics.padding.bottom;

        final double top = metrics.padding.top;

        return MediaQuery(
          data: metrics.copyWith(
            padding: metrics.padding.copyWith(
              top: top,
              bottom: bottom,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              top: topPadding ?? 0,
            ),
            child: body,
          ),
        );
      },
    );
  }
}
