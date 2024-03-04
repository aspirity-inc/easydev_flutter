import 'package:community_material_icon/community_material_icon.dart';
import 'package:easydev_basics/easydev_basics.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';

/// EasyDevAppBar is fixed height widget, that usually placed in top of screen.
/// EasyDevAppBar can be used inside [EasyDevScaffold] in [EasyDevScaffold.appbar] field.
/// If you set [addBackButton] to true and not provide [leading] widget, it will add button with
/// navigate back function that using Navigator.of(context).pop();
/// This sample shows an [EasyDevAppBar] with title and without actions
///
/// See code in example/lib/pages/examples/appbar/appbar_example.dart
/// App bar title can be aligned using [titleAlignment] property. Title can be provided with custom
/// text style using [titleStyle] property.
/// [leading] widget is placed in start of [EasyDevAppBar], [actions] is placed at end
/// of appbar.
///
/// This sample shows an [EasyDevAppBar] with aligned title with changed [TextStyle], back button
/// and two actions, that shows toast and snackbar on pressed.
///
/// See code in example/lib/pages/examples/appbar/appbar_example2.dart
///
/// See also:
///
///  * [EasyDevScaffold], main layout widget.
class EasyDevAppBar extends StatelessWidget implements PreferredSizeWidget {
  const EasyDevAppBar({
    super.key,
    this.backgroundColor,
    this.title,
    this.titleStyle,
    this.titleAlignment = Alignment.center,
    this.leading,
    this.actions,
    this.toolbarHeight = 64,
    this.bottom,
    this.leadingIconTheme,
    this.actionsIconTheme,
    this.addBackButton = false,
  });

  /// Background color of appbar
  final Color? backgroundColor;

  /// [leading] widget is wrapped in [IconTheme] widget, and all [Icon] widgets will inherit
  /// properties of this theme.
  final IconThemeData? leadingIconTheme;

  /// [actions] widgets is wrapped in [IconTheme] widget, and all [Icon] widgets will inherit
  /// properties of this theme.
  final IconThemeData? actionsIconTheme;

  /// Title of appbar.
  final String? title;

  /// [TextStyle] of [title].
  final TextStyle? titleStyle;

  /// [Alignment] of title.
  final Alignment titleAlignment;

  /// Widget that placed in start of appbar, before any other widgets.
  final Widget? leading;

  /// Widgets that placed in end of appbar, after other widgets.
  final List<Widget>? actions;

  /// Widget that placed at bottom of appbar, if it implements [PreferredSizeWidget], it preferred
  /// size height will be used, or else it defaults to 74.
  final Widget? bottom;

  /// Height of appbar, if no [bottom] widget is provided, defaults to 64, if [bottom] widget
  /// is provided it adds [bottom] widget height and [toolbarBottomMargin]
  final double toolbarHeight;

  /// Margin between [bottom] widget and toolbar.
  final double toolbarBottomMargin = 24;

  /// If true, adds button that navigates back when pressed. Only adds in when no [leading] widget
  /// is presented
  final bool addBackButton;

  @override
  Size get preferredSize {
    double height = toolbarHeight;
    if (bottom != null) {
      double? bottomHeight = 74;
      if (bottom is PreferredSizeWidget) {
        bottomHeight = (bottom as PreferredSizeWidget).preferredSize.height;
      }
      height += bottomHeight + toolbarBottomMargin;
    }
    return Size.fromHeight(height);
  }

  IconThemeData _getDefaultActionsIconTheme(EasyDevThemeData theme) {
    final light = theme.brightness == Brightness.light;
    return IconThemeData(
      color: light
          ? (theme.colorPalette.secondarySwatch?[500]) ?? theme.brightness.onSurfaceColor
          : theme.colorPalette.secondarySwatch?[300] ?? theme.brightness.onSurfaceColor,
      size: 24,
    );
  }

  IconThemeData _getDefaultLeadingIconTheme(EasyDevThemeData theme) {
    final light = theme.brightness == Brightness.light;
    return IconThemeData(
      color: light
          ? theme.colorPalette.greySwatch.unselectedColor ?? theme.brightness.onSurfaceColor
          : theme.colorPalette.secondarySwatch?[300] ?? theme.brightness.onSurfaceColor,
      size: 24,
    );
  }

  IconThemeData _getActionsIconTheme(EasyDevThemeData theme) {
    return actionsIconTheme ?? _getDefaultActionsIconTheme(theme);
  }

  IconThemeData _getLeadingIconTheme(EasyDevThemeData theme) {
    return leadingIconTheme ?? _getDefaultLeadingIconTheme(theme);
  }

  TextStyle _getTitleStyle(EasyDevThemeData theme) =>
      titleStyle ??
      heading4Style.copyWith(
        color: theme.appBarTheme?.titleColor ?? theme.brightness.onSurfaceColor,
      );

  @override
  Widget build(BuildContext context) {
    final theme = context.easyDevTheme;
    final color = backgroundColor ?? theme.brightness.surfaceColor;

    return Container(
      height: toolbarHeight,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8)),
      ),
      padding: addBackButton
          ? const EdgeInsets.only(
              right: 16,
            )
          : const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (leading != null)
                IconTheme(
                  data: _getLeadingIconTheme(theme),
                  child: leading!,
                ),
              if (leading == null && addBackButton)
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: Icon(
                      CommunityMaterialIcons.chevron_left,
                      color: _getLeadingIconTheme(theme).color,
                    ),
                  ),
                ),
              if (leading != null)
                const SizedBox(
                  width: 16,
                ),
              if (title != null)
                Expanded(
                  child: Align(
                    alignment: titleAlignment,
                    child: Text(
                      title!,
                      style: _getTitleStyle(theme),
                      maxLines: leading != null ? 1 : 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              if (actions != null && actions!.isNotEmpty)
                const SizedBox(
                  width: 16,
                ),
              if (actions != null && actions!.isNotEmpty)
                IconTheme(
                  data: _getActionsIconTheme(theme),
                  child: Wrap(
                    spacing: 16,
                    children: actions!,
                  ),
                ),
            ],
          ),
          if (bottom != null) ...[
            SizedBox(height: toolbarBottomMargin),
            bottom!,
          ]
        ],
      ),
    );
  }
}
