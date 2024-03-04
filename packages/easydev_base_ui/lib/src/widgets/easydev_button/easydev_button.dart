import 'package:flutter/widgets.dart';
import 'package:easydev_theme/easydev_theme.dart';

/// The [EasyDevButton] serves as a customizable button component for user interaction.
/// It offers properties such as [text] for button label, [onTap] for defining tap actions,
/// and [icon] to place after text. It has five built-in constructors that have many already
/// set values.
///
/// Text of the [EasyDevButton] can be changed to uppercase with [uppercase].
/// Corners of the [EasyDevButton] can be rounded with [softButton].
/// [EasyDevButton] can be outlined with [outlined].
/// [EasyDevButton] can be disabled with [disabled].
/// Borders of [EasyDevButton] can be hid or shown with [showBorder].
/// Other fields can be used to change [EasyDevButton] appearence.
///
///
///
/// Example of using [EasyDevButton.primary] constructor.
/// ```dart
/// EasyDevButton.primary(
///   text: 'Button',
///   onTap: () {
///     // Add your onTap code here!
///   },
/// ),
/// ```
///
/// Example of using [EasyDevButton.primarySmall] constructor.
/// ```dart
/// EasyDevButton.primarySmall(
///   text: 'Button',
///   onTap: () {
///     // Add your onTap code here!
///   },
///   minWidth: 144,
/// ),
/// ```
///
/// Example of using [EasyDevButton.outlined] constructor.
/// ```dart
/// EasyDevButton.outlined(
///   text: 'Button',
///   onTap: () {
///     // Add your onTap code here!
///   },
/// ),
/// ```
///
/// Example of using [EasyDevButton.outlinedSmall] constructor.
/// ```dart
/// EasyDevButton.outlinedSmall(
///   text: 'Button',
///   onTap: () {
///     // Add your onTap code here!
///   },
///   minWidth: 144,
/// ),
/// ```
///
/// Example of using [EasyDevButton.text] constructor.
/// ```dart
/// EasyDevButton.text(
///   text: 'Button',
///   onTap: () {
///     // Add your onTap code here!
///   },
/// ),
///
/// ```
/// Example of using [EasyDevButton].
/// ```dart
/// EasyDevButton(
///   text: 'Button',
///   onTap: () {
///     // Add your onTap code here!
///   },
/// ),
/// ```
///
///
/// This sample produces variants of EasyDevButton.
///
/// See code in easydev_base_ui/example/lib/dartpad_examples/easydev_button_example.dart
class EasyDevButton extends StatefulWidget {
  /// Create a button.
  const EasyDevButton({
    super.key,
    required this.text,
    required this.onTap,
    this.textStyle,
    this.color,
    this.disabledColor,
    this.tapColor,
    this.outlinedColor,
    this.outlinedDisabledColor,
    this.outlinedTapColor,
    this.padding = const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
    this.margin = const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    this.expanded = true,
    this.minWidth,
    this.height,
    this.borderRadius,
    this.iconMargin,
    this.textColor,
    this.icon,
    this.uppercase = true,
    this.softButton = false,
    this.outlined = false,
    this.disabled = false,
    this.showBorder = true,
  });

  /// Constructor for primary button.
  const factory EasyDevButton.primary({
    required String? text,
    required VoidCallback onTap,
    EdgeInsets? margin,
    double? height,
    IconData? icon,
    double? iconMargin,
    bool uppercase,
    bool softButton,
    bool disabled,
  }) = _PrimaryButton;

  /// Constructor for primary small button.
  ///
  /// It is not expanded unlike ordinary primary button.
  const factory EasyDevButton.primarySmall({
    required String? text,
    required VoidCallback onTap,
    required double minWidth,
    double? height,
    IconData? icon,
    double? iconMargin,
    bool uppercase,
    bool softButton,
    bool disabled,
  }) = _PrimarySmallButton;

  /// Constructor for outlined button.
  ///
  /// It differs from primary button in
  /// outlined border.
  const factory EasyDevButton.outlined({
    required String? text,
    required VoidCallback onTap,
    EdgeInsets? margin,
    double? height,
    IconData? icon,
    double? iconMargin,
    bool uppercase,
    bool softButton,
    bool disabled,
  }) = _OutlinedButton;

  /// Constructor for outlined small button.
  ///
  /// It is not expanded unlike ordinary outlined button.
  const factory EasyDevButton.outlinedSmall({
    required String? text,
    required VoidCallback onTap,
    required double minWidth,
    double? height,
    IconData? icon,
    double? iconMargin,
    bool uppercase,
    bool softButton,
    bool disabled,
  }) = _OutlinedSmallButton;

  /// Constructor for text button.
  const factory EasyDevButton.text({
    required String? text,
    required VoidCallback onTap,
    TextStyle? textStyle,
    Color? textColor,
    double? height,
    IconData? icon,
    double? iconMargin,
    bool uppercase,
    bool disabled,
  }) = _TextButton;

  /// Text inside the button.
  final String? text;

  /// Callback that will run on button tap.
  final VoidCallback onTap;

  /// TextStyle of button text.
  final TextStyle? textStyle;

  /// Color of the button.
  /// Becomes the color of the outline border if [outlined] is true.
  final Color? color;

  /// Color of the button when [disabled] is true.
  final Color? disabledColor;

  /// Color of the button when it is tapped.
  final Color? tapColor;

  /// Color of the [outlined] button.
  final Color? outlinedColor;

  /// Color of the [outlined] button when [disabled] is true.
  final Color? outlinedDisabledColor;

  /// Color of the [outlined] button when it is tapped.
  final Color? outlinedTapColor;

  /// Padding between contents of the button and its border.
  final EdgeInsets? padding;

  /// Margin outside of the button.
  final EdgeInsets? margin;

  /// Should this button be as wide as constraints permit.
  final bool expanded;

  /// Minimal width of the button.
  final double? minWidth;

  /// Height of the button.
  final double? height;

  /// Border radius of the button.
  final BorderRadius? borderRadius;

  /// Margin between text and icon.
  final double? iconMargin;

  /// Color of the text inside the button.
  final Color? textColor;

  /// [IconData] to place after the text.
  final IconData? icon;

  /// Whether the text is in upper case.
  final bool uppercase;

  /// Whether the button has rounded corners.
  final bool softButton;

  /// Whether the button is outlined.
  final bool outlined;

  /// Whether the button is disabled.
  final bool disabled;

  /// Whether the button show its border.
  final bool showBorder;

  @override
  State<EasyDevButton> createState() => _EasyDevButtonState();
}

class _EasyDevButtonState extends State<EasyDevButton> {
  late Color? _enabledButtonColor;
  late Color? _disabledButtonColor;
  late Color? _tapButtonColor;
  late Color? _outlinedEnableButtonColor;
  late Color? _outlinedDisabledButtonColor;
  late Color? _outlinedTapButtonColor;
  late EdgeInsets _buttonPadding;
  late EdgeInsets _buttonMargin;
  late double _buttonMinWidth;
  late double _buttonHeight;
  late BorderRadius? _buttonBorderRadius;
  late double _buttonIconMargin;
  late Color? _buttonTextColor;
  late TextStyle? _buttonTextStyle;
  bool buttonPressed = false;

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
    final theme = EasyDevTheme.of(context);
    final themePalette = theme.colorPalette;
    final buttonTheme = theme.buttonTheme;
    final brightness = theme.brightness;

    _enabledButtonColor = widget.color ??
        buttonTheme?.defaultColor ??
        (brightness == Brightness.dark
            ? themePalette.primarySwatch[600]
            : themePalette.primarySwatch[400]) ??
        themePalette.primarySwatch;
    _disabledButtonColor = widget.disabledColor ??
        buttonTheme?.disabledColor ??
        (brightness == Brightness.dark
            ? themePalette.primarySwatch[900]
            : themePalette.primarySwatch[50]) ??
        themePalette.primarySwatch;
    _tapButtonColor = widget.tapColor ??
        buttonTheme?.tapColor ??
        (brightness == Brightness.dark
            ? themePalette.primarySwatch[800]
            : themePalette.primarySwatch[500]) ??
        themePalette.primarySwatch;
    _outlinedEnableButtonColor = brightness == Brightness.dark
        ? _enabledButtonColor
        : (themePalette.primarySwatch[600] ?? _disabledButtonColor);
    _outlinedDisabledButtonColor = brightness == Brightness.dark
        ? _disabledButtonColor
        : (themePalette.primarySwatch[200] ?? _disabledButtonColor);
    _outlinedTapButtonColor = brightness == Brightness.dark
        ? _tapButtonColor
        : (themePalette.primarySwatch[800] ?? _disabledButtonColor);

    _buttonPadding = widget.padding ?? buttonTheme?.padding ?? const EdgeInsets.all(16);
    _buttonMargin = widget.margin ?? buttonTheme?.margin ?? EdgeInsets.zero;
    _buttonMinWidth = widget.minWidth ?? buttonTheme?.minWidth ?? 0;
    _buttonHeight =
        widget.height ?? buttonTheme?.height ?? _buttonPadding.top + _buttonPadding.bottom + 26;
    _buttonBorderRadius = widget.borderRadius ??
        (widget.softButton
            ? buttonTheme?.softButtonBorderRadius ?? const BorderRadius.all(Radius.circular(54))
            : buttonTheme?.borderRadius ?? const BorderRadius.all(Radius.circular(8)));
    _buttonIconMargin = widget.iconMargin ?? buttonTheme?.iconMargin ?? 8;
    _buttonTextColor = widget.textColor ??
        buttonTheme?.textColor ??
        (brightness == Brightness.dark
            ? theme.colorPalette.greySwatch.onPrimary
            : widget.disabled
                ? theme.colorPalette.primarySwatch[600]
                : theme.colorPalette.primarySwatch[900]) ??
        theme.colorPalette.greySwatch.onSurfaceColor;
    _buttonTextStyle = widget.textStyle ?? theme.typography?.buttonStyle;
  }

  Color? get _getButtonColor {
    if (widget.textColor != null) {
      return widget.textColor;
    }
    if (widget.outlined) {
      if (widget.disabled) {
        return _outlinedDisabledButtonColor;
      }
      if (buttonPressed) {
        return _outlinedTapButtonColor;
      }
      return _outlinedEnableButtonColor;
    }
    if (widget.disabled) {
      return _disabledButtonColor;
    }
    if (buttonPressed) {
      return _tapButtonColor;
    }
    return _enabledButtonColor;
  }

  @override
  Widget build(BuildContext context) {
    final text = widget.text ?? "";
    final innerText = widget.uppercase ? text.toUpperCase() : text;

    final textColor = widget.outlined ? _getButtonColor : _buttonTextColor;
    final buttonText = Text(
      innerText,
      style: widget.textStyle?.copyWith(color: textColor) ??
          _buttonTextStyle?.copyWith(color: textColor) ??
          TextStyle(color: textColor),
      overflow: TextOverflow.ellipsis,
    );

    final buttonChild = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: widget.expanded ? MainAxisSize.max : MainAxisSize.min,
      children: [
        if (widget.expanded && widget.icon != null)
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text.rich(
                TextSpan(
                    text: '$innerText  ',
                    style: widget.textStyle?.copyWith(color: textColor) ??
                        _buttonTextStyle?.copyWith(color: textColor) ??
                        TextStyle(color: textColor),
                    children: [
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Icon(
                          widget.icon!,
                          color: textColor,
                          size: 16,
                        ),
                      ),
                    ]),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
        else if (widget.expanded)
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: buttonText,
            ),
          )
        else ...[
          buttonText,
          if (widget.icon != null) SizedBox(width: _buttonIconMargin),
          if (widget.icon != null)
            Icon(
              widget.icon!,
              color: textColor,
            ),
        ]
      ],
    );

    return Padding(
      padding: _buttonMargin,
      child: GestureDetector(
        onTapDown: (_) {
          if (widget.disabled) return;
          setState(() {
            buttonPressed = true;
          });
        },
        onTapCancel: () {
          if (widget.disabled) return;
          setState(() {
            buttonPressed = false;
          });
        },
        onTapUp: (_) {
          if (widget.disabled) return;
          widget.onTap();
          setState(() {
            buttonPressed = false;
          });
        },
        child: Container(
          height: _buttonHeight,
          constraints: BoxConstraints(minWidth: _buttonMinWidth),
          padding: _buttonPadding,
          decoration: BoxDecoration(
            color: widget.outlined ? const Color(0x00000000) : _getButtonColor,
            borderRadius: _buttonBorderRadius,
            border: widget.showBorder
                ? Border.all(color: _getButtonColor ?? const Color(0xFF000000))
                : null,
          ),
          child: buttonChild,
        ),
      ),
    );
  }
}

class _PrimaryButton extends EasyDevButton {
  const _PrimaryButton({
    required super.text,
    required super.onTap,
    super.margin,
    super.height,
    super.icon,
    super.iconMargin,
    super.uppercase = true,
    super.softButton = false,
    super.disabled = false,
  }) : super(expanded: true, outlined: false);
}

class _PrimarySmallButton extends EasyDevButton {
  const _PrimarySmallButton({
    required super.text,
    required super.onTap,
    required super.minWidth,
    super.height,
    super.icon,
    super.iconMargin,
    super.uppercase = true,
    super.softButton = false,
    super.disabled = false,
  }) : super(expanded: false, outlined: false);
}

class _OutlinedButton extends EasyDevButton {
  const _OutlinedButton({
    required super.text,
    required super.onTap,
    super.margin,
    super.height,
    super.icon,
    super.iconMargin,
    super.uppercase = true,
    super.softButton = false,
    super.disabled = false,
  }) : super(expanded: true, outlined: true);
}

class _OutlinedSmallButton extends EasyDevButton {
  const _OutlinedSmallButton({
    required super.text,
    required super.onTap,
    required super.minWidth,
    super.height,
    super.icon,
    super.iconMargin,
    super.uppercase = true,
    super.softButton = false,
    super.disabled = false,
  }) : super(expanded: false, outlined: true);
}

class _TextButton extends EasyDevButton {
  const _TextButton({
    required super.text,
    required super.onTap,
    super.textStyle,
    super.textColor,
    super.height,
    super.icon,
    super.iconMargin,
    super.uppercase = true,
    super.disabled = false,
  }) : super(
          showBorder: false,
          expanded: false,
          outlined: true,
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
        );
}
