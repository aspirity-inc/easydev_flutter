import 'package:easydev_base_ui/src/widgets/modal_widgets/action_sheet/action_sheet_decoration.dart';
import 'package:easydev_base_ui/src/widgets/modal_widgets/action_sheet/action_sheet_decoration_widget.dart';
import 'package:easydev_base_ui/src/widgets/modal_widgets/action_sheet/cancel_action_sheet_button.dart';
import 'package:easydev_base_ui/src/widgets/modal_widgets/action_sheet/easydev_action_sheet_item.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';

const _animationDuration = Duration(milliseconds: 175);

/// The [EasyDevActionSheet] facilitates the creation of customizable action sheets,
/// offering a set of options for user interaction in a modal dialog. It can be used
/// by providing a list of actions of type [EasyDevActionSheetItem] to populate the sheet,
/// along with specifying a [title] for the upper element.
///
/// [showCancelButton] can be used to show or hid [CancelActionSheetButton] below the action list.
/// [popOnCancel] cab be used for automatic popping when cancel button is tapped.
/// Other fields can be used to change [EasyDevActionSheet] appearence.
///
///
/// Example of using [EasyDevActionSheet].
/// ```dart
/// EasyDevActionSheet(
///   actions: [
///     EasyDevActionSheetItem(
///       onTap: () {
///         // Add your onTap code here!
///       },
///       text: 'Action',
///     ),
///     EasyDevActionSheetItem(
///       onTap: () {
///         // Add your onTap code here!
///       },
///       text: 'Action',
///     ),
///     EasyDevActionSheetItem(
///       onTap: () {
///         // Add your onTap code here!
///       },
///       text: 'Action',
///     )
///   ],
///   title: 'Title',
// ),
/// ```
///
///
/// This sample produces variant of EasyDevActionMenu.
///
/// See code in easydev_base_ui/example/lib/dartpad_examples/easydev_action_sheet_example.dart
class EasyDevActionSheet extends StatefulWidget {
  const EasyDevActionSheet({
    super.key,
    required this.actions,
    required this.title,
    this.backgroundColor,
    this.tappedSurfaceColor,
    this.padding,
    this.titleStyle,
    this.actionStyle,
    this.width,
    this.iconColor,
    this.borderRadius,
    this.roundedBorderRadius,
    this.modalBorderRadius,
    this.showCancelButton,
    this.cancelIcon,
    this.spacing,
    this.cancelTitle,
    this.popOnCancel = false,
    this.roundLowerBorder = false,
  }) : assert(actions.length != 0, 'You need to provide at least one action');

  /// List of [EasyDevActionSheetItem], what shown with modal dialog.
  final List<EasyDevActionSheetItem> actions;

  /// Title of the upper element in this sheet.
  final String title;

  /// Whether lover border of of the upper element is rounded.
  final bool roundLowerBorder;

  /// Background color of widget.
  final Color? backgroundColor;

  /// Color of background when tapped on widget.
  final Color? tappedSurfaceColor;

  /// Padding of widget.
  final EdgeInsets? padding;

  /// [TextStyle] of [title].
  final TextStyle? titleStyle;

  /// [TextStyle] of [CancelActionSheetButton] and [EasyDevActionSheetItem].
  final TextStyle? actionStyle;

  /// When provided limits max width of widget.
  final double? width;

  /// Spacing between icons and text.
  final double? spacing;

  /// BorderRadius of widget.
  final BorderRadius? borderRadius;

  /// BorderRadius of widget when [EasyDevActionSheet.roundLowerBorder] is equal to true.
  final BorderRadius? roundedBorderRadius;

  /// BorderRadius of widget modal dialog and [CancelActionSheetButton].
  final BorderRadius? modalBorderRadius;

  /// When true shows [CancelActionSheetButton] below actions list.
  final bool? showCancelButton;

  /// Color of icons in widget.
  final Color? iconColor;

  /// Icon of [CancelActionSheetButton].
  final IconData? cancelIcon;

  /// Title of [CancelActionSheetButton], when not provided it is 'Cancel'.
  final String? cancelTitle;

  /// If true, [Navigator] will pop when cancel button is tapped
  final bool popOnCancel;

  @override
  State<EasyDevActionSheet> createState() => _EasyDevActionSheetState();
}

class _EasyDevActionSheetState extends State<EasyDevActionSheet> {
  late Color _backgroundColor;
  late Color _tappedColor;
  late Color _iconColor;
  late EdgeInsets _padding;
  late TextStyle _titleStyle;
  late TextStyle _actionStyle;
  late BorderRadius _borderRadius;
  late BorderRadius _modalBorderRadius;
  late bool _showCancelButton;
  late Color _dividerColor;

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
    final actionSheetTheme = theme.actionSheetThemeData;
    final greySwatch = theme.colorPalette.greySwatch;
    final light = theme.brightness == Brightness.light;

    _backgroundColor = widget.backgroundColor ??
        actionSheetTheme?.backgroundColor ??
        (light ? greySwatch.surfaceColor : greySwatch.disabledColor ?? greySwatch.surfaceColor);
    _tappedColor = widget.tappedSurfaceColor ??
        actionSheetTheme?.tappedColor ??
        greySwatch.tappedSurfaceColor ??
        greySwatch.surfaceColor;
    _iconColor = widget.iconColor ??
        actionSheetTheme?.actionIconColor ??
        (light
            ? (greySwatch.unselectedColor ?? greySwatch.onSurfaceColor)
            : theme.colorPalette.secondarySwatch?[300] ??
                theme.colorPalette.secondarySwatch ??
                theme.colorPalette.primarySwatch);
    _padding = widget.padding ?? actionSheetTheme?.padding ?? const EdgeInsets.all(16);
    _titleStyle = widget.titleStyle ??
        actionSheetTheme?.titleStyle ??
        theme.typography?.subheading1Style?.copyWith(
          fontWeight: FontWeight.w700,
          color: light
              ? (greySwatch.onSurfaceBright ?? greySwatch.onSurfaceColor)
              : theme.colorPalette.tertiarySwatch?[50] ??
                  theme.colorPalette.tertiarySwatch ??
                  theme.colorPalette.secondarySwatch ??
                  theme.colorPalette.primarySwatch,
        ) ??
        TextStyle(color: greySwatch.onSurfaceColor);
    _actionStyle = widget.titleStyle ??
        actionSheetTheme?.titleStyle ??
        theme.typography?.body1Style?.copyWith(
          color: greySwatch.onSurfaceColor,
        ) ??
        TextStyle(color: greySwatch.onSurfaceColor);
    _borderRadius = widget.borderRadius ??
        actionSheetTheme?.borderRadius ??
        const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        );
    _modalBorderRadius = widget.modalBorderRadius ??
        actionSheetTheme?.borderRadius ??
        const BorderRadius.all(Radius.circular(16));
    _showCancelButton =
        theme.actionSheetThemeData?.showCancelButton ?? widget.showCancelButton ?? true;
    _dividerColor = theme.colorPalette.greySwatch.tappedSurfaceColor ??
        theme.colorPalette.greySwatch.surfaceColor;
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.easyDevTheme;

    final decoration = ActionSheetDecoration(
      backgroundColor: _backgroundColor,
      tappedColor: _tappedColor,
      iconColor: _iconColor,
      iconSize: theme.actionSheetThemeData?.actionIconSize ?? 24,
      iconSpacing: theme.actionSheetThemeData?.spacing ?? widget.spacing ?? 10,
      padding: _padding,
      titleStyle: _titleStyle,
      actionStyle: _actionStyle,
      borderRadius: _borderRadius,
      modalRadius: _modalBorderRadius,
    );

    final titleWidget = AnimatedContainer(
      width: widget.width,
      duration: _animationDuration,
      padding: decoration.padding,
      decoration: BoxDecoration(
        color: decoration.backgroundColor,
        borderRadius: decoration.borderRadius,
      ),
      alignment: Alignment.center,
      child: AnimatedDefaultTextStyle(
        duration: _animationDuration,
        style: decoration.titleStyle,
        child: Text(
          widget.title,
        ),
      ),
    );

    final divider = Container(
      height: 2,
      color: _dividerColor,
    );

    return ActionSheetDecorationWidget(
      decoration: decoration,
      child: Column(
        children: [
          PhysicalShape(
            clipper: ShapeBorderClipper(
              shape: RoundedRectangleBorder(
                borderRadius: decoration.modalRadius,
              ),
            ),
            color: decoration.backgroundColor,
            elevation: 8,
            child: Column(
              children: [
                titleWidget,
                ...widget.actions
                    .sublist(0, widget.actions.length - 1)
                    .map(
                      (e) => [
                        divider,
                        e.copyAndOverrideLast(
                          last: false,
                        )
                      ],
                    )
                    .expand(
                      (element) => element,
                    ),
                divider,
                widget.actions.last.copyAndOverrideLast(
                  last: true,
                ),
              ],
            ),
          ),
          if (_showCancelButton) ...[
            const SizedBox(
              height: 8,
            ),
            CancelActionSheetButton(
              borderRadius: _modalBorderRadius,
              title: widget.cancelTitle ?? 'Cancel',
              iconData: widget.cancelIcon,
              popOnTap: widget.popOnCancel,
            ),
          ],
        ],
      ),
    );
  }
}
