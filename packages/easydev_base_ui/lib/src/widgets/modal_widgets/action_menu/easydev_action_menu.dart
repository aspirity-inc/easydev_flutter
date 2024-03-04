import 'package:easydev_base_ui/src/widgets/modal_widgets/action_menu/easydev_action_menu_item.dart';
import 'package:easydev_base_ui/src/widgets/modal_widgets/show_modal_widget/raw_modal_widget.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';

/// Menu with actions, which represented by generic type.
/// [onSelected] callback must be provided to handle selected actions
/// and a list of actions of type [EasyDevActionMenuItem] must be provided to populate the menu.
/// Other fields can be used to change [EasyDevActionMenu] appearence.
///
/// Note that this widget must be wrapped in [EasyDevScaffold] or [Scaffold]
/// to function properly.
///
///
/// Example of using [EasyDevActionMenu].
/// ```dart
/// ...
/// int selectedAction = 0;
/// ...
/// EasyDevScaffold(
///   body: EasyDevActionMenu<int>(
///     icon: CommunityMaterialIcons.dots_vertical,
///     actions: [
///       EasyDevActionMenuItem<int>(
///         actionName: 'Action 1',
///         value: 1,
///         selected: selectedAction == 1,
///       ),
///       EasyDevActionMenuItem<int>(
///         actionName: 'Action 2',
///         value: 2,
///         selected: selectedAction == 2,
///       ),
///     ],
///     onSelected: (int value) {
///       setState(() {
///         selectedAction = value;
///       });
///     },
///   ),
/// )
/// ```
///
///
/// This sample produces variant of EasyDevActionMenu.
///
/// See code in easydev_base_ui/example/lib/dartpad_examples/easydev_action_menu_example.dart
class EasyDevActionMenu<T> extends StatelessWidget {
  /// Create action menu.
  const EasyDevActionMenu({
    super.key,
    required this.onSelected,
    required this.actions,
    this.icon,
    this.iconColor,
    this.iconSize,
    this.offset,
    this.itemWidth,
    this.modalRadius,
  }) : assert(actions.length != 0, 'Actions should not be empty');

  /// Callback that returns [EasyDevActionMenuItem.value].
  final ValueChanged<T> onSelected;

  /// List of [EasyDevActionMenuItem] that are placed in modal dialog.
  final List<EasyDevActionMenuItem> actions;

  /// [IconData] of widget.
  final IconData? icon;

  /// [Color] of [icon].
  final Color? iconColor;

  /// Size of [icon].
  final double? iconSize;

  /// [Offset] of modal dialog.
  final Offset? offset;

  /// [maxWidth] of modal dialog. Initially is equal 188.
  final double? itemWidth;

  /// [BorderRadius] of modal dialog.
  final BorderRadius? modalRadius;

  Color _getIconColor(EasyDevThemeData theme) {
    final light = theme.brightness == Brightness.light;

    return iconColor ??
        theme.actionMenuThemeData?.iconColor ??
        (light
            ? (theme.colorPalette.greySwatch.unselectedColor ??
                theme.colorPalette.greySwatch.greyColor)
            : (theme.colorPalette.secondarySwatch?[200] ??
                theme.colorPalette.secondarySwatch ??
                theme.colorPalette.primarySwatch));
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.easyDevTheme;
    final borderRadius = modalRadius ??
        theme.actionMenuThemeData?.borderRadius ??
        const BorderRadius.all(Radius.circular(8));

    return RawModalWidget<T>(
      valueChanged: onSelected,
      modalOffset: const Offset(-90, 2),
      correctPosition: true,
      modalWidget: PhysicalShape(
        clipper: ShapeBorderClipper(
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius,
          ),
        ),
        elevation: 8,
        color: theme.colorPalette.greySwatch.backgroundColor ??
            theme.colorPalette.greySwatch.surfaceColor,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: itemWidth ?? 188,
          ),
          child: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(
              actions.length,
              (index) {
                if (actions.length == 1) {
                  return actions.first.copyWithBorderRadius(borderRadius: borderRadius);
                }
                if (index == 0) {
                  return actions.first.copyWithBorderRadius(
                      borderRadius: BorderRadius.only(
                    topLeft: borderRadius.topLeft,
                    topRight: borderRadius.topRight,
                  ));
                }
                if (index == actions.length - 1) {
                  return actions.last.copyWithBorderRadius(
                      borderRadius: BorderRadius.only(
                    bottomLeft: borderRadius.bottomLeft,
                    bottomRight: borderRadius.bottomRight,
                  ));
                }
                return actions[index];
              },
            ),
          ),
        ),
      ),
      child: Icon(
        icon,
        color: _getIconColor(theme),
        size: iconSize ?? theme.actionMenuThemeData?.iconSize ?? 24,
      ),
    );
  }
}
