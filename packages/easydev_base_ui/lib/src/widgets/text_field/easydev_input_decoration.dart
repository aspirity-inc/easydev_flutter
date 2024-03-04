import 'package:easydev_base_ui/easydev_base_ui.dart';
import 'package:flutter/widgets.dart';

class EasyDevInputDecoration {
  /// [BorderRadius] of text input.
  final BorderRadius? borderRadius;

  /// Width of border.
  final double? borderWidth;

  /// [Color] of [InputState.enabled] unselected text field,
  /// shown when [FocusNode.hasFocus] equals false.
  final Color? unfocusedColor;

  /// [Color] of [InputState.enabled] selected text field,
  /// shown when [FocusNode.hasFocus] equals true.
  final Color? focusedColor;

  /// [Color] of [InputState.filled] text field.
  final Color? filledColor;

  /// [Color] of [InputState.error] text field.
  final Color? errorColor;

  /// [Color] of [InputState.loading] text field.
  final Color? loadingColor;

  /// [Color] of [InputState.success] text field.
  final Color? successColor;

  /// [Color] of [InputState.disabled] text field.
  final Color? disabledColor;

  /// [Color] of text field background,
  /// initially it is transparent - Color(0x00000000)
  final Color? backgroundColor;

  /// [TextStyle] of input text, prefix text and suffix text.
  final TextStyle? textStyle;

  /// [TextStyle] of input text, prefix text and suffix text.
  final TextStyle? labelStyle;

  /// [TextStyle] of linkWidget if it is Text.
  final TextStyle? linkWidgetStyle;

  /// [TextStyle] of floating label, floating label is shown
  /// when text field is focused or have some inputed text in it.
  final TextStyle? floatingLabelStyle;

  /// [TextStyle] of helper text, error and input length text fields.
  final TextStyle? helperStyle;

  /// [TextStyle] of hint.
  final TextStyle? hintStyle;

  /// If provided [staticBorderColor] border of text input is always have this
  /// color.
  final Color? staticBorderColor;

  /// [Color] that overrides leading and trailing icons color.
  final Color? iconColor;

  /// [letterCountErrorColor] is color of text count, when it's length
  /// exceeds [EasyDevTextField.maxLength].
  /// To enable counter you need set [EasyDevTextField.showTextLength] to true
  /// and provide [EasyDevTextField.maxLength].
  final Color? letterCountErrorColor;

  /// [Color] of cursor in textField.
  final Color? cursorColor;

  /// The color to use when painting the background cursor aligned with the text
  /// while rendering the floating cursor.
  final Color? backgroundCursorColor;

  /// Height of a cursor.
  final double? cursorHeight;

  /// Width of a cursor.
  final double? cursorWidth;

  /// Height of text field, initially 56.
  final double? height;

  /// Min width of text field. Constrains min width of text field.
  final double? minWidth;

  /// Padding inside text field.
  final EdgeInsets? inputPadding;

  /// Margin outside of text field.
  final EdgeInsets? margin;

  /// [InputStyle] provides different border types to [EasyDevTextField].
  /// [InputStyle.outlined] provides [EasyDevTextField] with outlined border.
  /// [InputStyle.underline] provides [EasyDevTextField] with underlined border.
  /// [InputStyle.borderless] provides [EasyDevTextField] without border.
  final InputStyle inputStyle;

  /// Defines hint should stay even if you started typing,
  /// helpful usecase for [alwaysShowHint] is using it in masked inputs
  /// like phone numbers, card numbers and so on.
  final bool alwaysShowHint;

  const EasyDevInputDecoration({
    this.unfocusedColor,
    this.focusedColor,
    this.filledColor,
    this.errorColor,
    this.loadingColor,
    this.successColor,
    this.disabledColor,
    this.backgroundColor,
    this.textStyle,
    this.labelStyle,
    this.floatingLabelStyle,
    this.helperStyle,
    this.hintStyle,
    this.linkWidgetStyle,
    this.staticBorderColor,
    this.iconColor,
    this.letterCountErrorColor,
    this.cursorColor,
    this.backgroundCursorColor,
    this.cursorHeight,
    this.cursorWidth,
    this.height,
    this.minWidth,
    this.inputPadding,
    this.margin,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.borderWidth = 1,
    this.inputStyle = InputStyle.outlined,
    this.alwaysShowHint = false,
  });

  EasyDevInputDecoration copyWith({
    Color? unfocusedColor,
    Color? focusedColor,
    Color? filledColor,
    Color? errorColor,
    Color? loadingColor,
    Color? successColor,
    Color? disabledColor,
    Color? backgroundColor,
    TextStyle? textStyle,
    TextStyle? labelStyle,
    TextStyle? floatingLabelStyle,
    TextStyle? helperStyle,
    TextStyle? hintStyle,
    TextStyle? linkWidgetStyle,
    Color? staticBorderColor,
    Color? iconColor,
    Color? letterCountErrorColor,
    Color? cursorColor,
    Color? backgroundCursorColor,
    double? cursorHeight,
    double? cursorWidth,
    double? height,
    double? minWidth,
    EdgeInsets? inputPadding,
    EdgeInsets? margin,
    BorderRadius? borderRadius,
    double? borderWidth,
    InputStyle? inputStyle,
    bool? alwaysShowHint,
  }) =>
      EasyDevInputDecoration(
        unfocusedColor: unfocusedColor ?? this.unfocusedColor,
        focusedColor: focusedColor ?? this.focusedColor,
        filledColor: filledColor ?? this.filledColor,
        errorColor: errorColor ?? this.errorColor,
        loadingColor: loadingColor ?? this.loadingColor,
        successColor: successColor ?? this.successColor,
        disabledColor: disabledColor ?? this.disabledColor,
        backgroundColor: backgroundColor ?? this.backgroundColor,
        textStyle: textStyle ?? this.textStyle,
        labelStyle: labelStyle ?? this.labelStyle,
        floatingLabelStyle: floatingLabelStyle ?? this.floatingLabelStyle,
        helperStyle: helperStyle ?? this.helperStyle,
        hintStyle: hintStyle ?? this.hintStyle,
        linkWidgetStyle: linkWidgetStyle ?? this.linkWidgetStyle,
        staticBorderColor: staticBorderColor ?? this.staticBorderColor,
        iconColor: iconColor ?? this.iconColor,
        letterCountErrorColor: letterCountErrorColor ?? this.letterCountErrorColor,
        cursorColor: cursorColor ?? this.cursorColor,
        backgroundCursorColor: backgroundCursorColor ?? this.backgroundCursorColor,
        cursorHeight: cursorHeight ?? this.cursorHeight,
        cursorWidth: cursorWidth ?? this.cursorWidth,
        height: height ?? this.height,
        minWidth: minWidth ?? this.minWidth,
        inputPadding: inputPadding ?? this.inputPadding,
        margin: margin ?? this.margin,
        borderRadius: borderRadius ?? this.borderRadius,
        borderWidth: borderWidth ?? this.borderWidth,
        inputStyle: inputStyle ?? this.inputStyle,
        alwaysShowHint: alwaysShowHint ?? this.alwaysShowHint,
      );
}
