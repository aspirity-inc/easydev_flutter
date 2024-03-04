import 'dart:math';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:easydev_base_ui/easydev_base_ui.dart';
import 'package:easydev_basics/easydev_basics.dart';
import 'package:easydev_forms/easydev_forms.dart';
import 'package:easydev_forms/src/widgets/easydev_select/easydev_select_decoration.dart';
import 'package:easydev_forms/src/widgets/easydev_select/easydev_select_decoration_widget.dart';
import 'package:easydev_forms/src/widgets/easydev_select/easydev_select_overlay.dart';
import 'package:easydev_forms/src/widgets/easydev_select/select_info_widget.dart';
import 'package:easydev_forms/src/widgets/easydev_select/select_widget.dart';
import 'select_bottom_sheet_content.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';

/// [EasyDevSelect] widget allows user to select one value from certain set of values.
/// If there are no selected value [hint] will appear, if there are selected value, value will
/// try to use [EasyDevSelectItem] name property, or use it's value.
/// [EasyDevSelect] can be disabled, so it will not interact on user actions.
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
/// EasyDevSelect(
///    value: 'apple',
///    onSelected: (String value) {
///    ...
///    },
///    values: ['apple','banana','orange'],
///    bottomSheetTitle: 'Select fruit',
/// ),
/// ```
///
///
/// This sample shows app with [EasyDevSelect].
///
/// See code in example/lib/pages/examples/select_example.dart
/// See also:
///
///  * [EasyDevMultiSelect], widget for selecting multiple values.
class EasyDevSelect<T> extends StatefulWidget {
  const EasyDevSelect({
    super.key,
    required this.selectedValue,
    required this.values,
    required this.onSelected,
    required this.hint,
    this.enabled = true,
    this.withBottomSheet = false,
    this.icon,
    this.activeIcon,
    this.borderRadius,
    this.backgroundColor,
    this.tappedColor,
    this.dividerColor,
    this.barrierColor,
    this.disabledBorderColor,
    this.activeBorderColor,
    this.borderColor,
    this.iconColor,
    this.maxHeight,
    this.itemPadding,
    this.textStyle,
    this.textColor,
    this.disabledTextColor,
    this.unselectedTextColor,
    this.selectedTextColor,
    this.tappedTextColor,
    this.confirmAction,
    this.bottomSheetTitle,
    this.bottomSheetTitleStyle,
  }) : assert(values.length != 0, 'You should provide value to EasyDevSelect widget');

  /// Selected value of widget.
  final T? selectedValue;

  /// List of [EasyDevSelectItem] that are shown in overlay or [EasyDevBottomSheet].
  final List<EasyDevSelectItem<T>> values;

  /// Callback on value selected.
  final ValueChanged<T?> onSelected;

  /// Hint that shown in select when [selectedValue] is null or shown in bottom sheet
  /// when there [bottomSheetTitle] is null.
  final String hint;

  /// When widgets is not [enabled] widget do not react when pressed on it.
  final bool enabled;

  /// If true on widget tap it will show [EasyDevBottomSheet] containing list of [values],
  /// if false it will use [OverlayEntry] for displaying this list.
  final bool withBottomSheet;

  /// Icon that overrides icon when widget is not active.
  final IconData? icon;

  /// Icon that overrides icon when widget is active.
  final IconData? activeIcon;

  /// BorderRadius select widget.
  final BorderRadius? borderRadius;

  /// Background color of widget.
  final Color? backgroundColor;

  /// Color on widget tap.
  final Color? tappedColor;

  /// Color of dividers in [OverlayEntry] and [EasyDevBottomSheet].
  final Color? dividerColor;

  /// Color of barrier in [EasyDevBottomSheet].
  final Color? barrierColor;

  /// Color of border in active state.
  final Color? activeBorderColor;

  /// Color of border in inactive state.
  final Color? borderColor;

  /// Color of border when widget is not [enabled].
  final Color? disabledBorderColor;

  /// Color of icons when widget is enabled.
  final Color? iconColor;

  /// Max height of [OverlayEntry] and [EasyDevBottomSheet].
  final double? maxHeight;

  /// [EdgeInsets] of select widget and [EasyDevSelectItem].
  final EdgeInsets? itemPadding;

  /// [TextStyle] of select widget.
  final TextStyle? textStyle;

  /// [TextStyle] of bottomSheetTitle.
  final TextStyle? bottomSheetTitleStyle;

  /// [Color] of text of select widget.
  final Color? textColor;

  /// [Color] of [EasyDevSelectItem] when it is enabled.
  final Color? unselectedTextColor;

  /// [Color] of [EasyDevSelectItem] when it is selected.
  final Color? selectedTextColor;

  /// [Color] of select widget and [EasyDevSelectItem] text.
  final Color? disabledTextColor;

  /// [Color] of text when tapped on it.
  final Color? tappedTextColor;

  /// Text of [EasyDevButton] in [EasyDevBottomSheet].
  final String? confirmAction;

  /// Title of [EasyDevBottomSheet].
  final String? bottomSheetTitle;

  @override
  State<EasyDevSelect<T>> createState() => _EasyDevSelectState<T>();
}

class _EasyDevSelectState<T> extends State<EasyDevSelect<T>> {
  OverlayEntry? _overlayEntry;
  bool active = false;

  late BorderRadius _borderRadius;
  late Color _backgroundColor;
  late Color _tappedColor;
  late Color _disabledBorderColor;
  late Color _dividerColor;
  late Color _barrierColor;
  late Color _activeBorderColor;
  late Color _borderColor;
  late Color _iconColor;
  late Color _scrollbarColor;
  late EdgeInsets _itemPadding;
  late TextStyle _textStyle;
  late TextStyle _bottomSheetTitleStyle;
  late Color _textColor;
  late Color _unselectedTextColor;
  late Color _selectedTextColor;
  late Color _disabledTextColor;
  late Color _tappedTextColor;

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
    final selectTheme = theme.selectTheme;
    final greySwatch = theme.colorPalette.greySwatch;
    final light = theme.brightness == Brightness.light;

    _borderRadius = widget.borderRadius ??
        selectTheme?.borderRadius ??
        const BorderRadius.all(
          Radius.circular(8),
        );
    _backgroundColor = widget.backgroundColor ??
        selectTheme?.backgroundColor ??
        greySwatch.backgroundColor ??
        greySwatch.surfaceColor;
    _tappedColor = widget.tappedColor ??
        selectTheme?.tappedColor ??
        (light
            ? (theme.colorPalette.tertiarySwatch?[50] ?? theme.colorPalette.primarySwatch)
            : (theme.colorPalette.tertiarySwatch?[400] ??
                theme.colorPalette.tertiarySwatch ??
                theme.colorPalette.primarySwatch));
    _disabledBorderColor = widget.disabledBorderColor ??
        selectTheme?.disabledBorderColor ??
        (light ? (greySwatch.disabledColor ?? greySwatch.greyColor) : greySwatch.greyColor);
    _dividerColor = widget.dividerColor ??
        selectTheme?.dividerColor ??
        (theme.colorPalette.secondarySwatch?[600] ??
            theme.colorPalette.secondarySwatch ??
            theme.colorPalette.primarySwatch);
    _barrierColor = widget.barrierColor ??
        (light
            ? const Color(0x6B000000)
            : (theme.colorPalette.secondarySwatch?[400]?.withOpacity(0.42) ??
                const Color(0x6BFFFFFF)));
    _activeBorderColor = widget.activeBorderColor ??
        selectTheme?.activeBorderColor ??
        (light
            ? (greySwatch.disabledColor ?? greySwatch.greyColor)
            : theme.colorPalette.secondarySwatch?[400] ??
                theme.colorPalette.secondarySwatch ??
                theme.colorPalette.primarySwatch);
    _borderColor = widget.borderColor ??
        selectTheme?.borderColor ??
        (light
            ? (greySwatch.unselectedColor ?? greySwatch.greyColor)
            : theme.colorPalette.secondarySwatch?[50] ?? greySwatch.greyColor);
    _iconColor = widget.iconColor ??
        (light
            ? greySwatch.onSurfaceColor
            : theme.colorPalette.secondarySwatch?[300] ??
                theme.colorPalette.secondarySwatch ??
                theme.colorPalette.primarySwatch);
    _itemPadding = widget.itemPadding ?? selectTheme?.itemPadding ?? const EdgeInsets.all(16);
    _textStyle = widget.textStyle ??
        selectTheme?.textStyle ??
        theme.typography?.body1Style ??
        const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 18,
        );
    _textColor = widget.textColor ??
        selectTheme?.textColor ??
        (light
            ? (greySwatch.onSurfaceBright ?? greySwatch.onSurfaceColor)
            : (greySwatch.onSurfaceColor));
    _unselectedTextColor = widget.unselectedTextColor ??
        selectTheme?.unselectedTextColor ??
        (light
            ? (greySwatch.onSurfaceBright ?? greySwatch.onSurfaceColor)
            : (greySwatch.unselectedColor ?? greySwatch.greyColor));
    _selectedTextColor = widget.selectedTextColor ??
        selectTheme?.selectedTextColor ??
        theme.colorPalette.primarySwatch;
    _disabledTextColor = widget.disabledTextColor ??
        selectTheme?.disabledTextColor ??
        (light
            ? (greySwatch.disabledColor ?? greySwatch.greyColor)
            : greySwatch.tappedSurfaceColor ?? greySwatch.greyColor);
    _tappedTextColor = widget.tappedTextColor ??
        selectTheme?.tappedTextColor ??
        theme.colorPalette.tertiarySwatch?[900] ??
        greySwatch.onSurfaceBright ??
        greySwatch.onSurfaceColor;
    _bottomSheetTitleStyle = widget.bottomSheetTitleStyle ??
        selectTheme?.bottomSheetTitleStyle ??
        theme.typography?.heading3Style?.copyWith(
          color: _textColor,
        ) ??
        TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: (light ? _textColor : theme.colorPalette.tertiarySwatch?[50] ?? _textColor),
        );
    _scrollbarColor = selectTheme?.scrollbarColor ??
        (light
            ? (theme.colorPalette.greySwatch.unselectedColor ??
                theme.colorPalette.greySwatch.onSurfaceColor)
            : theme.colorPalette.secondarySwatch ?? theme.colorPalette.primarySwatch);
  }

  void _showOverlay(EasyDevSelectDecoration decoration) {
    setState(() {
      active = true;
    });
    final NavigatorState navigator = Navigator.of(context);
    assert(_overlayEntry == null);
    final RenderBox itemBox = context.findRenderObject()! as RenderBox;
    final Rect itemRect = itemBox.localToGlobal(
          Offset.zero,
          ancestor: navigator.context.findRenderObject(),
        ) &
        itemBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return EasyDevSelectDecorationWidget(
          decoration: decoration,
          child: SelectInfoWidget(
            selectedValue: widget.selectedValue,
            onValueChanged: (value) {
              widget.onSelected(value);
              _overlayEntry?.remove();

              _overlayEntry = null;
              setState(() {
                active = false;
              });
            },
            child: SelectOverlayContent(
              onTap: () {
                _overlayEntry?.remove();

                _overlayEntry = null;
                setState(() {
                  active = false;
                });
              },
              maxHeight: widget.maxHeight,
              decoration: decoration,
              itemRect: itemRect,
              values: widget.values,
            ),
          ),
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _showBottomSheet(EasyDevSelectDecoration decoration) async {
    final RenderBox itemBox = context.findRenderObject()! as RenderBox;
    final Rect itemRect = itemBox.localToGlobal(
          Offset.zero,
          ancestor: Navigator.of(context).context.findRenderObject(),
        ) &
        itemBox.size;

    final mediaQueryHeight = MediaQuery.of(context).size.height;

    final height = widget.maxHeight ?? max(mediaQueryHeight - itemRect.top, mediaQueryHeight * 0.5);

    setState(() {
      active = true;
    });
    final result = await showEasyDevBottomSheet(
      context: context,
      barrierDismissible: true,
      barrierColor: _barrierColor,
      builder: (context) => EasyDevBottomSheet(
        maxHeight: height,
        child: SelectBottomSheetContent(
          selectedValue: widget.selectedValue,
          decoration: decoration,
          values: widget.values,
          maxHeight: height,
          action: widget.confirmAction ?? 'Confirm',
          titleStyle: _bottomSheetTitleStyle,
          title: widget.bottomSheetTitle ?? widget.hint,
        ),
      ),
    );
    if (result is T) {
      widget.onSelected(result);
    }
    setState(() {
      active = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final decoration = EasyDevSelectDecoration(
      borderRadius: _borderRadius,
      backgroundColor: _backgroundColor,
      tappedColor: _tappedColor,
      disabledColor: _disabledBorderColor,
      dividerColor: _dividerColor,
      activeBorderColor: _activeBorderColor,
      borderColor: _borderColor,
      scrollbarColor: _scrollbarColor,
      iconColor: _iconColor,
      itemPadding: _itemPadding,
      textColor: _textColor,
      unselectedTextColor: _unselectedTextColor,
      selectedTextColor: _selectedTextColor,
      disabledTextColor: _disabledTextColor,
      tappedTextColor: _tappedTextColor,
      textStyle: _textStyle,
      barrierColor: _barrierColor,
    );

    return SelectWidget(
      icon: (active
          ? (widget.activeIcon ?? CommunityMaterialIcons.menu_up)
          : widget.icon ?? CommunityMaterialIcons.menu_down),
      item: widget.values.map((e) => e.value).contains(widget.selectedValue)
          ? widget.values.firstWhere((element) => element.value == widget.selectedValue)
          : null,
      hint: widget.hint,
      enabled: widget.enabled,
      active: active,
      onTap: () => widget.withBottomSheet ? _showBottomSheet(decoration) : _showOverlay(decoration),
      decoration: decoration,
    );
  }

  @override
  Future<void> dispose() async {
    _overlayEntry?.dispose();
    super.dispose();
  }
}
