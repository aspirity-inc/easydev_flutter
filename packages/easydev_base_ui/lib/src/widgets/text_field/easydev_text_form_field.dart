import 'package:easydev_base_ui/src/widgets/icon_button/easydev_icon_button.dart';
import 'package:easydev_base_ui/src/widgets/text_field/easydev_input_decoration.dart';
import 'package:easydev_base_ui/src/widgets/text_field/easydev_text_field.dart';
import 'package:easydev_base_ui/src/widgets/text_field/enums/input_state.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// {@macro easudev_base_ui.lib.widgets.text_field.easudev_text_field}
/// [EasyDevTextFormField] has [value] that can be used as an initial vlaue of text field.
///
///
/// Example of using [EasyDevTextFormField].
/// ```dart
/// EasyDevTextFormField(
///   hint: 'Input',
///   value: 'Initial text',
///   valueChanged: (value) {
///     // Add your valueChanged code here!
///   }
/// ),
/// ```
///
///
/// This sample produces variant of EasyDevTextFormField.
///
/// See code in easydev_base_ui/example/lib/dartpad_examples/easydev_text_form_field_example.dart
class EasyDevTextFormField extends FormField<String> {
  EasyDevTextFormField({
    super.key,
    super.restorationId,
    this.valueChanged,
    this.value,
    this.label,
    this.helperText,
    this.helperTrailingIcon,
    this.hint,
    this.error,
    this.trailingIcon,
    this.leadingIcon,
    this.prefixText,
    this.suffixText,
    this.linkWidget,
    this.controller,
    this.undoHistoryController,
    this.inputFormatters,
    this.focusNode,
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
    this.onTap,
    TextInputType? textInputType,
  })  : assert(value == null || controller == null),
        assert(showTextLength == false || linkWidget == null,
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
        assert(!obscureText || maxLines == 1, 'Obscured fields cannot be multiline.'),
        textInputType =
            textInputType ?? (maxLines == 1 ? TextInputType.text : TextInputType.multiline),
        super(
          initialValue: controller != null ? controller.text : (value ?? ''),
          enabled: inputState != InputState.disabled,
          autovalidateMode: AutovalidateMode.disabled,
          builder: (FormFieldState<String> field) {
            final _TextFormFieldState state = field as _TextFormFieldState;
            void onChangedHandler(String value) {
              field.didChange(value);
              if (valueChanged != null) {
                valueChanged(value);
              }
            }

            return UnmanagedRestorationScope(
              bucket: field.bucket,
              child: EasyDevTextField(
                valueChanged: onChangedHandler,
                restorationId: restorationId,
                controller: state._effectiveController,
                focusNode: focusNode,
                decoration: decoration,
                textInputType: textInputType,
                label: label,
                helperText: helperText,
                helperTrailingIcon: helperTrailingIcon,
                hint: hint,
                textAlign: textAlign,
                error: error,
                trailingIcon: trailingIcon,
                leadingIcon: leadingIcon,
                prefixText: prefixText,
                suffixText: suffixText,
                linkWidget: linkWidget,
                undoHistoryController: undoHistoryController,
                inputFormatters: inputFormatters,
                minLines: minLines,
                alignment: alignment,
                inputState: inputState,
                textDirection: textDirection,
                obscureText: obscureText,
                showTextLength: showTextLength,
                maxLines: maxLines,
                maxLength: maxLength,
                expandsWithNewLines: expandsWithNewLines,
                onTap: onTap,
              ),
            );
          },
        );

  /// Provides initial [value] for text field.
  final String? value;

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
  /// Best use case of using [EasyDevInputDecoration.alwaysShowHint] is by using it with input formatters.
  final String? hint;

  /// {@macro easydev_base_ui.widgets.text_field.enums.input_state}
  /// Error text is shown instead of [helperText] when [inputState] is [InputState.error].
  final String? error;

  /// {@macro easydev_base_ui.widgets.text_field.enums.input_state}
  /// [InputState] enum provides you room for customization, when you need
  /// to implement different text field use cases. They have different
  /// customisation.
  /// [InputState.enabled] is focusable text field.
  /// [InputState.disabled] disables text field.
  /// [InputState.error] show [error] instead of [helperText] when [error] is provided.
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

  /// [trailingIcon] is positioned inside of text field, before text input and
  /// provides ability to add icon button.
  final EasyDevIconButton? trailingIcon;

  /// [trailingIcon] is positioned inside of text field, after text input and
  /// provides ability to add icon button.
  final EasyDevIconButton? leadingIcon;

  /// [prefixText] is positioned on same vertical level as text input
  /// and positioned before text input, but without any paddings.
  final Widget? prefixText;

  /// [prefixText] is positioned on same vertical level as text input
  /// and positioned after text input.
  final Widget? suffixText;

  /// [linkWidget] is widget positioned under text input.
  /// The best usecase for this widget is "forgot password?" text button.
  final Widget? linkWidget;

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

  /// {@macro flutter.widgets.editable_text.textEditingController}
  /// Controls the text being edited.
  ///
  /// If null, this widget will create its own [TextEditingController].
  final TextEditingController? controller;

  /// Provides callback on widget tapped.
  final VoidCallback? onTap;

  @override
  FormFieldState<String> createState() => _TextFormFieldState();
}

class _TextFormFieldState extends FormFieldState<String> {
  RestorableTextEditingController? _controller;

  TextEditingController get _effectiveController => _textFormField.controller ?? _controller!.value;

  EasyDevTextFormField get _textFormField => super.widget as EasyDevTextFormField;

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    super.restoreState(oldBucket, initialRestore);
    if (_controller != null) {
      _registerController();
    }
    // Make sure to update the internal [FormFieldState] value to sync up with
    // text editing controller value.
    setValue(_effectiveController.text);
  }

  void _registerController() {
    assert(_controller != null);
    registerForRestoration(_controller!, 'controller');
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

  @override
  void initState() {
    super.initState();
    if (_textFormField.controller == null) {
      _createLocalController(
          widget.initialValue != null ? TextEditingValue(text: widget.initialValue!) : null);
    } else {
      _textFormField.controller!.addListener(_handleControllerChanged);
    }
  }

  @override
  void didUpdateWidget(EasyDevTextFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_textFormField.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      _textFormField.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && _textFormField.controller == null) {
        _createLocalController(oldWidget.controller!.value);
      }

      if (_textFormField.controller != null) {
        setValue(_textFormField.controller!.text);
        if (oldWidget.controller == null) {
          unregisterFromRestoration(_controller!);
          _controller!.dispose();
          _controller = null;
        }
      }
    }
  }

  @override
  void dispose() {
    _textFormField.controller?.removeListener(_handleControllerChanged);
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didChange(String? value) {
    super.didChange(value);

    if (_effectiveController.text != value) {
      _effectiveController.text = value ?? '';
    }
  }

  @override
  void reset() {
    // setState will be called in the superclass, so even though state is being
    // manipulated, no setState call is needed here.
    _effectiveController.text = widget.initialValue ?? '';
    super.reset();
  }

  void _handleControllerChanged() {
    // Suppress changes that originated from within this class.
    //
    // In the case where a controller has been passed in to this widget, we
    // register this change listener. In these cases, we'll also receive change
    // notifications for changes originating from within this class -- for
    // example, the reset() method. In such cases, the FormField value will
    // already have been set.
    if (_effectiveController.text != value) {
      didChange(_effectiveController.text);
    }
  }
}
