import 'package:easydev_basics/src/widgets/easydev_bottom_navigation_bar/easydev_bottom_navigation_bar_item.dart';
import 'package:easydev_basics/src/widgets/easydev_bottom_navigation_bar/easydev_bottom_navigation_bar_wrapper.dart';
import 'package:flutter/widgets.dart';
import 'package:easydev_theme/easydev_theme.dart';

/// Bottom navigation bar is widget usually placed at bottom of screen. Best way to use it
/// is to pass it to [EasyDevScaffold.bottomNavigationBar] property.
/// Elements of [BottomNavigationBar] are passed as simple class [EasyDevBottomNavigationBarItem],
/// containing only label, icon and boolean field that can show circle indicator on top right
/// corner of icon. It can be used to notify users that something new in that tab.
/// [currentIndex] field is defining what tab is currently selected, and could not be less then
/// zero or larger that [items.length]. Logic of label appearance can be changed by passing
/// [showLabel] field.
///
/// This sample shows an [EasyDevBottomNavigationBar] with
/// 4 different [EasyDevBottomNavigationBarItem]s, with [ShowLabel.unselected].
///
/// See code in example/lib/pages/examples/bottom_navigation_bar/easy_dev_bottom_navigation_bar_example.dart
class EasyDevBottomNavigationBar extends StatefulWidget {
  /// Create a bottom navigation bar.
  const EasyDevBottomNavigationBar({
    super.key,
    required this.items,
    this.currentIndex,
    this.onItemTap,
    this.backgroundColor,
    this.selectedLabelTextStyle,
    this.unselectedLabelTextStyle,
    this.unselectedIconColor,
    this.selectedIconColor,
    this.unselectedLabelColor,
    this.selectedLabelColor,
    this.shadowColor,
    this.indicatorColor,
    this.showLabel,
    this.alignment,
    this.iconSize,
    this.padding,
    this.margin,
    this.radius,
    this.elevation,
  }) : assert(currentIndex == null || (currentIndex >= 0 && currentIndex < items.length));

  /// Items of EasyDevBottomNavigationBar, this is just simple classes containing data, their
  /// decoration is set in [EasyDevBottomNavigationBar] widget.
  final List<EasyDevBottomNavigationBarItem> items;

  /// Index of selected item.
  final int? currentIndex;

  /// Callback for tapping on item.
  final ValueChanged<int>? onItemTap;

  /// Background color of EasyDevBottomNavigationBar.
  final Color? backgroundColor;

  /// TextStyle of label of selected item.
  final TextStyle? selectedLabelTextStyle;

  /// TextStyle of label of unselected items.
  final TextStyle? unselectedLabelTextStyle;

  /// Color of icon of unselected items.
  final Color? unselectedIconColor;

  /// Color of icon of selected item.
  final Color? selectedIconColor;

  /// Color of label of unselected items.
  final Color? unselectedLabelColor;

  /// Color of label of selected item.
  final Color? selectedLabelColor;

  /// Color of shadow under EasyDevBottomNavigationBar.
  final Color? shadowColor;

  /// Color of indicator near the icon.
  final Color? indicatorColor;

  /// Show behavior of showing label. [ShowLabel.always] always show all labels,
  /// [ShowLabel.never] never shows any label. [ShowLabel.selected] show label only on
  /// selected item, [ShowLabel.unselected] only show label on unselected items. Only show
  /// label if they presented in [EasyDevBottomNavigationBarItem].
  final ShowLabel? showLabel;

  /// Alignment for items, defaults to [BottomNavigationBarItemAlignment.center].
  final BottomNavigationBarItemAlignment? alignment;

  /// Size of icons, defaults to 24.
  final double? iconSize;

  /// Padding of EasyDevBottomNavigationBar, Defaults to EdgeInsets.all(18).
  final EdgeInsets? padding;

  /// Margin of EasyDevBottomNavigationBar, Defaults to [EdgeInsets.zero].
  final EdgeInsets? margin;

  /// BorderRadius of [EasyDevBottomNavigationBar]. Defaults to BorderRadius.circular(48).
  final BorderRadius? radius;

  /// Elevation of [EasyDevBottomNavigationBar], could not be less than zero, defaults to 4.
  final double? elevation;

  @override
  State<EasyDevBottomNavigationBar> createState() => _EasyDevBottomNavigationBarState();
}

class _EasyDevBottomNavigationBarState extends State<EasyDevBottomNavigationBar> {
  late TextStyle _selectedLabelTextStyle;
  late TextStyle _unselectedLabelTextStyle;
  late Color _backgroundColor;
  late Color? _unselectedIconColor;
  late Color? _selectedIconColor;
  late Color? _unselectedLabelColor;
  late Color? _selectedLabelColor;
  late Color _shadowColor;
  late Color? _indicatorColor;
  late ShowLabel _showLabel;
  late BottomNavigationBarItemAlignment _alignment;
  late double _iconSize;
  late EdgeInsets _padding;
  late EdgeInsets _margin;
  late BorderRadius _radius;
  late double _elevation;

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
    final bottomNavigationBarTheme = theme.bottomNavigationBarTheme;

    _selectedLabelTextStyle = widget.selectedLabelTextStyle ??
        bottomNavigationBarTheme?.selectedLabelTextStyle ??
        theme.typography?.captionStyle ??
        const TextStyle();

    _unselectedLabelTextStyle = widget.unselectedLabelTextStyle ??
        bottomNavigationBarTheme?.unselectedLabelTextStyle ??
        theme.typography?.captionStyle ??
        const TextStyle();

    _backgroundColor = widget.backgroundColor ??
        bottomNavigationBarTheme?.backgroundColor ??
        theme.colorPalette.greySwatch.surfaceColor;

    _unselectedIconColor = widget.unselectedIconColor ??
        bottomNavigationBarTheme?.unselectedIconColor ??
        (theme.brightness == Brightness.light
            ? theme.colorPalette.greySwatch.onSurfaceColor
            : (theme.colorPalette.secondarySwatch?[300] ?? theme.colorPalette.secondarySwatch));

    _selectedIconColor = widget.selectedIconColor ??
        bottomNavigationBarTheme?.selectedIconColor ??
        (theme.brightness == Brightness.light
            ? (theme.colorPalette.secondarySwatch?[700] ?? theme.colorPalette.secondarySwatch)
            : (theme.colorPalette.tertiarySwatch?[50] ?? theme.colorPalette.tertiarySwatch));

    _unselectedLabelColor = widget.unselectedLabelColor ??
        bottomNavigationBarTheme?.unselectedLabelColor ??
        (theme.brightness == Brightness.light
            ? theme.colorPalette.greySwatch.unselectedColor
            : (theme.colorPalette.secondarySwatch?[300] ?? theme.colorPalette.secondarySwatch));

    _selectedLabelColor = widget.selectedLabelColor ??
        bottomNavigationBarTheme?.selectedLabelColor ??
        (theme.brightness == Brightness.light
            ? (theme.colorPalette.secondarySwatch?[700] ?? theme.colorPalette.secondarySwatch)
            : (theme.colorPalette.tertiarySwatch?[50] ?? theme.colorPalette.tertiarySwatch));

    _shadowColor = widget.shadowColor ??
        bottomNavigationBarTheme?.shadowColor ??
        (theme.brightness == Brightness.light
            ? theme.colorPalette.greySwatch.surfaceColor
            : theme.colorPalette.greySwatch.surfaceColor);

    _indicatorColor = widget.indicatorColor ??
        bottomNavigationBarTheme?.indicatorColor ??
        theme.colorPalette.primarySwatch[500];

    _showLabel = widget.showLabel ?? bottomNavigationBarTheme?.showLabel ?? ShowLabel.always;
    _alignment = widget.alignment ??
        bottomNavigationBarTheme?.alignment ??
        BottomNavigationBarItemAlignment.allExpanded;
    _iconSize = widget.iconSize ?? bottomNavigationBarTheme?.iconSize ?? 24;
    _padding = widget.padding ?? bottomNavigationBarTheme?.padding ?? const EdgeInsets.all(18);
    _margin = widget.margin ?? bottomNavigationBarTheme?.margin ?? EdgeInsets.zero;
    _radius = widget.radius ?? bottomNavigationBarTheme?.radius ?? BorderRadius.circular(48);
    _elevation = widget.elevation ?? bottomNavigationBarTheme?.elevation ?? 4;
  }

  MainAxisAlignment get getItemMainAlignment {
    switch (_alignment) {
      case (BottomNavigationBarItemAlignment.start):
        return MainAxisAlignment.start;
      case (BottomNavigationBarItemAlignment.end):
        return MainAxisAlignment.end;
      case (BottomNavigationBarItemAlignment.spaceAround):
        return MainAxisAlignment.spaceAround;
      case (BottomNavigationBarItemAlignment.spaceEvenly):
        return MainAxisAlignment.spaceEvenly;
      case (BottomNavigationBarItemAlignment.spaceBetween):
        return MainAxisAlignment.spaceBetween;
      default:
        return MainAxisAlignment.center;
    }
  }

  bool showLabel(
    int index,
  ) {
    switch (_showLabel) {
      case ShowLabel.always:
        return true;
      case ShowLabel.never:
        return false;
      case ShowLabel.selected:
        return index == widget.currentIndex;
      case ShowLabel.unselected:
        return index != widget.currentIndex;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _margin,
      child: PhysicalShape(
        color: _backgroundColor,
        clipper: ShapeBorderClipper(
          shape: RoundedRectangleBorder(
            borderRadius: _radius,
          ),
        ),
        shadowColor: _shadowColor,
        elevation: _elevation,
        child: Padding(
          padding: _padding,
          child: Row(
            mainAxisAlignment: getItemMainAlignment,
            children: [
              for (int i = 0; i < widget.items.length; i++) ...[
                _alignment == BottomNavigationBarItemAlignment.allExpanded
                    ? Expanded(
                        child: EasyDevBottomNavigationBarItemWrapper(
                          item: widget.items[i],
                          selected: widget.currentIndex == i,
                          showLabel: showLabel(i),
                          iconSize: _iconSize,
                          onTap: () => widget.onItemTap?.call(i),
                          selectedIconColor: _selectedIconColor,
                          unselectedIconColor: _unselectedIconColor,
                          indicatorColor: _indicatorColor,
                          selectedLabelTextStyle: _selectedLabelTextStyle.copyWith(
                            color: _selectedLabelColor,
                          ),
                          unselectedLabelTextStyle: _unselectedLabelTextStyle.copyWith(
                            color: _unselectedLabelColor,
                          ),
                        ),
                      )
                    : EasyDevBottomNavigationBarItemWrapper(
                        item: widget.items[i],
                        selected: widget.currentIndex == i,
                        showLabel: showLabel(i),
                        iconSize: _iconSize,
                        onTap: () => widget.onItemTap?.call(i),
                        selectedIconColor: _selectedIconColor,
                        unselectedIconColor: _unselectedIconColor,
                        indicatorColor: _indicatorColor,
                        selectedLabelTextStyle: _selectedLabelTextStyle.copyWith(
                          color: _selectedLabelColor,
                        ),
                        unselectedLabelTextStyle: _unselectedLabelTextStyle.copyWith(
                          color: _unselectedLabelColor,
                        ),
                      ),
                if (i != widget.items.length - 1)
                  const SizedBox(
                    width: 8,
                  ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
