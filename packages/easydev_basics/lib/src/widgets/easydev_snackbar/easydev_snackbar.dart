import 'package:easydev_basics/easydev_basics.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';

const _duration = Duration(milliseconds: 1500);

/// Snackbar for text notifications. [EasyDevSnackBar] can be called using
/// It can have optional action widget such as a button.
/// Snackbar can be called in [EasyDevApp] or in any app,
/// if it have [EasyDevScaffoldMessenger] and [EasyDevScaffold] in the widget tree,
/// by using EasyDevScaffoldMessenger.of(context).showSnackbar() method.
/// Snackbar also can be dismissed, but only in down direction.
///
/// This example shows how to use [EasyDevSnackBar] using [EasyDevScaffoldMessenger].
/// ```dart
/// EasyDevScaffoldMessenger.of(context).showSnackBar(
///  const EasyDevSnackBar(title: 'Snackbar'),
/// );
/// ```
///
/// This sample shows an [EasyDevScaffold] with button, that shows [EasyDevSnackBar] on
/// pressed.
///
/// See code in example/lib/pages/examples/snackbar/snackbar_example.dart
/// See also:
///
///  * [EasyDevScaffoldMessenger], that have methods
///  for calling [EasyDevToast] and [EasyDevSnackBar]
///  * [EasyDevToast], another methods for displaying popup messages.
class EasyDevSnackBar extends StatefulWidget {
  /// Create a snack bar.
  const EasyDevSnackBar({
    super.key,
    required this.title,
    this.subtitle,
    this.action,
    this.titleMaxLines = 2,
    this.height,
    this.margin,
    this.padding,
    this.titleColor,
    this.subtitleColor,
    this.borderRadius,
    this.duration = _duration,
    this.dismissible = true,
    this.animation,
  });

  /// Main text of the snackbar.
  final String? title;

  /// Secondary text of the snackbar.
  final String? subtitle;

  /// Widget to place into snackbar other than text (typically a button)
  /// To dismiss widget after action was pressed you should call
  /// [EasyDevScaffoldMessenger].of(context).hideCurrentSnackBar()
  final Widget? action;

  /// Maximum number of lines in title.
  final int titleMaxLines;

  /// Height of the snackbar.
  final double? height;

  /// Margin of the snackbar.
  final EdgeInsets? margin;

  /// Inner padding of the snackbar.
  final EdgeInsets? padding;

  /// Color of the title text.
  final Color? titleColor;

  /// Color of the subtitle text.
  final Color? subtitleColor;

  /// Border radius of snackbar.
  final BorderRadius? borderRadius;

  /// Time after which snackbar is dismissed.
  final Duration duration;

  /// Whether user can dismiss the snackbar manually.
  final bool dismissible;

  /// Animation of snackbar.
  final Animation<double>? animation;

  /// Creates an animation controller useful for driving a snack bar's entrance and exit animation.
  static AnimationController createAnimationController({
    required TickerProvider vsync,
    Duration? animationDuration,
  }) {
    return AnimationController(
      duration: animationDuration ?? const Duration(milliseconds: 200),
      debugLabel: 'SnackBar',
      vsync: vsync,
    );
  }

  /// Creates a copy of this snack bar but with the animation replaced with the given animation.
  ///
  /// If the original snack bar lacks a key, the newly created snack bar will
  /// use the given fallback key.
  EasyDevSnackBar withAnimation(Animation<double> newAnimation, {Key? fallbackKey}) {
    return EasyDevSnackBar(
      key: key ?? fallbackKey,
      title: title,
      subtitle: subtitle,
      action: action,
      titleMaxLines: titleMaxLines,
      height: height,
      margin: margin,
      padding: padding,
      titleColor: titleColor,
      subtitleColor: subtitleColor,
      borderRadius: borderRadius,
      duration: duration,
      animation: newAnimation,
      dismissible: dismissible,
    );
  }

  @override
  State<EasyDevSnackBar> createState() => _EasyDevSnackBarState();
}

class _EasyDevSnackBarState extends State<EasyDevSnackBar> {
  EdgeInsets _getMargin(EasyDevThemeData theme) {
    return widget.margin ?? theme.snackbarTheme?.margin ?? const EdgeInsets.all(24);
  }

  EdgeInsets _getPadding(EasyDevThemeData theme) {
    return widget.padding ?? theme.snackbarTheme?.padding ?? const EdgeInsets.all(16);
  }

  BorderRadius _getBorderRadius(EasyDevThemeData theme) {
    return widget.borderRadius ??
        theme.snackbarTheme?.borderRadius ??
        const BorderRadius.all(Radius.circular(8));
  }

  Color _getBackgroundColor(EasyDevThemeData theme) {
    if (theme.brightness == Brightness.dark) {
      return theme.colorPalette.greySwatch.disabledColor ?? theme.brightness.surfaceColor;
    }
    return theme.colorPalette.secondarySwatch?[200] ?? theme.brightness.surfaceColor;
  }

  BoxShadow _getShadow(EasyDevThemeData theme) {
    if (theme.brightness == Brightness.light) {
      return BoxShadow(
        color: (theme.colorPalette.secondarySwatch?[900] ?? theme.brightness.onSurfaceColor)
            .withOpacity(0.1),
        blurRadius: 3,
      );
    }
    return BoxShadow(
      color: (theme.colorPalette.secondarySwatch?[300] ?? theme.brightness.onSurfaceColor)
          .withOpacity(0.1),
      blurRadius: 3,
    );
  }

  TextStyle? _getTitleStyle(EasyDevThemeData theme) {
    final titleTextColor = widget.titleColor ?? theme.snackbarTheme?.titleColor;
    TextStyle? titleStyle = theme.typography?.body1Style;
    if (theme.brightness == Brightness.light) {
      titleStyle = titleStyle?.copyWith(
        color: theme.colorPalette.secondarySwatch?[900] ??
            theme.colorPalette.greySwatch.onSurfaceColor,
      );
    }
    if (titleTextColor != null) {
      titleStyle = titleStyle?.copyWith(color: titleTextColor);
    }
    return titleStyle;
  }

  TextStyle? _getSubtitleStyle(EasyDevThemeData theme) {
    final subtitleTextColor = widget.subtitleColor ?? theme.snackbarTheme?.subtitleColor;
    TextStyle? subtitleStyle = theme.typography?.body3Style;
    if (theme.brightness == Brightness.light) {
      subtitleStyle = subtitleStyle?.copyWith(
        color: theme.colorPalette.secondarySwatch?[900] ??
            theme.colorPalette.greySwatch.onSurfaceColor,
      );
    }
    if (subtitleTextColor != null) {
      subtitleStyle = subtitleStyle?.copyWith(color: widget.subtitleColor);
    }

    return subtitleStyle;
  }

  @override
  Widget build(BuildContext context) {
    final theme = EasyDevTheme.of(context);

    final titleText = Text(
      widget.title ?? "",
      style: _getTitleStyle(theme),
      maxLines: widget.titleMaxLines,
      overflow: TextOverflow.ellipsis,
    );

    final subtitleText = widget.subtitle == null
        ? null
        : Text(
            widget.subtitle ?? "",
            style: _getSubtitleStyle(theme),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );

    final child = Container(
      margin: _getMargin(theme),
      padding: _getPadding(theme),
      decoration: BoxDecoration(
        color: _getBackgroundColor(theme),
        borderRadius: _getBorderRadius(theme),
        boxShadow: [_getShadow(theme)],
      ),
      height: widget.height,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                titleText,
                if (subtitleText != null) ...[
                  const SizedBox(height: 8),
                  subtitleText,
                ],
              ],
            ),
          ),
          if (widget.action != null) ...[
            const SizedBox(width: 20),
            widget.action!,
          ]
        ],
      ),
    );

    if (widget.animation != null) {
      final CurvedAnimation heightAnimation =
          CurvedAnimation(parent: widget.animation!, curve: Curves.fastOutSlowIn);

      return Dismissible(
        key: Key('snackBar-dismissible${widget.key}'),
        onDismissed: (_) {
          EasyDevScaffoldMessenger.of(context).removeCurrentSnackBar(
            reason: CloseReason.dismiss,
          );
        },
        direction: widget.dismissible ? DismissDirection.down : DismissDirection.none,
        child: AnimatedBuilder(
          animation: heightAnimation,
          builder: (context, child) {
            return Opacity(
              opacity: heightAnimation.value < 0.4 ? 0.4 : heightAnimation.value,
              child: Align(
                alignment: Alignment.topCenter,
                heightFactor: heightAnimation.value,
                child: child,
              ),
            );
          },
          child: child,
        ),
      );
    }
    return child;
  }
}
