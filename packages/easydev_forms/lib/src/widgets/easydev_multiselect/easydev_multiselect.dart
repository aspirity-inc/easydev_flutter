import 'package:community_material_icon/community_material_icon.dart';
import 'package:easydev_forms/src/widgets/easydev_multiselect/easydev_multiselect_chip.dart';
import 'package:easydev_forms/src/widgets/easydev_multiselect/easydev_multiselect_item.dart';
import 'package:easydev_forms/src/widgets/easydev_multiselect/multiselect_decoration.dart';
import 'package:easydev_forms/src/widgets/easydev_multiselect/multiselect_widget.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';

/// [EasyDevMultiSelect] widget allows user to select multiple values from certain set of values.
/// If there are no selected value [hint] will appear, if there are selected value, value will
/// try to use [selectedItemHint] property.
/// [EasyDevMultiSelect] can be disabled, so it will not interact on user actions.
/// If [addClearButton] is true, after selecting at least one element
/// "Clear all" button will appear, that on tap return [valuesChanged] callback with
/// empty list. It's text can be changed by providing [clearButtonText].
/// [EasyDevSelect] when pressed shows lists of selectable values. It can be done using
/// [OverlayEntry] or [EasyDevBottomSheet], it depends on [withBottomSheet] property.
/// [icon] property have icon when [EasyDevSelect] is not active, that changes on [activeIcon] when
/// state is active. Active state is achieved by opening either overlay or bottom sheet.
///
/// Example of using [EasyDevSelect] that calls bottom sheet on tap
/// ```dart
/// EasyDevSelect(
///    value: 'apple',
///    onSelected: (String value) {
///    ...
///    },
///    values: ['apple','banana','orange'],
///    withBottomSheet: true,
/// ),
/// ```
///
/// Example of using [EasyDevSelect] that calls overlay on tap.
/// ```dart
/// EasyDevMultiSelect(
///    onSelected: (String value) {
///    ...
///    },
///    selectedValues: ["apple"],
///    values: [
///       EasyDevMultiselectItem(
///         value: "orange",
///        ),
///       EasyDevMultiselectItem(
///         value: "apple",
///        ),
///       EasyDevMultiselectItem(
///         value: "banana",
///        ),
///    ],
///    bottomSheetTitle: 'Select fruit',
/// ),
/// ```
///
///
///
/// This sample shows app with [EasyDevMultiSelect].
///
/// See code in example/lib/pages/examples/multiselect_example.dart
/// See also:
///
///  * [EasyDevSelect], widget for selecting single value.
class EasyDevMultiSelect<T> extends StatefulWidget {
  const EasyDevMultiSelect({
    super.key,
    required this.valuesChanged,
    required this.items,
    required this.selectedValues,
    this.enabled = true,
    this.withBottomSheet = false,
    this.addClearButton = true,
    this.hint,
    this.selectedItemHint,
    this.borderRadius,
    this.maxHeight,
    this.backgroundColor,
    this.selectedColor,
    this.dividerColor,
    this.barrierColor,
    this.disabledColor,
    this.iconColor,
    this.icon,
    this.activeIcon,
    this.itemPadding,
    this.chipsPadding,
    this.chipsSpacing,
    this.chipsRadius,
    this.chipsColor,
    this.scrollbarColor,
    this.tappedChipsColor,
    this.disabledChipsColor,
    this.chipsIconColor,
    this.onChipsColor,
    this.textColor,
    this.selectedTextColor,
    this.disabledTextColor,
    this.textStyle,
    this.bottomSheetTitleStyle,
    this.clearButtonText,
    this.bottomSheetTitle,
    this.confirmAction,
    this.chipsIcon,
  }) : assert(items.length != 0, 'Items should be not empty');

  /// Callback on values changed.
  final ValueChanged<List<T>> valuesChanged;

  /// List of [EasyDevMultiselectItem] that are shown in overlay or [EasyDevBottomSheet].
  final List<EasyDevMultiselectItem> items;

  /// Selected values of widget.
  final List<T> selectedValues;

  /// When [EasyDevMultiSelect] is not [enabled] widget do not react when pressed on it.
  final bool enabled;

  /// If true on widget tap it will show [EasyDevBottomSheet] containing list of [items],
  /// if false it will use [OverlayEntry] for displaying this list.
  final bool withBottomSheet;

  /// If true add button what on press call [valuesChanged] with empty list.
  final bool addClearButton;

  /// Hint that shown in select when [selectedValues] is empty or shown in bottom sheet
  /// when there [bottomSheetTitle] is null.
  final String? hint;

  /// Hint that shown in select when [selectedValues] is not empty.
  final String? selectedItemHint;

  /// BorderRadius select widget.
  final BorderRadius? borderRadius;

  /// Max height of [OverlayEntry] and [EasyDevBottomSheet].
  final double? maxHeight;

  /// Background color of widget.
  final Color? backgroundColor;

  /// Color of selected widget in overlay or bottom sheet.
  final Color? selectedColor;

  /// Color of dividers in [OverlayEntry] and [EasyDevBottomSheet].
  final Color? dividerColor;

  /// Color of barrier in [EasyDevBottomSheet].
  final Color? barrierColor;

  /// Color of disabled widget.
  final Color? disabledColor;

  /// Color of icons when widget is enabled.
  final Color? iconColor;

  /// Icon that overrides icon when widget is not active.
  final IconData? icon;

  /// Icon that overrides icon when widget is active.
  final IconData? activeIcon;

  /// [EdgeInsets] of select widget and [EasyDevMultiselectItem].
  final EdgeInsets? itemPadding;

  /// Padding of [EasyDevMultiselectChip].
  final EdgeInsets? chipsPadding;

  /// [Color] vertical and horizontal spacing between [EasyDevMultiselectChip]s.
  final double? chipsSpacing;

  /// [BorderRadius] of [EasyDevMultiselectChip]s.
  final BorderRadius? chipsRadius;

  /// [Color] of scrollbar.
  final Color? scrollbarColor;

  /// [Color] of chips.
  final Color? chipsColor;

  /// [Color] on [EasyDevMultiselectChip]s tap.
  final Color? tappedChipsColor;

  /// [Color] of disabled [EasyDevMultiselectChip]s.
  final Color? disabledChipsColor;

  /// [Color] of icons in [EasyDevMultiselectChip]s.
  final Color? chipsIconColor;

  /// [Color] of text in [EasyDevMultiselectChip]s.
  final Color? onChipsColor;

  /// [Color] of text on [EasyDevMultiselectWidget].
  final Color? textColor;

  /// [Color] of text when it is selected.
  final Color? selectedTextColor;

  /// [Color] of text in disabled widget.
  final Color? disabledTextColor;

  /// [TextStyle] of widget, is copied with [textColor],[selectedTextColor],[disabledTextColor] or
  /// [onChipsColor].
  final TextStyle? textStyle;

  /// [TextStyle] of bottomSheetTitle.
  final TextStyle? bottomSheetTitleStyle;

  /// Text of button what resets all selected value.
  final String? clearButtonText;

  /// Text of [EasyDevButton] in [EasyDevBottomSheet].
  final String? confirmAction;

  /// Title of [EasyDevBottomSheet].
  final String? bottomSheetTitle;

  /// Icon in [EasyDevMultiselectChip] widget.
  final IconData? chipsIcon;

  @override
  State<EasyDevMultiSelect<T>> createState() => _EasyDevMultiSelect<T>();
}

class _EasyDevMultiSelect<T> extends State<EasyDevMultiSelect<T>> {
  late BorderRadius _borderRadius;

  late Color _backgroundColor;

  late Color _selectedColor;

  late Color _dividerColor;

  late Color _disabledColor;

  late Color _iconColor;

  late EdgeInsets _itemPadding;

  late EdgeInsets _chipsPadding;

  late double _chipsSpacing;

  late BorderRadius _chipsRadius;

  late Color _scrollbarColor;

  late Color _chipsColor;

  late Color _tappedChipsColor;

  late Color _disabledChipsColor;

  late Color _chipsIconColor;

  late Color _textColor;

  late Color _selectedTextColor;

  late Color _disabledTextColor;

  late TextStyle _textStyle;

  late TextStyle _bottomSheetTitleStyle;

  late TextStyle _chipsTextStyle;

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
    final multiselectTheme = theme.multiselectTheme;
    final chipsTheme = theme.chipsThemeData;
    final greySwatch = theme.colorPalette.greySwatch;
    final light = theme.brightness == Brightness.light;

    _borderRadius = widget.borderRadius ??
        multiselectTheme?.borderRadius ??
        const BorderRadius.all(Radius.circular(8));
    _backgroundColor = widget.backgroundColor ??
        multiselectTheme?.backgroundColor ??
        (light
            ? greySwatch.surfaceColor
            : greySwatch.disabledColor ?? greySwatch.backgroundColor ?? greySwatch.surfaceColor);
    _selectedColor = widget.selectedColor ??
        multiselectTheme?.selectedColor ??
        (light
            ? _backgroundColor
            : theme.colorPalette.secondarySwatch ?? theme.colorPalette.primarySwatch);
    _dividerColor = widget.dividerColor ??
        multiselectTheme?.dividerColor ??
        (light ? greySwatch.greyColor : greySwatch.surfaceColor);
    _disabledColor = widget.disabledColor ??
        multiselectTheme?.disabledColor ??
        (light
            ? greySwatch.surfaceColor
            : greySwatch.tappedSurfaceColor ?? greySwatch.surfaceColor);
    _iconColor = widget.iconColor ??
        multiselectTheme?.iconColor ??
        theme.colorPalette.secondarySwatch?[300] ??
        theme.colorPalette.secondarySwatch ??
        theme.colorPalette.primarySwatch;
    _itemPadding = widget.itemPadding ??
        multiselectTheme?.itemPadding ??
        const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        );

    _scrollbarColor = widget.scrollbarColor ??
        multiselectTheme?.scrollbarColor ??
        (light
            ? (theme.colorPalette.greySwatch.unselectedColor ??
                theme.colorPalette.greySwatch.onSurfaceColor)
            : theme.colorPalette.tertiarySwatch ?? theme.colorPalette.primarySwatch);

    _textColor = widget.textColor ??
        multiselectTheme?.textColor ??
        (light
            ? (greySwatch.onSurfaceBright ?? greySwatch.onSurfaceColor)
            : greySwatch.dividerColor ?? greySwatch.onSurfaceColor);
    _selectedTextColor = widget.selectedTextColor ??
        multiselectTheme?.selectedTextColor ??
        (light
            ? greySwatch.onSurfaceBright ?? greySwatch.onSurfaceColor
            : greySwatch.dividerColor ?? greySwatch.onSurfaceColor);
    _disabledTextColor = widget.disabledTextColor ??
        multiselectTheme?.disabledTextColor ??
        (light ? (greySwatch.unselectedColor ?? greySwatch.greyColor) : greySwatch.greyColor);
    _textStyle = widget.textStyle ??
        multiselectTheme?.textStyle ??
        theme.typography?.body1Style ??
        const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 18,
        );
    _bottomSheetTitleStyle = widget.bottomSheetTitleStyle ??
        multiselectTheme?.bottomSheetTitleStyle ??
        theme.typography?.heading4Style?.copyWith(
          color: _textColor,
          fontSize: 16,
        ) ??
        TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: (light ? _textColor : theme.colorPalette.tertiarySwatch?[50] ?? _textColor),
        );

    _chipsColor = widget.chipsColor ??
        chipsTheme?.color ??
        theme.colorPalette.secondarySwatch ??
        theme.colorPalette.primarySwatch;
    _tappedChipsColor = widget.chipsColor ??
        chipsTheme?.tappedColor ??
        (light
            ? (theme.colorPalette.secondarySwatch?[300] ??
                theme.colorPalette.secondarySwatch ??
                theme.colorPalette.primarySwatch)
            : theme.colorPalette.secondarySwatch?[400] ??
                theme.colorPalette.secondarySwatch ??
                theme.colorPalette.primarySwatch);
    _disabledChipsColor = widget.disabledChipsColor ??
        chipsTheme?.disabledColor ??
        (light
            ? (greySwatch.disabledColor ?? greySwatch.greyColor)
            : (greySwatch.tappedSurfaceColor ?? greySwatch.greyColor));
    _chipsIconColor = widget.chipsIconColor ??
        chipsTheme?.iconColor ??
        (light ? greySwatch.surfaceColor : _iconColor);
    _chipsPadding = widget.chipsPadding ??
        chipsTheme?.padding ??
        const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 20,
        );
    _chipsSpacing = widget.chipsSpacing ?? chipsTheme?.spacing ?? 8.0;

    _chipsRadius =
        widget.chipsRadius ?? chipsTheme?.radius ?? const BorderRadius.all(Radius.circular(53));

    _chipsTextStyle = chipsTheme?.textStyle ??
        _textStyle.copyWith(color: (light ? _backgroundColor : _selectedTextColor));
  }

  @override
  Widget build(BuildContext context) {
    final decoration = _getDecoration();
    final selectedItems = widget.items
        .where(
          (element) => widget.selectedValues.contains(element.value),
        )
        .toList();

    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        MultiselectWidget<T>(
          items: widget.items,
          valuesChanged: widget.valuesChanged,
          selectedValues: widget.selectedValues,
          icon: widget.icon ?? CommunityMaterialIcons.menu_down,
          activeIcon: widget.activeIcon ?? CommunityMaterialIcons.menu_up,
          itemsSelected: widget.selectedValues.isNotEmpty,
          hint: widget.hint ?? 'Select option',
          selectedItemHint:
              widget.selectedItemHint ?? 'Your choice: ${widget.selectedValues.length}',
          enabled: widget.enabled,
          decoration: decoration,
          withBottomSheet: widget.withBottomSheet,
          maxHeight: widget.maxHeight,
          bottomSheetTitle: widget.bottomSheetTitle,
          confirmAction: widget.confirmAction,
          barrierColor: widget.barrierColor,
        ),
        if (widget.addClearButton && widget.selectedValues.isNotEmpty) ...[
          SizedBox(
            height: _chipsSpacing + 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () => widget.valuesChanged([]),
                child: Text(
                  widget.clearButtonText ?? 'reset all',
                  style: _textStyle.copyWith(
                    color: _textColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
        ],
        if (widget.selectedValues.isNotEmpty) ...[
          ...List.generate(
            (selectedItems.length / 2).ceil(),
            (index) {
              return Padding(
                padding: EdgeInsets.only(top: _chipsSpacing),
                child: Row(
                  children: [
                    Expanded(
                      child: EasyDevMultiselectChip(
                        value: selectedItems[index * 2].value,
                        name: selectedItems[index * 2].name,
                        enabled: selectedItems[index * 2].enabled,
                        icon: widget.chipsIcon,
                        padding: _chipsPadding,
                        radius: _chipsRadius,
                        color: _chipsColor,
                        iconColor: _chipsIconColor,
                        style: _chipsTextStyle,
                        tappedColor: _tappedChipsColor,
                        disabledColor: _disabledChipsColor,
                        onDelete: (value) {
                          widget.valuesChanged(
                              widget.selectedValues.where((element) => element != value).toList());
                        },
                      ),
                    ),
                    SizedBox(
                      width: _chipsSpacing,
                    ),
                    if (index * 2 + 1 <= selectedItems.length - 1)
                      Expanded(
                        child: EasyDevMultiselectChip(
                          value: selectedItems[index * 2 + 1].value,
                          name: selectedItems[index * 2 + 1].name,
                          enabled: selectedItems[index * 2 + 1].enabled,
                          icon: widget.chipsIcon,
                          padding: _chipsPadding,
                          radius: _chipsRadius,
                          color: _chipsColor,
                          iconColor: _chipsIconColor,
                          style: _chipsTextStyle,
                          tappedColor: _tappedChipsColor,
                          disabledColor: _disabledChipsColor,
                          onDelete: (value) {
                            widget.valuesChanged(widget.selectedValues
                                .where((element) => element != value)
                                .toList());
                          },
                        ),
                      )
                    else
                      const Spacer(),
                  ],
                ),
              );
            },
          ),
          SizedBox(
            height: _chipsSpacing,
          ),
        ],
      ],
    );
  }

  MultiselectDecoration _getDecoration() {
    return MultiselectDecoration(
      borderRadius: _borderRadius,
      backgroundColor: _backgroundColor,
      selectedColor: _selectedColor,
      dividerColor: _dividerColor,
      disabledColor: _disabledColor,
      iconColor: _iconColor,
      itemPadding: _itemPadding,
      scrollbarColor: _scrollbarColor,
      textColor: _textColor,
      selectedTextColor: _selectedTextColor,
      disabledTextColor: _disabledTextColor,
      textStyle: _textStyle,
      bottomSheetTitleStyle: _bottomSheetTitleStyle,
    );
  }
}
