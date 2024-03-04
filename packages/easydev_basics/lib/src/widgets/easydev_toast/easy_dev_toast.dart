import 'package:community_material_icon/community_material_icon.dart';
import 'package:easydev_basics/easydev_basics.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';

enum ToastState { success, info, warning, error }

const _duration = Duration(milliseconds: 1500);

/// [EasyDevToast] is popup Android style message that shows user some information for certain
/// time period.
/// Toast can be called in [EasyDevApp] or in any app,
/// if it have [EasyDevScaffoldMessenger] and [EasyDevScaffold] in the widget tree,
/// by using EasyDevScaffoldMessenger.of(context).showToast() method.
///
/// This example shows how to use [EasyDevToast] using [EasyDevScaffoldMessenger].
/// ```dart
/// EasyDevScaffoldMessenger.of(context).showToast(
///   const EasyDevToast(title: 'This is toast'),
/// );
/// ```
///
/// Toast requires [title] which contains message. [EasyDevToast.state] provides
/// build in boilerplates for toast designs for showing in different cases: info toast, warning
/// toast and error toast. Their only difference is toast color and toast leading icon.
/// Custom leading icon can be provided with [leadingIcon] property, or any icons can be
/// removed is by passing [removeIcon] property.
/// [EasyDevToast] can have custom content by passing any widget to [content] property.
///
/// This sample shows an Scaffold with 4 different buttons, that calls [EasyDevToast] on
/// being pressed with different [ToastState].
///
/// See code in example/lib/pages/examples/toast/toast_example.dart
class EasyDevToast extends StatefulWidget {
  const EasyDevToast({
    super.key,
    required this.title,
    this.state = ToastState.info,
    this.leadingIcon,
    this.iconColor,
    this.subtitle,
    this.padding,
    this.margin,
    this.addCloseButton,
    this.iconSpacing,
    this.height,
    this.width,
    this.titleStyle,
    this.subtitleStyle,
    this.toastColor,
    this.content,
    this.onClose,
    this.duration = _duration,
    this.animation,
    this.removeIcon = false,
  });

  /// Main text of toast
  final String title;

  /// State of toast - only difference in toasts with different states is toast [toastColor]
  /// and [leadingIcon]
  final ToastState state;

  /// Padding of toast
  final EdgeInsets? padding;

  /// Margin of toast
  final EdgeInsets? margin;

  /// Leading icon of toast
  final IconData? leadingIcon;

  /// [Color] of [leadingIcon] and [closeButton]
  final Color? iconColor;

  /// [Text] under title
  final String? subtitle;

  /// Initially true, adds  button that closes toast.
  final bool? addCloseButton;

  /// Spacing between icons and text initially is equal to 10
  final double? iconSpacing;

  /// [Widget] that if provided replaces toast content
  final Widget? content;

  /// Height of toast
  final double? height;

  /// Width of toast
  final double? width;

  /// [TextStyle] of toast
  final TextStyle? titleStyle;

  /// [TextStyle] of [subtitle] under toast
  final TextStyle? subtitleStyle;

  /// [Color] of toast.
  final Color? toastColor;

  /// [VoidCallback] is called when button with close icon is pressed. When not null pops current route.
  final VoidCallback? onClose;

  /// [Duration] of toast.
  final Duration duration;

  /// Animation of toast. Usually it is passed by [ScaffoldMessenger.showToast] method.
  final Animation<double>? animation;

  /// Removes leading icon from toast.
  final bool removeIcon;

  /// Creates an animation controller useful for driving a toast entrance and exit animation.
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

  /// Creates a copy of this toast but with the animation replaced with the given animation.
  ///
  /// If the original toast lacks a key, the newly created toast will
  /// use the given fallback key.
  EasyDevToast withAnimation(Animation<double> newAnimation, {Key? fallbackKey}) {
    return EasyDevToast(
      key: key ?? fallbackKey,
      title: title,
      state: state,
      leadingIcon: leadingIcon,
      iconColor: iconColor,
      subtitle: subtitle,
      padding: padding,
      margin: margin,
      addCloseButton: addCloseButton,
      iconSpacing: iconSpacing,
      height: height,
      width: width,
      titleStyle: titleStyle,
      subtitleStyle: subtitleStyle,
      toastColor: toastColor,
      content: content,
      onClose: onClose,
      duration: duration,
      animation: newAnimation,
    );
  }

  @override
  State<EasyDevToast> createState() => _EasyDevToastState();
}

class _EasyDevToastState extends State<EasyDevToast> {
  Color? _getToastColor(EasyDevThemeData theme) {
    if (widget.toastColor != null) {
      return widget.toastColor!;
    }

    final light = theme.brightness == Brightness.light;

    Color? color;

    switch (widget.state) {
      case ToastState.success:
        color = (light
            ? theme.colorPalette.successSwatch
            : theme.colorPalette.successSwatch?[400] ?? theme.colorPalette.successSwatch);
        break;
      case ToastState.info:
        color = theme.colorPalette.secondarySwatch?[200] ?? theme.colorPalette.secondarySwatch;
        break;
      case ToastState.warning:
        color = theme.colorPalette.warningSwatch;
        break;
      case ToastState.error:
        color = theme.colorPalette.errorSwatch?[400] ?? theme.colorPalette.errorSwatch;
        break;
    }
    return color ?? theme.colorPalette.primarySwatch;
  }

  IconData _getIconData() {
    if (widget.leadingIcon != null) {
      return widget.leadingIcon!;
    }

    switch (widget.state) {
      case ToastState.success:
        return CommunityMaterialIcons.check_circle_outline;
      case ToastState.info:
        return CommunityMaterialIcons.alert_circle_outline;
      case ToastState.warning:
        return CommunityMaterialIcons.alert_circle_outline;
      case ToastState.error:
        return CommunityMaterialIcons.close_circle_outline;
    }
  }

  EdgeInsets _getPadding(EasyDevThemeData theme) {
    if (widget.padding != null) {
      return widget.padding!;
    }
    if (widget.subtitle != null) {
      return theme.toastTheme?.multilineToastPadding ??
          const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 16,
          );
    }
    return theme.toastTheme?.padding ??
        const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        );
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.easyDevTheme;

    final textColor = widget.titleStyle?.color ??
        theme.colorPalette.greySwatch.onPrimary ??
        theme.colorPalette.greySwatch.onSurfaceColor;

    final child = Container(
      padding: _getPadding(theme),
      margin: widget.margin ??
          theme.toastTheme?.margin ??
          const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 20,
          ),
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        color: _getToastColor(theme),
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: widget.content ??
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (!widget.removeIcon) ...[
                    Icon(
                      _getIconData(),
                      color: widget.iconColor ?? textColor,
                      size: 32,
                    ),
                    SizedBox(
                      width: widget.iconSpacing ?? theme.toastTheme?.iconSpacing ?? 10,
                    ),
                  ],
                  Expanded(
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            widget.title,
                            style: widget.titleStyle ??
                                theme.toastTheme?.titleStyle ??
                                theme.typography?.subheading1Style?.copyWith(
                                  color: textColor,
                                  fontSize: 16,
                                ) ??
                                TextStyle(
                                  fontSize: 16,
                                  color: textColor,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: widget.iconSpacing ?? theme.toastTheme?.iconSpacing ?? 10,
                  ),
                  if (widget.addCloseButton ?? theme.toastTheme?.closeButton ?? true)
                    GestureDetector(
                      onTap: () {
                        if (widget.onClose != null) {
                          widget.onClose!();
                        }
                        EasyDevScaffoldMessenger.of(context)
                            .hideCurrentToast(reason: CloseReason.action);
                      },
                      child: Icon(
                        CommunityMaterialIcons.close,
                        color: widget.iconColor ?? textColor,
                        size: 32,
                      ),
                    )
                ],
              ),
              if (widget.subtitle != null)
                Row(
                  children: [
                    SizedBox(
                      width: 32 + (widget.iconSpacing ?? 10),
                    ),
                    Flexible(
                      child: Text(
                        widget.subtitle!,
                        style: widget.subtitleStyle ??
                            theme.toastTheme?.subtitleStyle ??
                            theme.typography?.body2Style?.copyWith(
                              color: textColor,
                              fontWeight: FontWeight.w200,
                            ) ??
                            TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w200,
                              color: textColor,
                            ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
    );

    if (widget.animation != null) {
      final CurvedAnimation fadeAnimation = CurvedAnimation(
        parent: widget.animation!,
        curve: const Interval(0.0, 1.0),
      );

      return Dismissible(
        key: Key('toast-dismissible${widget.key}'),
        onDismissed: (_) {
          EasyDevScaffoldMessenger.of(context).removeCurrentToast(reason: CloseReason.dismiss);
        },
        child: AnimatedBuilder(
          animation: fadeAnimation,
          builder: (context, child) {
            return Opacity(
              opacity: fadeAnimation.value,
              child: child,
            );
          },
          child: child,
        ),
      );
    }
    return child;
  }
}
