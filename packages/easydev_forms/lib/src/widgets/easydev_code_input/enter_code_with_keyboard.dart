import 'package:community_material_icon/community_material_icon.dart';
import 'package:easydev_base_ui/easydev_base_ui.dart';
import 'package:easydev_forms/src/widgets/easydev_code_input/caret_widget.dart';
import 'package:easydev_forms/src/widgets/easydev_code_input/code_widget.dart';
import 'package:easydev_forms/src/widgets/easydev_code_input/enter_code_state.dart';
import 'package:easydev_forms/src/widgets/easydev_code_input/enter_code_field.dart';
import 'package:easydev_forms/src/widgets/easydev_code_input/resend_code_timer.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

const _animationDuration = Duration(milliseconds: 175);

/// [EnterCodeWithKeyboard] is similar widget to [EnterCodeField], but with key difference.
/// It contains inside [EasyDevTextFormField] that on tap on widget receive a focus and calls
/// native keyboard. Also having relating to relying on user input to provide code.
/// [numbersOnly] adds [FilteringTextInputFormatter] that ensures only numeric can be entered
/// and changed keyboard type to [TextInputType.number]. Also [formatters] and [textInputType]
/// can be specified. For manipulating focus [focusNode] can be provided,
/// for example receiving focus on widget appear
///
/// [state] can be provided to disable code entering
/// widget and show loading, success or failure indicator.If [needTimer] is true
/// and [state] is [EnterCodeState.enabled] timer will be shown. It have allows user to
/// have "resend code" button that will be active after [timerSeconds] will be passed.
/// Action on "resend code" button can be specified it [onTimerButtonPressed].
/// [EnterCodeWithKeyboard] can also can be provided with [action] that placed instead of timer.
///
/// Example of using [EnterCodeField].
/// ```dart
/// EnterCodeWithKeyboard(
///   value: "0000",
///   state: codeState,
///   valueChanged: () {
///    ...
///   }
/// ),
/// ```
///
///
/// This sample shows app with [EnterCodeWithKeyboard], uses keyboard for entering value.
///
/// See code in example/lib/pages/examples/code_input_example.dart
///
/// See also:
///
///  * [EnterCodeField], enter code widget, that displays code and have multiple states.
class EnterCodeWithKeyboard extends StatefulWidget {
  const EnterCodeWithKeyboard({
    super.key,
    required this.value,
    required this.valueChanged,
    this.state = EnterCodeState.enabled,
    this.codeLength = 4,
    this.inputSize = 32,
    this.spacing = 8,
    this.verticalSpacing = 24,
    this.padding = const EdgeInsets.all(16),
    this.borderRadius = const BorderRadius.all(Radius.circular(4)),
    this.needTimer = true,
    this.numbersOnly = true,
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
    this.formatters,
    this.textInputType,
    this.focusNode,
    this.caretSize,
    this.caretColor,
  });

  /// Value of widget, does not show symbols with index more that [codeLength].
  final String value;

  /// Callback for value changing.
  final ValueChanged<String> valueChanged;

  /// {@macro easydev_forms.widgets.easydev_code_input.enter_code_state}
  /// [EnterCodeState] enum provides ability to change [EnterCodeField] to different states
  /// with customization of them.
  /// [EnterCodeState.enabled] allows entering code.
  /// [EnterCodeState.loading] shows loading indicator and [loadingHint]
  /// [EnterCodeState.success] shows success icon and [successHint]
  /// [EnterCodeState.failure] shows failure icon and [errorHint]
  final EnterCodeState state;

  /// When true, provides [TextInputFormatter] that allows only entering numbers.
  final bool numbersOnly;

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

  /// When provided this formatters are used instead of this widget formatters.
  /// Initially there is only one formatter [LengthLimitingTextInputFormatter] what length are
  /// equal [codeLength]. When [numbersOnly] is true additional [FilteringTextInputFormatter]
  /// provided what only allows numbers.
  final List<TextInputFormatter>? formatters;

  /// When provided this [TextInputType] is used. When not provided and [numbersOnly]
  /// widget [TextInputType] is [TextInputType.number]. When ![numbersOnly] [TextInputType]
  /// is [TextInputType.text]
  final TextInputType? textInputType;

  /// [FocusNode] that controls focus of software [EasyDevTextField]
  final FocusNode? focusNode;

  /// [Color] of caret on current code symbol.
  final Color? caretColor;

  /// Height of caret in current symbol.
  final double? caretSize;

  @override
  State<EnterCodeWithKeyboard> createState() => _EnterCodeWithKeyboardState();
}

class _EnterCodeWithKeyboardState extends State<EnterCodeWithKeyboard> {
  late LengthLimitingTextInputFormatter lengthInputFormatter;
  late FilteringTextInputFormatter filteringTextInputFormatter;
  late FocusNode _focusNode;

  @override
  void initState() {
    _focusNode = widget.focusNode ?? FocusNode()
      ..removeListener(_handleFocusChange)
      ..addListener(_handleFocusChange);
    lengthInputFormatter = LengthLimitingTextInputFormatter(widget.codeLength);
    filteringTextInputFormatter = FilteringTextInputFormatter.allow(RegExp(r'[0-9]'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.easyDevTheme;

    return Padding(
      padding: widget.padding,
      child: Column(
        children: [
          if (widget.state == EnterCodeState.enabled)
            Text(
              widget.title ?? '',
              style: widget.titleStyle ??
                  theme.typography?.body2Style?.copyWith(
                    color: theme.colorPalette.greySwatch.onSurfaceColor,
                  ),
            ),
          AnimatedContainer(
            height: widget.state == EnterCodeState.enabled ? widget.verticalSpacing : 0,
            duration: _animationDuration,
          ),
          if (widget.state == EnterCodeState.enabled)
            Stack(
              children: [
                CodeWidget(
                  value: widget.value,
                  codeLength: widget.codeLength,
                  inputSize: widget.inputSize,
                  spacing: widget.spacing,
                  borderRadius: widget.borderRadius,
                  codeStyle: widget.codeStyle,
                  emptyColor: widget.emptyColor,
                  backgroundColor: _getBackgroundColor(theme),
                  borderColor: widget.borderColor,
                ),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: (widget.spacing * (widget.codeLength - 2)) +
                        (widget.inputSize * widget.codeLength),
                    height: MediaQuery.of(context).textScaler.scale(widget.inputSize),
                    child: EasyDevTextField(
                      valueChanged: widget.valueChanged,
                      inputFormatters: widget.formatters ??
                          [
                            lengthInputFormatter,
                            if (widget.numbersOnly) filteringTextInputFormatter,
                          ],
                      focusNode: _focusNode,
                      textInputType: widget.textInputType ??
                          (widget.numbersOnly ? TextInputType.number : TextInputType.text),
                      showCursor: false,
                      decoration: EasyDevInputDecoration(
                        textStyle: const TextStyle(
                          fontSize: 0,
                          color: Color(0x00000000),
                        ),
                        height: widget.inputSize - 24,
                        inputPadding: EdgeInsets.zero,
                        margin: EdgeInsets.zero,
                        inputStyle: InputStyle.borderless,
                        backgroundCursorColor: const Color(0x00000000),
                      ),
                    ),
                  ),
                ),
                CaretWidget(
                  caretSize: widget.caretSize,
                  currentSymbol: widget.value.length,
                  length: widget.codeLength,
                  caretColor: widget.caretColor ??
                      ((theme.brightness == Brightness.light)
                          ? (theme.colorPalette.secondarySwatch ?? theme.colorPalette.primarySwatch)
                          : (theme.colorPalette.primarySwatch)),
                  size: widget.inputSize,
                  backgroundColor: widget.emptyColor,
                  focused: _focusNode.hasFocus,
                ),
              ],
            ),
          if (widget.state == EnterCodeState.loading)
            widget.loadingWidget ?? const EasyDevLoadingIndicator(),
          if (widget.state == EnterCodeState.failure)
            widget.errorWidget ??
                Icon(
                  CommunityMaterialIcons.alert_circle_outline,
                  color: theme.colorPalette.errorSwatch,
                ),
          if (widget.state == EnterCodeState.success)
            widget.successWidget ??
                Icon(
                  CommunityMaterialIcons.check_circle_outline,
                  color: theme.colorPalette.successSwatch,
                ),
          AnimatedContainer(
            height: widget.state == EnterCodeState.enabled ? widget.verticalSpacing : 8,
            duration: _animationDuration,
          ),
          if (widget.state == EnterCodeState.enabled && widget.needTimer)
            widget.action ??
                ResendCodeTimer(
                  onSendPressed: widget.onTimerButtonPressed ?? () {},
                  text: widget.timerText ?? 'Can be requested in',
                  buttonText: widget.timerButtonText ?? 'Resend code',
                  seconds: widget.timerSeconds ?? 30,
                ),
          if (widget.state == EnterCodeState.enabled && !widget.needTimer)
            widget.action ?? const SizedBox(),
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
    if (widget.state == EnterCodeState.loading) {
      return widget.loadingHint ?? 'Loading...';
    }
    if (widget.state == EnterCodeState.failure) {
      return widget.errorHint ?? 'Something went wrong';
    }
    if (widget.state == EnterCodeState.success) {
      return widget.successHint ?? 'Success!';
    }
    return null;
  }

  TextStyle? _getHintTextStyle(EasyDevThemeData theme) {
    TextStyle? textStyle;
    if (widget.state == EnterCodeState.loading) {
      textStyle = widget.loadingTextStyle;
    }
    if (widget.state == EnterCodeState.failure) {
      textStyle = widget.errorTextStyle;
    }
    if (widget.state == EnterCodeState.success) {
      textStyle = widget.successTextStyle;
    }
    if (theme.brightness == Brightness.light) {
      if (widget.state != EnterCodeState.enabled) {
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
    if (widget.state != EnterCodeState.enabled) {
      return textStyle ??
          theme.typography?.subheading2Style?.copyWith(
            color: theme.colorPalette.greySwatch.onSurfaceColor,
          );
    }
    return textStyle ??
        theme.typography?.body2Style?.copyWith(
          color: theme.colorPalette.greySwatch.onSurfaceColor,
        );
  }

  Color? _getBackgroundColor(EasyDevThemeData theme) {
    return widget.backgroundColor ??
        (theme.brightness == Brightness.light
            ? (theme.colorPalette.greySwatch.tappedSurfaceColor ??
                theme.colorPalette.greySwatch.greyColor)
            : theme.colorPalette.greySwatch.disabledColor);
  }

  void _handleFocusChange() {
    setState(() {});
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    super.dispose();
  }
}
