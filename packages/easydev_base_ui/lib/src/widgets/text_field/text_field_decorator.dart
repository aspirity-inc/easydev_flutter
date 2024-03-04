import 'package:easydev_base_ui/src/icons/easy_dev_icons.dart';
import 'package:easydev_base_ui/src/widgets/icon_button/easydev_icon_button.dart';
import 'package:easydev_base_ui/src/widgets/text_field/enums/input_state.dart';
import 'package:easydev_base_ui/src/widgets/text_field/enums/input_style.dart';
import 'package:easydev_base_ui/src/widgets/text_field/easydev_input_decoration.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';

const _animationDuration = Duration(milliseconds: 175);

/// Internal widget for decorating text field.
/// Do not use outside of package.
class TextFieldDecorator extends StatefulWidget {
  const TextFieldDecorator({
    super.key,
    required this.decoration,
    required this.inputState,
    required this.child,
    required this.showTextLength,
    required this.leadingIcon,
    required this.trailingIcon,
    required this.prefixText,
    required this.suffixText,
    required this.linkWidget,
    required this.label,
    required this.helperText,
    required this.helperTrailingIcon,
    required this.hint,
    required this.error,
    required this.successText,
    required this.loadingText,
    required this.textDirection,
    required this.hasFocus,
    required this.maxLength,
    required this.text,
    required this.inputStyle,
    required this.minLines,
    required this.maxLines,
    required this.alignment,
    required this.expandsWithNewLines,
  });

  /// Provides decoration for text input.
  final EasyDevInputDecoration decoration;

  /// Align of text input.
  final AlignmentDirectional alignment;

  /// {@macro easydev_base_ui.widgets.text_field.enums.input_state}
  final InputState inputState;

  /// Child widget of this decorator.
  final Widget child;

  /// [leadingIcon] is positioned inside of text field, before text input and
  /// provides ability to add icon button.
  final EasyDevIconButton? leadingIcon;

  /// [trailingIcon] is positioned inside of text field, after text input and
  /// provides ability to add icon button.
  final Widget? trailingIcon;

  /// [prefixText] is positioned on same vertical level as text input
  /// and positioned before text input, but without any paddings.
  final Widget? prefixText;

  /// [suffixText] is positioned on same vertical level as text input
  /// and positioned after text input.
  final Widget? suffixText;

  /// [linkWidget] is widget positioned under text input.
  /// The best usecase for this widget is "forgot password?" text button.
  final Widget? linkWidget;

  /// [showTextLength] counter under text field, but you need
  /// to also provide [maxLength] for maximum text length to it work.
  final bool showTextLength;

  /// Label that floats when text is selected.
  final String? label;

  /// Helper text under text field.
  final String? helperText;

  /// Trailing icon before the helper text under text field.
  final Icon? helperTrailingIcon;

  /// Hint that is positioned under text of input.
  final String? hint;

  /// Error text is shown instead of [helperText] when [inputState] is [InputState.error].
  final String? error;

  /// Success text is shown instead of [helperText] when [inputState] is [InputState.success].
  final String? successText;

  /// Success text is shown instead of [helperText] when [inputState] is [InputState.loading].
  final String? loadingText;

  /// {@macro dart.ui}
  final TextDirection textDirection;

  /// Whether text filed has focus.
  final bool hasFocus;

  /// [maxLength] defines maximum text in text field, it is not enforced and
  /// do not stops typing additional symbols, but symbols count will be shown
  /// with error color.
  final int? maxLength;

  /// [minLines] provides minimum amount of lines that text field
  /// contains. It can be used without [maxLines] property if
  /// [expandsWithNewLines] are provided.
  final int? minLines;

  /// [expandsWithNewLines] property allows text field to expand with every
  /// new line added to it. Do not provide [maxLines] property
  /// if you are using [expandsWithNewLines].
  final bool expandsWithNewLines;

  /// [maxLines] limits maximum amount of text field lines,
  /// if it not equal 1, it cannot be less than minLines.
  final int maxLines;

  /// Text of the input.
  final String text;

  /// [TextStyle] of the input.
  final TextStyle inputStyle;

  @override
  State<TextFieldDecorator> createState() => _TextFieldDecoratorState();
}

class _TextFieldDecoratorState extends State<TextFieldDecorator> with TickerProviderStateMixin {
  late TextStyle _helperStyle;
  late TextStyle _labelStyle;
  late TextStyle _floatingLabelStyle;
  late TextStyle _hintStyle;
  late TextStyle _linkWidgetStyle;
  late Color? _errorColor;
  late Color? _helperColor;
  late Color? _disabledColor;
  late Color? _successColor;
  late Color? _loadingColor;
  late EdgeInsets _padding;
  late EdgeInsets _margin;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setAndUpdateFields();
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    setAndUpdateFields();
  }

  void setAndUpdateFields() {
    final theme = context.easyDevTheme;
    final light = theme.brightness == Brightness.light;

    _errorColor = widget.decoration.errorColor ??
        theme.inputTheme?.errorColor ??
        theme.colorPalette.errorSwatch;

    _helperColor = widget.decoration.filledColor ??
        theme.inputTheme?.filledColor ??
        (light
            ? (theme.colorPalette.greySwatch.unselectedColor)
            : theme.colorPalette.secondarySwatch?[300]) ??
        theme.colorPalette.primarySwatch;

    _disabledColor = widget.decoration.disabledColor ??
        theme.inputTheme?.disabledColor ??
        (theme.brightness == Brightness.light
            ? theme.colorPalette.greySwatch.disabledColor
            : theme.colorPalette.greySwatch.tappedSurfaceColor);

    _successColor = widget.decoration.successColor ??
        theme.inputTheme?.successColor ??
        theme.colorPalette.successSwatch;

    _loadingColor = widget.decoration.loadingColor ??
        theme.inputTheme?.loadingColor ??
        (light
            ? (theme.colorPalette.tertiarySwatch?[600] ?? theme.colorPalette.secondarySwatch)
            : theme.colorPalette.tertiarySwatch?[200]) ??
        theme.colorPalette.secondarySwatch;

    _helperStyle = widget.decoration.helperStyle ??
        (theme.typography?.captionStyle ?? const TextStyle()).copyWith(
          color: widget.decoration.helperStyle?.color ??
              (light
                  ? (theme.colorPalette.greySwatch.unselectedColor ??
                      theme.colorPalette.greySwatch.greyColor)
                  : theme.colorPalette.secondarySwatch?[300] ??
                      theme.colorPalette.secondarySwatch ??
                      theme.colorPalette.primarySwatch),
        );

    _linkWidgetStyle = widget.decoration.linkWidgetStyle ??
        (theme.typography?.captionStyle ?? const TextStyle()).copyWith(
            color: widget.decoration.linkWidgetStyle?.color ??
                (light
                    ? (theme.colorPalette.linksSwatch?[600] ??
                        theme.colorPalette.linksSwatch ??
                        theme.colorPalette.primarySwatch)
                    : theme.colorPalette.linksSwatch?[400] ??
                        theme.colorPalette.linksSwatch ??
                        theme.colorPalette.primarySwatch));

    _hintStyle = widget.decoration.hintStyle ??
        (theme.typography?.body2Style ?? const TextStyle(fontSize: 16)).copyWith(
          color: widget.decoration.labelStyle?.color ??
              (light
                  ? widget.decoration.alwaysShowHint
                      ? theme.colorPalette.greySwatch.disabledColor
                      : theme.colorPalette.greySwatch.onSurfaceColor
                  : theme.colorPalette.greySwatch.greyColor),
        );

    _labelStyle = widget.decoration.labelStyle ??
        (theme.typography?.body2Style ?? const TextStyle(fontSize: 16)).copyWith(
          color: widget.decoration.labelStyle?.color ??
              (light
                  ? theme.colorPalette.greySwatch.onSurfaceColor
                  : theme.colorPalette.greySwatch.greyColor),
        );

    _floatingLabelStyle = widget.decoration.floatingLabelStyle ??
        (theme.typography?.captionStyle ?? const TextStyle(fontSize: 12)).copyWith(
          color: _helperColor,
        );

    _padding = EdgeInsets.only(
      left: (widget.decoration.inputPadding ?? theme.inputTheme?.padding)?.left ?? 8,
      right: (widget.decoration.inputPadding ?? theme.inputTheme?.padding)?.right ?? 8,
      top: (widget.decoration.inputPadding ?? theme.inputTheme?.padding)?.top ?? 4,
      bottom: (widget.decoration.inputPadding ?? theme.inputTheme?.padding)?.bottom ?? 4,
    );

    _margin = EdgeInsets.only(
      left: (widget.decoration.margin ?? theme.inputTheme?.margin)?.left ?? 16,
      right: (widget.decoration.margin ?? theme.inputTheme?.margin)?.right ?? 16,
      top: (widget.decoration.margin ?? theme.inputTheme?.margin)?.top ?? 8,
      bottom: (widget.decoration.margin ?? theme.inputTheme?.margin)?.bottom ?? 8,
    );
  }

  Color _getBorderColor(EasyDevThemeData theme, bool hasFocus) {
    if (widget.decoration.staticBorderColor != null) {
      return widget.decoration.staticBorderColor!;
    }
    final light = theme.brightness == Brightness.light;

    Color? color;

    if (hasFocus && widget.inputState == InputState.enabled) {
      return widget.decoration.focusedColor ??
          theme.inputTheme?.focusedColor ??
          (light
              ? (theme.colorPalette.secondarySwatch?[600])
              : theme.colorPalette.secondarySwatch?[500]) ??
          theme.colorPalette.secondarySwatch ??
          theme.colorPalette.primarySwatch;
    }

    switch (widget.inputState) {
      case InputState.enabled:
        color = widget.decoration.unfocusedColor ??
            theme.inputTheme?.unfocusedColor ??
            theme.colorPalette.greySwatch.unselectedColor ??
            theme.colorPalette.greySwatch.greyColor;
        break;
      case InputState.filled:
        color = widget.decoration.filledColor ??
            theme.inputTheme?.filledColor ??
            (light
                ? (theme.colorPalette.secondarySwatch?[300] ??
                    theme.colorPalette.secondarySwatch ??
                    theme.colorPalette.primarySwatch)
                : theme.colorPalette.secondarySwatch?[300]) ??
            theme.colorPalette.primarySwatch;
        break;
      case InputState.error:
        color = widget.decoration.errorColor ??
            theme.inputTheme?.errorColor ??
            (light
                ? (theme.colorPalette.errorSwatch?[400] ?? theme.colorPalette.errorSwatch)
                : theme.colorPalette.errorSwatch);
        break;
      case InputState.loading:
        color = widget.decoration.loadingColor ??
            theme.inputTheme?.loadingColor ??
            (light
                ? (theme.colorPalette.tertiarySwatch?[600] ?? theme.colorPalette.secondarySwatch)
                : theme.colorPalette.tertiarySwatch?[200] ?? theme.colorPalette.secondarySwatch);
        break;
      case InputState.disabled:
        color = widget.decoration.disabledColor ??
            theme.inputTheme?.disabledColor ??
            (light
                ? theme.colorPalette.greySwatch.disabledColor
                : theme.colorPalette.greySwatch.tappedSurfaceColor);
        break;
      case InputState.success:
        color = widget.decoration.successColor ??
            theme.inputTheme?.successColor ??
            theme.colorPalette.successSwatch;
        break;
    }

    return color ?? theme.colorPalette.primarySwatch;
  }

  Border _getBorder(
    EasyDevThemeData theme,
  ) {
    switch (widget.decoration.inputStyle) {
      case InputStyle.outlined:
        return Border.fromBorderSide(
          BorderSide(
            color: _getBorderColor(theme, widget.hasFocus),
          ),
        );
      case InputStyle.underline:
        return Border(
          bottom: BorderSide(
            color: _getBorderColor(theme, widget.hasFocus),
          ),
        );
      case InputStyle.borderless:
        return const Border();
    }
  }

  Color? _getIconColor(EasyDevThemeData theme, EasyDevIconButton icon, IconThemeData iconTheme) {
    if (widget.inputState == InputState.disabled) {
      return _disabledColor;
    }

    return widget.decoration.iconColor ??
        theme.inputTheme?.iconColor ??
        theme.iconTheme?.color ??
        iconTheme.color;
  }

  TextStyle get _getHintStyle {
    return widget.inputState == InputState.disabled
        ? _hintStyle.copyWith(color: _disabledColor)
        : _hintStyle;
  }

  TextStyle get _getHelperStyle {
    return widget.inputState == InputState.disabled
        ? _helperStyle.copyWith(color: _disabledColor)
        : _helperStyle;
  }

  int _invisibleHintLength() {
    return ((widget.hint ?? '').length > widget.text.length)
        ? widget.text.length
        : widget.hint?.length ?? 0;
  }

  double _getMultilineHeight(double lineHeight, int linesLength) {
    final minLinesCount = widget.minLines ?? linesLength;

    final numberOfLines = linesLength > minLinesCount ? linesLength : minLinesCount;

    if (widget.expandsWithNewLines) {
      return (numberOfLines - 1) * lineHeight;
    }
    if (widget.maxLines != 1) {
      final limitedLines = numberOfLines > widget.maxLines ? widget.maxLines : numberOfLines;

      return (limitedLines - 1) * lineHeight;
    }

    return 0;
  }

  TextStyle _getLabelStyle(EasyDevThemeData theme, bool isActive) {
    final style = isActive ? _floatingLabelStyle : _labelStyle;

    return widget.inputState == InputState.disabled ? style.copyWith(color: _disabledColor) : style;
  }

  TextStyle _getLinkWidgetStyle(EasyDevThemeData theme) {
    return widget.inputState == InputState.disabled
        ? _linkWidgetStyle.copyWith(color: _disabledColor)
        : _linkWidgetStyle;
  }

  TextStyle? _getPrefixStyle(EasyDevThemeData theme, bool isActive) {
    final prefixText = widget.prefixText;
    if (prefixText is Text) {
      final style = prefixText.style ?? (isActive ? widget.inputStyle : _labelStyle);

      return widget.inputState == InputState.disabled
          ? style.copyWith(color: _disabledColor)
          : style;
    }

    return null;
  }

  String? get _getHelperText {
    switch (widget.inputState) {
      case InputState.error:
        return widget.error;
      case InputState.loading:
        return widget.loadingText;
      case InputState.success:
        return widget.successText;
      default:
        return widget.helperText;
    }
  }

  Color? get _getHelperColor {
    switch (widget.inputState) {
      case InputState.error:
        return _errorColor;

      case InputState.loading:
        return _loadingColor;

      case InputState.success:
        return _successColor;

      case InputState.disabled:
        return _disabledColor;

      default:
        return _helperColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.easyDevTheme;

    Widget? leadingIcon = widget.leadingIcon;

    Widget? trailingIcon = widget.trailingIcon;

    Widget? prefixText = widget.prefixText;
    String? prefixTextData;

    Widget? suffixText = widget.suffixText;

    Widget? linkWidget = widget.linkWidget;

    final iconTheme = IconTheme.of(context);

    final textActive = (widget.hasFocus || widget.text.isNotEmpty);

    if (leadingIcon is EasyDevIconButton) {
      leadingIcon = EasyDevIconButton(
        leadingIcon.icon,
        onTap: leadingIcon.onTap,
        padding: leadingIcon.padding,
        key: leadingIcon.key,
        size: leadingIcon.size ?? 20,
        fill: leadingIcon.fill,
        weight: leadingIcon.weight,
        grade: leadingIcon.grade,
        opticalSize: leadingIcon.opticalSize,
        shadows: leadingIcon.shadows,
        color: _getIconColor(theme, leadingIcon, iconTheme),
        semanticLabel: leadingIcon.semanticLabel,
        textDirection: leadingIcon.textDirection,
      );
    }

    if (trailingIcon is EasyDevIconButton) {
      trailingIcon = EasyDevIconButton(
        trailingIcon.icon,
        onTap: trailingIcon.onTap,
        padding: trailingIcon.padding,
        key: trailingIcon.key,
        size: trailingIcon.size ?? 24,
        fill: trailingIcon.fill,
        weight: trailingIcon.weight,
        grade: trailingIcon.grade,
        opticalSize: trailingIcon.opticalSize,
        shadows: trailingIcon.shadows,
        color: _getIconColor(theme, trailingIcon, iconTheme),
        semanticLabel: trailingIcon.semanticLabel,
        textDirection: trailingIcon.textDirection,
      );
    }

    if (prefixText is Text) {
      prefixTextData = prefixText.data;
      prefixText = Text(
        prefixText.data ?? '',
        style: _getPrefixStyle(theme, textActive),
        strutStyle: prefixText.strutStyle,
        textAlign: prefixText.textAlign,
        textDirection: prefixText.textDirection,
        locale: prefixText.locale,
        softWrap: prefixText.softWrap,
        overflow: prefixText.overflow,
        textScaler: prefixText.textScaler,
        maxLines: prefixText.maxLines,
        semanticsLabel: prefixText.semanticsLabel,
        textWidthBasis: prefixText.textWidthBasis,
        textHeightBehavior: prefixText.textHeightBehavior,
        selectionColor: prefixText.selectionColor,
      );
    }

    if (suffixText is Text) {
      suffixText = Text(
        suffixText.data ?? '',
        style: suffixText.style ?? (textActive ? widget.inputStyle : _labelStyle),
        strutStyle: suffixText.strutStyle,
        textAlign: suffixText.textAlign,
        textDirection: suffixText.textDirection,
        locale: suffixText.locale,
        softWrap: suffixText.softWrap,
        overflow: suffixText.overflow,
        textScaler: suffixText.textScaler,
        maxLines: suffixText.maxLines,
        semanticsLabel: suffixText.semanticsLabel,
        textWidthBasis: suffixText.textWidthBasis,
        textHeightBehavior: suffixText.textHeightBehavior,
        selectionColor: suffixText.selectionColor,
      );
    }

    if (linkWidget is Text) {
      linkWidget = Text(
        linkWidget.data ?? '',
        style: _getLinkWidgetStyle(theme),
        strutStyle: linkWidget.strutStyle,
        textAlign: linkWidget.textAlign,
        textDirection: linkWidget.textDirection,
        locale: linkWidget.locale,
        softWrap: linkWidget.softWrap,
        overflow: linkWidget.overflow,
        textScaler: linkWidget.textScaler,
        maxLines: linkWidget.maxLines,
        semanticsLabel: linkWidget.semanticsLabel,
        textWidthBasis: linkWidget.textWidthBasis,
        textHeightBehavior: linkWidget.textHeightBehavior,
        selectionColor: linkWidget.selectionColor,
      );
    }

    double labelHeight = 0;

    if (widget.label != null) {
      final TextPainter floatingLabelText = TextPainter(
        textDirection: widget.textDirection,
        text: TextSpan(
          text: widget.label ?? '',
          style: _floatingLabelStyle,
        ),
      );
      floatingLabelText.layout();

      final lines = floatingLabelText.computeLineMetrics();

      if (lines.isNotEmpty) {
        labelHeight = lines.first.height + _padding.bottom;
      }
    }

    Widget textFieldContent;

    final needHint = (widget.hint != null) && ((textActive || widget.label == null));

    final alwaysShowHint = needHint && (widget.decoration.alwaysShowHint || widget.text.isEmpty);

    final needPrefixText = (widget.prefixText != null) && (textActive || widget.label == null);

    final needSuffixText = (widget.suffixText != null) && (textActive || widget.label == null);

    Widget? hint;

    if (alwaysShowHint) {
      hint = Align(
        alignment: widget.alignment,
        child: AnimatedPadding(
          padding: textActive
              ? EdgeInsets.only(
                  top: _padding.top + labelHeight,
                  bottom: _padding.bottom,
                  left: _padding.left + 3,
                  right: _padding.right,
                )
              : _padding,
          duration: _animationDuration,
          curve: Curves.fastOutSlowIn,
          child: RichText(
            softWrap: false,
            overflow: TextOverflow.ellipsis,
            textScaler: MediaQuery.textScalerOf(context),
            text: TextSpan(
              text: '${prefixTextData ?? ''}${(widget.hint ?? '').substring(
                0,
                _invisibleHintLength(),
              )}',
              style: _getHintStyle.copyWith(
                color: widget.decoration.backgroundColor ?? const Color(0x00000000),
              ),
              children: [
                TextSpan(
                  text: (widget.hint ?? '').substring(
                    _invisibleHintLength(),
                  ),
                  style: _getHintStyle,
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget? label;

    if (widget.label != null) {
      label = AnimatedPadding(
        duration: _animationDuration,
        curve: Curves.fastOutSlowIn,
        padding: textActive
            ? EdgeInsets.only(
                top: _padding.top,
                bottom: _padding.bottom,
                left: _padding.left,
                right: _padding.right,
              )
            : _padding,
        child: AnimatedAlign(
          duration: _animationDuration,
          alignment: textActive ? AlignmentDirectional.topStart : widget.alignment,
          child: AnimatedDefaultTextStyle(
            duration: _animationDuration,
            style: _getLabelStyle(theme, textActive),
            child: Text(
              widget.label ?? '',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      );
    }

    Widget? expandableTextIcon;

    if (widget.expandsWithNewLines) {
      expandableTextIcon = Align(
        alignment: AlignmentDirectional.bottomEnd,
        child: Padding(
          padding: EdgeInsets.only(
            bottom: _padding.bottom,
          ),
          child: Icon(
            EasyDevIcons.textArea,
            size: 16,
            color: widget.inputState == InputState.disabled ? _disabledColor : _helperColor,
          ),
        ),
      );
    }

    textFieldContent = Stack(
      fit: StackFit.expand,
      alignment: AlignmentDirectional.centerStart,
      textDirection: widget.textDirection,
      children: [
        label ?? const SizedBox(),
        Align(
          alignment: widget.alignment,
          child: AnimatedPadding(
            padding: textActive
                ? EdgeInsets.only(
                    top: _padding.top + labelHeight,
                    bottom: _padding.bottom,
                    left: _padding.left,
                    right: _padding.right,
                  )
                : _padding,
            duration: _animationDuration,
            curve: Curves.fastOutSlowIn,
            child: Row(
              children: [
                if (needPrefixText) prefixText ?? const SizedBox(),
                Expanded(
                  child: widget.child,
                ),
                if (needSuffixText) suffixText ?? const SizedBox(),
              ],
            ),
          ),
        ),
        hint ?? const SizedBox(),
        expandableTextIcon ?? const SizedBox(),
      ],
    );

    final needIconsInside = [
      widget.leadingIcon,
      widget.trailingIcon,
      widget.prefixText,
      widget.suffixText,
    ].where((element) => element != null).isNotEmpty;

    Widget? innerRow;

    if (needIconsInside) {
      innerRow = Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (leadingIcon != null)
            SizedBox(
              width: _padding.left * 2,
            ),
          AnimatedOpacity(
            opacity: leadingIcon != null ? 1 : 0,
            duration: _animationDuration,
            child: leadingIcon ?? const SizedBox(),
          ),
          Expanded(
            child: textFieldContent,
          ),
          AnimatedOpacity(
            opacity: trailingIcon != null ? 1 : 0,
            duration: _animationDuration,
            child: trailingIcon ?? const SizedBox(),
          ),
          if (trailingIcon != null)
            SizedBox(
              width: _padding.right * 2,
            ),
        ],
      );
    }

    Widget? bottomRow;

    final needBottomRow = widget.helperText != null ||
        linkWidget != null ||
        (widget.showTextLength && widget.maxLength != null);

    if (needBottomRow) {
      bottomRow = Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            width: _margin.left,
          ),
          Expanded(
            child: Row(
              children: [
                if (widget.helperTrailingIcon != null) ...[
                  widget.helperTrailingIcon!,
                  const SizedBox(
                    width: 4,
                  ),
                ],
                Expanded(
                  child: Text(
                    _getHelperText ?? '',
                    style: _helperStyle.copyWith(color: _getHelperColor),
                    overflow: widget.decoration.helperStyle?.overflow ?? TextOverflow.ellipsis,
                    textDirection: widget.textDirection,
                  ),
                ),
              ],
            ),
          ),
          if (widget.showTextLength && widget.maxLength != null) ...[
            AnimatedDefaultTextStyle(
              duration: _animationDuration,
              style: (widget.text.length > (widget.maxLength ?? 0))
                  ? _getHelperStyle.copyWith(
                      color:
                          widget.inputState != InputState.disabled ? _errorColor : _disabledColor,
                    )
                  : _getHelperStyle,
              child: Text(
                widget.text.length.toString(),
              ),
            ),
            Text(
              '/${widget.maxLength.toString()}',
              style: _getHelperStyle,
            )
          ],
          linkWidget ?? const SizedBox(),
          SizedBox(
            width: _margin.right,
          ),
        ],
      );
    }

    Widget decoratedTextField = Column(
      children: [
        AnimatedContainer(
          duration: _animationDuration,
          //Provides only horizontal and top margins.
          // Because in case linkWidget, helperText, or textLength was provided, margin differs from standard.
          margin: EdgeInsets.only(
            left: _margin.left,
            right: _margin.right,
            top: _margin.top,
          ),
          decoration: BoxDecoration(
            color: widget.decoration.backgroundColor,
            borderRadius: widget.decoration.borderRadius,
            border: _getBorder(theme),
          ),
          child: Padding(
            padding: _padding,
            child: LayoutBuilder(builder: (context, constraints) {
              final multiline =
                  (widget.expandsWithNewLines) || (widget.minLines ?? 0) > 1 || widget.maxLines > 1;

              double multilineHeight = 0;
              if (multiline) {
                List<LineMetrics> lines = [];

                final TextPainter text = TextPainter(
                  textScaler: MediaQuery.textScalerOf(context),
                  textDirection: widget.textDirection,
                  text: TextSpan(
                    //Placeholder text is provided to calculate line height
                    text: widget.text.isNotEmpty ? widget.text : 'Placeholder text',
                    style: widget.inputStyle,
                  ),
                );

                text.layout(
                  minWidth: constraints.minWidth,
                  maxWidth: constraints.maxWidth - _padding.left - _padding.right,
                );

                lines = text.computeLineMetrics();

                if (lines.isNotEmpty) {
                  multilineHeight = _getMultilineHeight(lines.first.height, lines.length);
                }
              }

              return AnimatedContainer(
                duration: _animationDuration,
                height: widget.decoration.height ?? (56 + multilineHeight),
                child: innerRow ?? textFieldContent,
              );
            }),
          ),
        ),
        if (needBottomRow) ...[
          const SizedBox(
            height: 8,
          ),
          bottomRow ?? const SizedBox(),
        ],
        SizedBox(
          height: _margin.bottom,
        )
      ],
    );

    return decoratedTextField;
  }
}
