import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';

import 'package:easydev_base_ui/src/widgets/tabs/enums/tabbar_idicator_type.dart';

class EasyDevTabLabelStyle extends AnimatedWidget {
  const EasyDevTabLabelStyle({
    super.key,
    required Animation<double> animation,
    required this.isSelected,
    required this.selectedLabelColor,
    required this.unselectedLabelColor,
    required this.selectedLabelStyle,
    required this.unselectedLabelStyle,
    required this.defaultTheme,
    required this.indicatorType,
    required this.child,
  }) : super(listenable: animation);

  /// [TextStyle] of the selected tab label.
  final TextStyle? selectedLabelStyle;

  /// [TextStyle] of the unselected tab label.
  final TextStyle? unselectedLabelStyle;

  /// Whether tab is selected.
  final bool isSelected;

  /// [Color] of the selected tab label.
  final Color? selectedLabelColor;

  /// [Color] of the unselected tab label.
  final Color? unselectedLabelColor;

  /// Default theme for tabs.
  final EasyDevTabsThemeData defaultTheme;

  /// Indicator type of the tab.
  final TabsIndicatorType indicatorType;

  /// [EasyDevTab] to which this style is applied.
  final Widget child;

  Color _getSelectedColor(
    BuildContext context,
    EasyDevTabsThemeData? tabBarTheme,
  ) =>
      selectedLabelColor ?? tabBarTheme?.selectedLabelColor ?? defaultTheme.selectedLabelColor!;

  Color _getUnselectedColor(
    BuildContext context,
    EasyDevTabsThemeData? tabBarTheme,
  ) =>
      unselectedLabelColor ??
      tabBarTheme?.unselectedLabelColor ??
      defaultTheme.unselectedLabelColor!;

  TextStyle _getSelectedStyle(
    BuildContext context,
    EasyDevTabsThemeData? tabBarTheme,
  ) =>
      (selectedLabelStyle ?? tabBarTheme?.selectedLabelStyle ?? defaultTheme.selectedLabelStyle!)
          .copyWith(inherit: true);

  TextStyle _getUnselectedStyle(
    BuildContext context,
    EasyDevTabsThemeData? tabBarTheme,
  ) =>
      (unselectedLabelStyle ??
              tabBarTheme?.unselectedLabelStyle ??
              defaultTheme.unselectedLabelStyle!)
          .copyWith(inherit: true);

  @override
  Widget build(BuildContext context) {
    final tabBarTheme = context.easyDevTheme.tabsTheme;
    final Animation<double> animation = listenable as Animation<double>;

    final TextStyle selectedStyle = _getSelectedStyle(context, tabBarTheme);
    final TextStyle unselectedStyle = _getUnselectedStyle(context, tabBarTheme);
    final Color selectedColor = _getSelectedColor(context, tabBarTheme);
    final Color unselectedColor = _getUnselectedColor(context, tabBarTheme);

    final TextStyle textStyle = isSelected
        ? TextStyle.lerp(selectedStyle, unselectedStyle, animation.value)!
        : TextStyle.lerp(unselectedStyle, selectedStyle, animation.value)!;
    final Color color = isSelected
        ? Color.lerp(selectedColor, unselectedColor, animation.value)!
        : Color.lerp(unselectedColor, selectedColor, animation.value)!;

    return DefaultTextStyle(
      style: textStyle.copyWith(color: color),
      child: child,
    );
  }
}
