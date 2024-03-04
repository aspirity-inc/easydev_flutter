import 'dart:io';
import 'dart:math';

import 'package:easydev_base_ui/easydev_base_ui.dart';
import 'package:easydev_base_ui/src/widgets/text_field/easydev_text_field_context_menu.dart';
import 'package:easydev_base_ui/src/widgets/text_field/text_field_decorator.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// {@template easudev_base_ui.lib.widgets.text_field.easudev_text_field}
/// The [EasyDevTextField] enables the creation of customizable text input fields.
/// Developers can utilize this widget to create text input fields with options for
/// labels, helper text, hints, errors, and success messages,
/// adapting based on the current [inputState].
///
/// [EasyDevTextField] provides properties for adding additional elements to this widget
/// such as [trailingIcon], [focusedTrailingIcon], [leadingIcon], [prefixText], [suffixText],
/// [linkWidget].
///
/// [EasyDevTextField] provides most of the common properties for text field.
/// [decoration] can be used for customizing appearence of [EasyDevTextField].
/// {@endtemplate}
///
/// Do not have initial value.
/// To use text with value use [EasyDevTextFormField].
///
///
/// Example of using [EasyDevTextField].
/// ```dart
/// EasyDevTextField(
///   hint: 'Input',
///   valueChanged: (value) {
///     // Add your valueChanged code here!
///   }
/// ),
/// ```
///
///
///
/// This sample produces variant of EasyDevTextField.
///
/// See code in easydev_base_ui/example/lib/dartpad_examples/easydev_text_field_example.dart
class EasyDevTextField extends StatefulWidget {
  const EasyDevTextField({
    super.key,
    this.valueChanged,
    this.label,
    this.helperText,
    this.helperTrailingIcon,
    this.hint,
    this.error,
    this.successText,
    this.loadingText,
    this.trailingIcon,
    this.focusedTrailingIcon,
    this.leadingIcon,
    this.prefixText,
    this.suffixText,
    this.linkWidget,
    this.controller,
    this.undoHistoryController,
    this.inputFormatters,
    this.focusNode,
    this.restorationId,
    this.minLines,
    this.alignment = AlignmentDirectional.centerStart,
    this.decoration = const EasyDevInputDecoration(),
    this.inputState = InputState.enabled,
    this.textDirection = TextDirection.ltr,
    this.textAlign = TextAlign.start,
    this.obscureText = false,
    this.showTextLength = false,
    this.maxLines,
    this.maxLength,
    this.expandsWithNewLines = false,
    TextInputType? textInputType,
    this.onTap,
    this.showCursor,
    this.contextMenuBuilder = _defaultContextMenuBuilder,
  })  : assert(showTextLength == false || linkWidget == null,
            'You can\'t provide link and text lenght widget'),
        assert(maxLines == null || !expandsWithNewLines,
            'You can\'t maxLines to expandable TextField'),
        assert(
            (maxLines == null && minLines == null) ||
                (trailingIcon == null &&
                    leadingIcon == null &&
                    prefixText == null &&
                    suffixText == null),
            'You can\'t use suffix and prefix icons in multiline TextFields'),
        assert(!obscureText || maxLines != 1, 'Obscured fields cannot be multiline.'),
        textInputType =
            textInputType ?? (maxLines == 1 ? TextInputType.text : TextInputType.multiline);

  /// Callback called on changing value.
  final ValueChanged<String>? valueChanged;

  /// Label that floats when text is selected.
  final String? label;

  /// Helper text under text field.
  final String? helperText;

  /// Trailing icon before the helper text under text field.
  final Icon? helperTrailingIcon;

  /// {@macro easydev_base_ui.widgets.easydev_input_decoration}
  /// Hint that is positioned under text of input.
  /// If [EasyDevInputDecoration.alwaysShowHint] is false hint disappears
  /// when text inputting is started.
  /// If [EasyDevInputDecoration.alwaysShowHint] is true, hint text length
  /// of input text is invisible.
  /// Best use case of using [EasyDevInputDecoration.alwaysShowHint]
  /// is by using it with input formatters.
  final String? hint;

  /// {@macro easydev_base_ui.widgets.text_field.enums.input_state}
  /// Error text is shown instead of [helperText] when [inputState] is [InputState.error].
  final String? error;

  /// {@macro easydev_base_ui.widgets.text_field.enums.input_state}
  /// Success text is shown instead of [helperText] when [inputState] is [InputState.success].
  final String? successText;

  /// {@macro easydev_base_ui.widgets.text_field.enums.input_state}
  /// Success text is shown instead of [helperText] when [inputState] is [InputState.loading].
  final String? loadingText;

  /// {@macro easydev_base_ui.widgets.text_field.enums.input_state}
  /// [InputState] enum provides you room for customization, when you need
  /// to implement different text field use cases. They have different
  /// customisation
  /// [InputState.enabled] is focusable text field.
  /// [InputState.disabled] disables text field.
  /// [InputState.error] show [error] instead of [helperText] when [error] is provided.
  /// [InputState.success] show [successText] instead of [helperText] when [successText] is provided.
  /// Other [InputState] value just change decoration of text field.
  final InputState inputState;

  /// {@macro dart.ui}
  final TextDirection textDirection;

  /// {@macro flutter.widgets.editableText.textAlign}
  final TextAlign textAlign;

  /// {@macro flutter.widgets.editableText.obscureText}
  final bool obscureText;

  /// [showTextLength] counter under text field, but you need
  /// to also provide [maxLength] for maximum text length to it work.
  final bool showTextLength;

  /// [decoration] provides ability to change textField apperance, such as color,
  /// textStyles, and border appearance.
  final EasyDevInputDecoration decoration;

  /// [trailingIcon] is positioned inside of text field, after text input and
  /// provides ability to add icon button.
  final Widget? trailingIcon;

  /// [focusedTrailingIcon] is positioned inside of text field, after text input and
  /// provides ability to add icon button when TextField is focused.
  final Widget? focusedTrailingIcon;

  /// [leadingIcon] is positioned inside of text field, before text input and
  /// provides ability to add icon button.
  final EasyDevIconButton? leadingIcon;

  /// [prefixText] is positioned on same vertical level as text input
  /// and positioned before text input, but without any paddings.
  final Widget? prefixText;

  /// [suffixText] is positioned on same vertical level as text input
  /// and positioned after text input.
  final Widget? suffixText;

  /// [linkWidget] is widget positioned under text input.
  /// The best usecase for this widget is "forgot password?" text button.
  final Widget? linkWidget;

  /// {@macro flutter.widgets.editable_text.textEditingController}
  /// Controls the text being edited.
  ///
  /// If null, this widget will create its own [TextEditingController].
  final TextEditingController? controller;

  /// {@macro flutter.widgets.undoHistory.controller}
  final UndoHistoryController? undoHistoryController;

  /// {@macro flutter.widgets.editableText.inputFormatters}
  final List<TextInputFormatter>? inputFormatters;

  /// {@macro flutter.widgets.editableText.keyboardType}
  final TextInputType? textInputType;

  /// Defines the keyboard focus for this widget.
  ///
  /// The [focusNode] is a long-lived object that's typically managed by a
  /// [StatefulWidget] parent. See [FocusNode] for more information.
  ///
  /// To give the keyboard focus to this widget, provide a [focusNode] and then
  /// use the current [FocusScope] to request the focus:
  ///
  /// ```dart
  /// FocusScope.of(context).requestFocus(myFocusNode);
  /// ```
  ///
  /// This happens automatically when the widget is tapped.
  ///
  /// To be notified when the widget gains or loses the focus, add a listener
  /// to the [focusNode]:
  ///
  /// ```dart
  /// myFocusNode.addListener(() { print(myFocusNode.hasFocus); });
  /// ```
  ///
  /// If null, this widget will create its own [FocusNode].
  ///
  /// ## Keyboard
  ///
  /// Requesting the focus will typically cause the keyboard to be shown
  /// if it's not showing already.
  ///
  /// On Android, the user can hide the keyboard - without changing the focus -
  /// with the system back button. They can restore the keyboard's visibility
  /// by tapping on a text field. The user might hide the keyboard and
  /// switch to a physical keyboard, or they might just need to get it
  /// out of the way for a moment, to expose something it's
  /// obscuring. In this case requesting the focus again will not
  /// cause the focus to change, and will not make the keyboard visible.
  ///
  /// This widget builds an [EditableText] and will ensure that the keyboard is
  /// showing when it is tapped by calling [EditableTextState.requestKeyboard()].
  final FocusNode? focusNode;

  /// Restoration ID to save and restore the state of the text field.
  ///
  /// If non-null, the text field will persist and restore its current scroll
  /// offset and - if no [controller] has been provided - the content of the
  /// text field. If a [controller] has been provided, it is the responsibility
  /// of the owner of that controller to persist and restore it, e.g. by using
  /// a [RestorableTextEditingController].
  ///
  /// The state of this widget is persisted in a [RestorationBucket] claimed
  /// from the surrounding [RestorationScope] using the provided restoration ID.
  final String? restorationId;

  /// [maxLines] limits maximum amount of text field lines,
  /// if it not equal 1, it cannot be less than minLines.
  final int? maxLines;

  /// [minLines] provides minimum amount of lines that text field
  /// contains. It can be used without [maxLines] property if
  /// [expandsWithNewLines] are provided.
  final int? minLines;

  /// [maxLength] defines maximum text in text field, it is not enforced and
  /// do not stops typing additional symbols, but symbols count will be shown
  /// with error color.
  final int? maxLength;

  /// {@macro flutter.painting.alignment}
  final AlignmentDirectional alignment;

  /// [expandsWithNewLines] property allows text field to expand with every
  /// new line added to it. Do not provide [maxLines] property
  /// if you are using [expandsWithNewLines].
  final bool expandsWithNewLines;

  /// Provides callback on widget tapped.
  final VoidCallback? onTap;

  /// Should widget show cursor.
  final bool? showCursor;

  /// {@macro flutter.widgets.EditableText.contextMenuBuilder}
  ///
  /// If not provided, will build a default menu.
  ///
  /// See also:
  ///
  ///  * [EasyDevTextFieldContextMenu], which is built by default.
  final EditableTextContextMenuBuilder? contextMenuBuilder;

  static Widget _defaultContextMenuBuilder(
    BuildContext context,
    EditableTextState editableTextState,
  ) {
    final anchor = editableTextState.contextMenuAnchors.primaryAnchor;
    final buttonItems = editableTextState.contextMenuButtonItems;

    return EasyDevTextFieldContextMenu(
      anchor: anchor,
      buttonItems: buttonItems,
    );
  }

  @override
  State<EasyDevTextField> createState() => _EasyDevTextFieldState();
}

class _EasyDevTextFieldState extends State<EasyDevTextField>
    with RestorationMixin, AutomaticKeepAliveClientMixin<EasyDevTextField>
    implements TextSelectionGestureDetectorBuilderDelegate, AutofillClient {
  RestorableTextEditingController? _controller;

  TextEditingController get _effectiveController => widget.controller ?? _controller!.value;

  late _EasyDevTextFieldSelectionGestureDetectorBuilder _selectionGestureDetectorBuilder;

  FocusNode? _focusNode;

  FocusNode get _effectiveFocusNode => widget.focusNode ?? (_focusNode ??= FocusNode());

  bool get _disabled => widget.inputState == InputState.disabled;

  late Color _selectionColor;
  late Color _cursorColor;
  late Color _backgroundCursorColor;
  late TextStyle _textStyle;

  bool _showSelectionHandles = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setAndUpdateFields();
  }

  void setAndUpdateFields() {
    final theme = context.easyDevTheme;
    final light = theme.brightness == Brightness.light;

    _selectionColor = widget.decoration.focusedColor ??
        theme.inputTheme?.focusedColor ??
        (light
            ? (theme.colorPalette.secondarySwatch?[300] ?? theme.colorPalette.secondarySwatch)
            : theme.colorPalette.secondarySwatch) ??
        theme.colorPalette.primarySwatch;

    _cursorColor = widget.decoration.cursorColor ?? theme.brightness.onSurfaceColor;

    _backgroundCursorColor =
        widget.decoration.backgroundCursorColor ?? theme.brightness.onSurfaceColor;

    _textStyle = widget.decoration.textStyle ??
        (theme.typography?.body2Style ?? const TextStyle(fontSize: 16)).copyWith(
          color: theme.inputTheme?.textColor ?? theme.brightness.onSurfaceColor,
        );
  }

  @override
  void initState() {
    super.initState();

    _selectionGestureDetectorBuilder = _EasyDevTextFieldSelectionGestureDetectorBuilder(
      state: this,
    );
    if (widget.controller == null) {
      _createLocalController();
    }
    _effectiveFocusNode.canRequestFocus = !_disabled;
    _effectiveFocusNode.addListener(_handleFocusChanged);
  }

  @override
  void didUpdateWidget(EasyDevTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller == null && oldWidget.controller != null) {
      _createLocalController(oldWidget.controller!.value);
    } else if (widget.controller != null && oldWidget.controller == null) {
      unregisterFromRestoration(_controller!);
      _controller!.dispose();
      _controller = null;
    }

    if (widget.focusNode != oldWidget.focusNode) {
      (oldWidget.focusNode ?? _focusNode)?.removeListener(_handleFocusChanged);
      (widget.focusNode ?? _focusNode)?.addListener(_handleFocusChanged);
    }
    _effectiveFocusNode.canRequestFocus = !_disabled;

    if (_effectiveFocusNode.hasFocus) {
      _showSelectionHandles = !_effectiveController.selection.isCollapsed;
    }

    setAndUpdateFields();
  }

  @override
  void dispose() {
    _effectiveFocusNode.removeListener(_handleFocusChanged);
    _focusNode?.dispose();
    _controller?.dispose();
    super.dispose();
  }

  /// {@macro flutter.widgets.text_selection}
  /// API for [TextSelectionGestureDetectorBuilderDelegate].
  @override
  bool get forcePressEnabled => false;

  @override
  final GlobalKey<EditableTextState> editableTextKey = GlobalKey<EditableTextState>();

  @override
  bool get selectionEnabled => true;

  /// End of API for [TextSelectionGestureDetectorBuilderDelegate].

  /// {@macro flutter.widgets.restoration}
  /// API for [RestorationMixin].
  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    if (_controller != null) {
      _registerController();
    }
  }

  @override
  String? get restorationId => widget.restorationId;

  /// End of Api for [RestorationMixin].

  /// {@macro flutter.widgets.automatic_keep_alive}
  /// Api for [AutomaticKeepAliveClientMixin].
  @override
  bool get wantKeepAlive => _controller?.value.text.isNotEmpty ?? false;

  /// End of Api for [AutomaticKeepAliveClientMixin].

  /// {@macro flutter.services.autofill}
  /// Api for [AutofillClient].
  @override
  String get autofillId => _editableText!.autofillId;

  @override
  void autofill(TextEditingValue newEditingValue) => _editableText!.autofill(newEditingValue);

  @override
  TextInputConfiguration get textInputConfiguration {
    return _editableText!.textInputConfiguration
        .copyWith(autofillConfiguration: AutofillConfiguration.disabled);
  }

  /// End of Api for [AutofillClient].

  EditableTextState? get _editableText => editableTextKey.currentState;

  void _registerController() {
    assert(_controller != null);
    registerForRestoration(_controller!, 'controller');
    _controller!.value.addListener(updateKeepAlive);
  }

  void _createLocalController([TextEditingValue? value]) {
    assert(_controller == null);
    _controller = value == null
        ? RestorableTextEditingController()
        : RestorableTextEditingController.fromValue(value);
    if (!restorePending) {
      _registerController();
    }
  }

  void _requestKeyboard() {
    _editableText?.requestKeyboard();
  }

  void _handleFocusChanged() {
    setState(() {
      // Rebuild the widget on focus change to show/hide the text selection
      // highlight.
    });
  }

  void _handleSelectionChanged(TextSelection selection, SelectionChangedCause? cause) {
    final bool willShowSelectionHandles = _shouldShowSelectionHandles(cause);

    if (willShowSelectionHandles != _showSelectionHandles) {
      setState(() {
        _showSelectionHandles = willShowSelectionHandles;
      });
    }

    if (cause == SelectionChangedCause.longPress) {
      _editableText?.bringIntoView(selection.extent);
    }
    if (cause == SelectionChangedCause.doubleTap) {
      _editableText?.bringIntoView(selection.extent);
    }
  }

  /// Toggle the toolbar when a selection handle is tapped.
  void _handleSelectionHandleTapped() {
    if (_effectiveController.selection.isCollapsed) {
      _editableText!.toggleToolbar();
    }
  }

  TextStyle _getTextStyle(EasyDevThemeData theme) {
    return _disabled
        ? _textStyle.copyWith(
            color: widget.decoration.disabledColor ??
                theme.inputTheme?.disabledColor ??
                (theme.brightness == Brightness.light
                    ? theme.colorPalette.greySwatch.disabledColor
                    : theme.colorPalette.greySwatch.tappedSurfaceColor),
          )
        : _textStyle;
  }

  bool _shouldShowSelectionHandles(SelectionChangedCause? cause) {
    if (!_selectionGestureDetectorBuilder.shouldShowSelectionToolbar) {
      return false;
    }

    if (cause == SelectionChangedCause.keyboard) {
      return false;
    }

    if (_effectiveController.selection.isCollapsed) {
      return false;
    }

    if (_disabled) {
      return false;
    }

    if (cause == SelectionChangedCause.longPress || cause == SelectionChangedCause.scribble) {
      return true;
    }

    if (_effectiveController.text.isNotEmpty) {
      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final TextEditingController controller = _effectiveController;
    final FocusNode focusNode = _effectiveFocusNode;
    final theme = context.easyDevTheme;

    Widget child = RepaintBoundary(
      child: UnmanagedRestorationScope(
        bucket: bucket,
        child: EditableText(
          scrollPhysics: widget.expandsWithNewLines ? const NeverScrollableScrollPhysics() : null,
          key: editableTextKey,
          onChanged: widget.valueChanged,
          controller: _effectiveController,
          readOnly: _disabled,
          focusNode: _effectiveFocusNode,
          undoController: widget.undoHistoryController,
          keyboardType: widget.textInputType,
          textAlign: widget.textAlign,
          textDirection: widget.textDirection,
          obscureText: widget.obscureText,
          maxLines: widget.maxLines ?? (widget.expandsWithNewLines ? null : 1),
          minLines: widget.minLines,
          expands: false,
          selectionColor: _effectiveFocusNode.hasFocus ? _selectionColor : null,
          inputFormatters: widget.inputFormatters,
          style: _getTextStyle(theme),
          cursorColor: _cursorColor,
          showCursor: widget.showCursor,
          backgroundCursorColor: _backgroundCursorColor,
          restorationId: 'editable',
          selectionControls: _EasyDevTextSelectionHandleControls(),
          contextMenuBuilder: widget.contextMenuBuilder,
          showSelectionHandles: _showSelectionHandles,
          onSelectionChanged: _handleSelectionChanged,
          onSelectionHandleTapped: _handleSelectionHandleTapped,
        ),
      ),
    );

    child = AnimatedBuilder(
      animation: Listenable.merge(<Listenable>[focusNode, controller]),
      builder: (BuildContext context, Widget? child) {
        return SizedBox(
          width: widget.decoration.minWidth,
          child: TextFieldDecorator(
            decoration: widget.decoration,
            inputState: _isFilled ? InputState.filled : widget.inputState,
            showTextLength: widget.showTextLength,
            leadingIcon: widget.leadingIcon,
            trailingIcon: _effectiveFocusNode.hasFocus
                ? (widget.focusedTrailingIcon ?? widget.trailingIcon)
                : widget.trailingIcon,
            prefixText: widget.prefixText,
            suffixText: widget.suffixText,
            linkWidget: widget.linkWidget,
            label: widget.label,
            helperText: widget.helperText,
            helperTrailingIcon: widget.helperTrailingIcon,
            hint: widget.hint,
            error: widget.error,
            successText: widget.successText,
            loadingText: widget.loadingText,
            textDirection: widget.textDirection,
            hasFocus: _effectiveFocusNode.hasFocus,
            maxLength: widget.maxLength,
            text: _effectiveController.value.text,
            inputStyle: _textStyle,
            maxLines: widget.maxLines ?? 1,
            minLines: widget.minLines,
            alignment: widget.alignment,
            expandsWithNewLines: widget.expandsWithNewLines,
            child: child ?? const SizedBox(),
          ),
        );
      },
      child: child,
    );

    return TextFieldTapRegion(
      onTapInside: (_) {
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      child: IgnorePointer(
        ignoring: _disabled,
        child: AnimatedBuilder(
          animation: controller, // changes the _currentLength
          builder: (BuildContext context, Widget? child) {
            return child ?? const SizedBox();
          },
          child: _selectionGestureDetectorBuilder.buildGestureDetector(
            behavior: HitTestBehavior.translucent,
            child: child,
          ),
        ),
      ),
    );
  }

  bool get _isFilled {
    return widget.inputState == InputState.enabled
        ? !_effectiveFocusNode.hasFocus && _effectiveController.text.isNotEmpty
        : false;
  }
}

class _EasyDevTextFieldSelectionGestureDetectorBuilder extends TextSelectionGestureDetectorBuilder {
  _EasyDevTextFieldSelectionGestureDetectorBuilder({
    required _EasyDevTextFieldState state,
  })  : _state = state,
        super(delegate: state);

  final _EasyDevTextFieldState _state;

  @override
  void onForcePressStart(ForcePressDetails details) {
    super.onForcePressStart(details);
    if (delegate.selectionEnabled && shouldShowSelectionToolbar) {
      editableText.showToolbar();
    }
  }

  @override
  void onForcePressEnd(ForcePressDetails details) {
    // Not required.
  }

  @override
  void onSingleTapUp(TapDragUpDetails details) {
    super.onSingleTapUp(details);
    _state._requestKeyboard();
  }

  @override
  void onSingleLongTapStart(LongPressStartDetails details) {
    super.onSingleLongTapStart(details);
    if (delegate.selectionEnabled) {
      if (Platform.isAndroid || Platform.isFuchsia) {
        HapticFeedback.vibrate();
      }
    }
  }
}

class _EasyDevTextSelectionHandleControls extends TextSelectionControls
    with TextSelectionHandleControls {
  final double width = 22;
  final double height = 22;

  @override
  Widget buildHandle(BuildContext context, TextSelectionHandleType type, double textLineHeight,
      [VoidCallback? onTap]) {
    final theme = context.easyDevTheme;
    final color =
        theme.colorPalette.secondarySwatch?[500] ?? theme.colorPalette.greySwatch.onSurfaceColor;

    final handle = SizedBox(
      height: width,
      width: height,
      child: CustomPaint(
        painter: _EasyDevTextSelectionHandlePainter(color: color),
        child: GestureDetector(
          onTap: onTap,
          behavior: HitTestBehavior.translucent,
        ),
      ),
    );

    return switch (type) {
      TextSelectionHandleType.left => // points up-right
        Transform.rotate(
          angle: pi / 2.0,
          child: handle,
        ),
      TextSelectionHandleType.right => // points up-left
        handle,
      TextSelectionHandleType.collapsed => // points up
        Transform.rotate(
          angle: pi / 4.0,
          child: handle,
        )
    };
  }

  @override
  Offset getHandleAnchor(TextSelectionHandleType type, double textLineHeight) {
    switch (type) {
      case TextSelectionHandleType.left:
        return Offset(width, 0);
      case TextSelectionHandleType.right:
        return Offset.zero;
      case TextSelectionHandleType.collapsed:
        return Offset(width / 2, -4);
    }
  }

  @override
  Size getHandleSize(double textLineHeight) {
    return Size(width, height);
  }
}

class _EasyDevTextSelectionHandlePainter extends CustomPainter {
  _EasyDevTextSelectionHandlePainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = color;
    final double radius = size.width / 2.0;
    final Rect circle = Rect.fromCircle(center: Offset(radius, radius), radius: radius);
    final Rect point = Rect.fromLTWH(0.0, 0.0, radius, radius);
    final Path path = Path()
      ..addOval(circle)
      ..addRect(point);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _EasyDevTextSelectionHandlePainter oldDelegate) {
    return color != oldDelegate.color;
  }
}
