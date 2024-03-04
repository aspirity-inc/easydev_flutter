import 'package:community_material_icon/community_material_icon.dart';
import 'package:easydev_base_ui/easydev_base_ui.dart';
import 'package:easydev_forms/easydev_forms.dart';
import 'resend_code_timer.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';

const _animationDuration = Duration(milliseconds: 175);

/// [EnterCodeField] provides a way to creating code field, that will use external way of
/// receiving value, like on screen keyboard. [state] can be provided to disable code entering
/// widget and show loading, success or failure indicator.If [needTimer] is true
/// and [state] is [EnterCodeState.enabled] timer will be shown. It have allows user to
/// have "resend code" button that will be active after [timerSeconds] will be passed.
/// Action on "resend code" button can be specified it [onTimerButtonPressed]. [EnterCodeField]
/// can also can be provided with [action] that placed instead of timer.
///
/// Example of using [EnterCodeField].
/// ```dart
/// EnterCodeField(
///   value: "0000",
/// ),
/// ```
///
/// Example of [EnterCodeField] with loading state.
/// ```dart
/// EnterCodeField(
///   value: "0000",
///   state: EnterCodeState.loading,
/// ),
/// ```
///
///
///
/// This sample shows app with [EnterCodeField] with entered value.
///
/// See code in example/lib/pages/examples/code_input_example1.dart
///
/// See also:
///
///  * [EnterCodeWithKeyboard], enter code widget, for entering entering code using text field.
class EnterCodeField extends StatelessWidget {
  const EnterCodeField({
    super.key,
    required this.value,
    this.state = EnterCodeState.enabled,
    this.codeLength = 4,
    this.inputSize = 32,
    this.spacing = 8,
    this.verticalSpacing = 24,
    this.padding = const EdgeInsets.all(16),
    this.borderRadius = const BorderRadius.all(Radius.circular(4)),
    this.needTimer = true,
    this.codeStyle,
    this.title,
    this.titleStyle,
    this.action,
    this.emptyColor,
    this.backgroundColor,
    this.borderColor,
    this.successWidget,
    this.successHint,
    this.successTextStyle,
    this.errorWidget,
    this.errorHint,
    this.errorTextStyle,
    this.loadingWidget,
    this.loadingHint,
    this.loadingTextStyle,
    this.onTimerButtonPressed,
    this.timerText,
    this.timerButtonText,
    this.timerSeconds,
  });

  /// Value of widget, does not show symbols with index more that [codeLength]
  final String value;

  /// {@macro easydev_forms.widgets.easydev_code_input.enter_code_state}
  /// [EnterCodeState] enum provides ability to change [EnterCodeField] to different states
  /// with customization of them.
  /// [EnterCodeState.enabled] allows entering code.
  /// [EnterCodeState.loading] shows loading indicator and [loadingHint]
  /// [EnterCodeState.success] shows success icon and [successHint]
  /// [EnterCodeState.failure] shows failure icon and [errorHint]
  final EnterCodeState state;

  /// Length of code widget. Initially 4.
  final int codeLength;

  /// Spacing between symbols. Initially 8.
  final double spacing;

  /// Spacing between [CodeWidget] and other widget.
  final double verticalSpacing;

  /// Size of symbol widget. Multiplied by text scale factor. Initially 32.
  final double inputSize;

  /// Border radius of [CodeSymbolWidget]. Initially - 4.
  final BorderRadius borderRadius;

  /// Need to show timer below [CodeWidget]. Initially true.
  final bool needTimer;

  /// Style of symbols in [CodeWidget]
  final TextStyle? codeStyle;

  /// Text above [CodeWidget].
  final String? title;

  /// [TextStyle] of [title]
  final TextStyle? titleStyle;

  /// Widget that shows below [CodeWidget]. When provided [ResendCodeTimer] does not shown.
  final Widget? action;

  /// Color of border without value for [CodeSymbolWidget]
  final Color? emptyColor;

  /// Color of background of [CodeSymbolWidget].
  final Color? backgroundColor;

  /// Color of border with value for [CodeSymbolWidget].
  final Color? borderColor;

  /// Padding of a widget. Initially is [EdgeInsets.all(16)]
  final EdgeInsets padding;

  /// Widget what shows instead of success icon, when provided.
  final Widget? successWidget;

  /// Text of hint of [EnterCodeState.success]
  final String? successHint;

  /// [TextStyle] of hint of [EnterCodeState.success]
  final TextStyle? successTextStyle;

  /// Widget what shows instead of failure icon, when provided.
  final Widget? errorWidget;

  /// Text of hint of [EnterCodeState.failure]
  final String? errorHint;

  /// [TextStyle] of hint of [EnterCodeState.failure]
  final TextStyle? errorTextStyle;

  /// Widget what shows instead of loading indicator, when provided.
  final Widget? loadingWidget;

  /// Text of hint of [EnterCodeState.loading]
  final String? loadingHint;

  /// [TextStyle] of hint of [EnterCodeState.loading]
  final TextStyle? loadingTextStyle;

  /// Provides callback for [ResendCodeTimer] when pressed on button.
  final VoidCallback? onTimerButtonPressed;

  /// Text for timer in [ResendCodeTimer] widget.
  final String? timerText;

  /// Button text, what shows when timer is passed.
  final String? timerButtonText;

  /// If [needTimer] is provided timer will display countdown for certain amount of seconds,
  /// defaults to 30. Then button with [timerButtonText] will be shown, and another action
  /// can be called with [onTimerButtonPressed].
  final int? timerSeconds;

  Color? _getBackgroundColor(EasyDevThemeData theme) {
    return backgroundColor ??
        (theme.brightness == Brightness.light
            ? (theme.colorPalette.greySwatch.tappedSurfaceColor ??
                theme.colorPalette.greySwatch.greyColor)
            : theme.colorPalette.greySwatch.disabledColor);
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.easyDevTheme;
    return Padding(
      padding: padding,
      child: Column(
        children: [
          if (state == EnterCodeState.enabled)
            Text(
              title ?? '',
              style: titleStyle ??
                  theme.typography?.body2Style?.copyWith(
                    color: theme.colorPalette.greySwatch.onSurfaceColor,
                  ),
            ),
          AnimatedContainer(
            height: state == EnterCodeState.enabled ? verticalSpacing : 0,
            duration: _animationDuration,
          ),
          if (state == EnterCodeState.enabled)
            CodeWidget(
              value: value,
              codeLength: codeLength,
              inputSize: inputSize,
              spacing: spacing,
              borderRadius: borderRadius,
              codeStyle: codeStyle,
              emptyColor: emptyColor,
              backgroundColor: _getBackgroundColor(theme),
              borderColor: borderColor,
            ),
          if (state == EnterCodeState.loading) loadingWidget ?? const EasyDevLoadingIndicator(),
          if (state == EnterCodeState.failure)
            errorWidget ??
                Icon(
                  CommunityMaterialIcons.alert_circle_outline,
                  color: theme.colorPalette.errorSwatch,
                ),
          if (state == EnterCodeState.success)
            successWidget ??
                Icon(
                  CommunityMaterialIcons.check_circle_outline,
                  color: theme.colorPalette.successSwatch,
                ),
          AnimatedContainer(
            height: state == EnterCodeState.enabled ? verticalSpacing : 8,
            duration: _animationDuration,
          ),
          if (state == EnterCodeState.enabled && needTimer)
            action ??
                ResendCodeTimer(
                  onSendPressed: onTimerButtonPressed ?? () {},
                  text: timerText ?? 'Can be requested in',
                  buttonText: timerButtonText ?? 'Resend again',
                  seconds: timerSeconds ?? 30,
                ),
          if (state == EnterCodeState.enabled && !needTimer) action ?? const SizedBox(),
          if (_getHintText() != null)
            AnimatedDefaultTextStyle(
              duration: _animationDuration,
              style: _getHintTextStyle(theme) ?? const TextStyle(),
              child: Text(_getHintText()!),
            ),
        ],
      ),
    );
  }

  String? _getHintText() {
    if (state == EnterCodeState.loading) {
      return loadingHint ?? 'Loading...';
    }
    if (state == EnterCodeState.failure) {
      return errorHint ?? 'Something went wrong';
    }
    if (state == EnterCodeState.success) {
      return successHint ?? 'Success!';
    }
    return null;
  }

  TextStyle? _getHintTextStyle(EasyDevThemeData theme) {
    TextStyle? textStyle;
    if (state == EnterCodeState.loading) {
      textStyle = loadingTextStyle;
    }
    if (state == EnterCodeState.failure) {
      textStyle = errorTextStyle;
    }
    if (state == EnterCodeState.success) {
      textStyle = successTextStyle;
    }
    if (theme.brightness == Brightness.light) {
      if (state != EnterCodeState.enabled) {
        return textStyle ??
            theme.typography?.subheading2Style?.copyWith(
              color: theme.colorPalette.greySwatch.onSurfaceColor,
            );
      }
      return textStyle ??
          theme.typography?.subheading2Style?.copyWith(
            color: theme.colorPalette.greySwatch.unselectedColor ??
                theme.colorPalette.greySwatch.greyColor,
          );
    }
    return textStyle ??
        theme.typography?.subheading2Style?.copyWith(
          color: theme.colorPalette.greySwatch.onSurfaceColor,
        );
  }
}
