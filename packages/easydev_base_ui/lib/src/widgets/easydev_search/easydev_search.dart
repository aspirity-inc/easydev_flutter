import 'package:community_material_icon/community_material_icon.dart';
import 'package:easydev_base_ui/easydev_base_ui.dart';
import 'package:easydev_base_ui/src/widgets/easydev_search/search_option_list.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';

/// Callback for filtering options matching current value of text field.
typedef FilterOptions = bool Function(String value, EasyDevSearchOption option);

/// The [EasyDevSearch] widget enables the implementation of a searchable dropdown
/// component with customizable options. List of options of type [EasyDevSearchOption] must be provided.
/// The [onChanged] callback allows handling changes in input.
///
/// [EasyDevSearch] can be customized through various available fileds.
///
/// Note that [EasyDevSearch] must be placed to a widget
/// that provides constraints, because [EasyDevSearch] need to
/// correctly position list of [EasyDevSearchOption].
///
/// Example of using [EasyDevSearch].
/// ```dart
/// WidgetWithConstraints(
///   child: EasyDevSearch(
///     leadingIcon: const EasyDevIconButton(CommunityMaterialIcons.magnify, size: 24),
///     trailingIcon: const EasyDevIconButton(CommunityMaterialIcons.microphone, size: 24),
///     options: [
///       EasyDevSearchOption(value: 'First', onTap: (value) {}),
///       EasyDevSearchOption(value: 'Second', onTap: (value) {}),
///       EasyDevSearchOption(value: 'Third', onTap: (value) {}),
///       EasyDevSearchOption(value: 'Fourth', onTap: (value) {}),
///     ],
///   ),
/// ),
/// ```
///
///
/// This sample produces variant of EasyDevOnboarding.
///
/// See code in easydev_base_ui/example/lib/dartpad_examples/easydev_search_example.dart
class EasyDevSearch<T> extends StatefulWidget {
  /// Create EasyDevSearch.
  const EasyDevSearch({
    super.key,
    required this.options,
    this.separatedElements,
    this.optionsMaxHeight,
    this.onChanged,
    this.leadingIcon,
    this.trailingIcon,
    this.optionsColor,
    this.optionsTapColor,
    this.optionsTextStyle,
    this.optionsTapTextStyle,
    this.optionsHighlightTextStyle,
    this.decoration,
    this.margin,
    this.hint,
    this.filterOptions,
    this.notFoundText,
    this.dividerColor,
    this.optionsBuilder,
  });

  /// List of options to show in dropdown.
  final List<EasyDevSearchOption<T>> options;

  /// Whether elements should be separated with margin or it should placed in
  /// list of elements with dividers.
  final bool? separatedElements;

  /// Callback to be called when input is changed.
  final void Function(String value)? onChanged;

  /// Hint in text field
  final String? hint;

  /// Leading icon in text field.
  final EasyDevIconButton? leadingIcon;

  /// Trailing icon in text field.
  final EasyDevIconButton? trailingIcon;

  ///  Height of options list. Defaults to 216 in light theme and 248 in dark theme.
  final double? optionsMaxHeight;

  /// Background color of each option in suggestions dropdown.
  final Color? optionsColor;

  /// Background color of each option in suggestions dropdown when it is tapped.
  final Color? optionsTapColor;

  /// Color of divider when elements when [separatedElements] is set to false.
  final Color? dividerColor;

  /// Style of text in each option in suggestions dropdown.
  final TextStyle? optionsTextStyle;

  /// Style of text in each option in suggestions dropdown when it is tapped.
  final TextStyle? optionsTapTextStyle;

  /// Style of matching part in each option in suggestions dropdown.
  final TextStyle? optionsHighlightTextStyle;

  /// Decoration of text field widget.
  final EasyDevInputDecoration? decoration;

  /// Margin of text field widget.
  final EdgeInsets? margin;

  /// Callback whether option should be included in filtered options list
  final FilterOptions? filterOptions;

  /// Builder for providing custom options designs.
  final Widget Function(EasyDevSearchOption option)? optionsBuilder;

  /// Text that replaces "Not found" text, when provided.
  final String? notFoundText;

  @override
  State<EasyDevSearch<T>> createState() => _EasyDevSearchState();
}

class _EasyDevSearchState<T> extends State<EasyDevSearch<T>> {
  final FocusNode _focusNode = FocusNode();

  final TextEditingController _inputController = TextEditingController();

  late List<EasyDevSearchOption<T>> _options;

  @override
  void initState() {
    super.initState();

    _options = widget.options;

    _inputController.addListener(() {
      setState(() => _options = _filterOptions());
      if (widget.onChanged != null) widget.onChanged!(_inputController.text);
    });

    _focusNode.addListener(() {
      setState(() {});
    });
  }

  List<EasyDevSearchOption<T>> _filterOptions() {
    final inputValue = _inputController.text;

    if (inputValue.isEmpty) return widget.options;

    return widget.options.where((option) {
      if (inputValue.length > option.title.length) return false;
      if (widget.filterOptions != null) {
        widget.filterOptions!(inputValue, option);
      }
      return inputValue.toLowerCase() == option.title.substring(0, inputValue.length).toLowerCase();
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.easyDevTheme;
    final isLight = theme.brightness == Brightness.light;

    final isNothingFound = _options.isEmpty;
    final isInputInProgress = _inputController.text.isNotEmpty;
    final isInputFocused = _focusNode.hasFocus;

    return LayoutBuilder(builder: (context, constraints) {
      final RenderBox searchRenderBox = context.findRenderObject() as RenderBox;

      return RawAutocomplete<EasyDevSearchOption<T>>(
        optionsBuilder: (value) => _filterOptions(),
        fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) => EasyDevTextField(
          leadingIcon: isInputFocused || isInputInProgress ? null : widget.leadingIcon,
          controller: controller,
          focusNode: focusNode,
          decoration: widget.decoration ??
              EasyDevInputDecoration(
                margin: widget.margin,
                unfocusedColor: isLight
                    ? theme.colorPalette.greySwatch.unselectedColor
                    : theme.colorPalette.secondarySwatch?[50],
                filledColor: isLight
                    ? theme.colorPalette.greySwatch.unselectedColor
                    : theme.colorPalette.secondarySwatch?[50],
                iconColor: (theme.brightness == Brightness.light
                    ? theme.colorPalette.greySwatch.onSurfaceColor
                    : (theme.colorPalette.secondarySwatch?[300] ??
                        theme.colorPalette.secondarySwatch ??
                        theme.colorPalette.primarySwatch)),
              ),
          trailingIcon: isInputInProgress
              ? EasyDevIconButton(
                  CommunityMaterialIcons.close,
                  size: 24,
                  onTap: () => _inputController.clear(),
                )
              : widget.trailingIcon,
          hint: widget.hint,
          helperText: isNothingFound ? widget.notFoundText ?? 'Not found' : null,
        ),
        focusNode: _focusNode,
        textEditingController: _inputController,
        optionsViewBuilder: (context, onSelect, options) {
          return Builder(builder: (context) {
            final topPosition = searchRenderBox.localToGlobal(Offset.zero).dy;
            final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
            final screenHeight = MediaQuery.of(context).size.height;

            final availableSpace = screenHeight - keyboardHeight - 80;

            return SearchOptionsList(
              options: options,
              inputController: _inputController,
              focusNode: _focusNode,
              optionsColor: widget.optionsColor,
              optionsTapColor: widget.optionsTapColor,
              optionsTextStyle: widget.optionsTextStyle,
              optionsTapTextStyle: widget.optionsTapTextStyle,
              optionsHighlightTextStyle: widget.optionsHighlightTextStyle,
              dividerColor: widget.dividerColor,
              separatedElements: widget.separatedElements ?? theme.brightness == Brightness.dark,
              optionsHeight: widget.optionsMaxHeight ?? availableSpace - topPosition,
              margin: widget.margin,
              width: constraints.biggest.width,
              optionsBuilder: widget.optionsBuilder,
            );
          });
        },
      );
    });
  }
}
