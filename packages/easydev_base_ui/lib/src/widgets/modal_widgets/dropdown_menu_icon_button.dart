import 'package:easydev_base_ui/easydev_base_ui.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';

/// Example of widget that uses raw modal widget.
class DropdownMenuIconButton extends StatelessWidget {
  DropdownMenuIconButton({
    super.key,
    required this.iconData,
    required this.actions,
    this.modalOffset = Offset.zero,
    this.iconColor,
    this.modalColor,
    this.physics,
    this.maxWidth,
    this.elevation,
  }) : assert(actions.isNotEmpty);

  /// [IconData] of this icon button.
  final IconData iconData;

  /// [Color] of icon.
  final Color? iconColor;

  /// Background [Color] of modal dialog.
  final Color? modalColor;

  /// Actions in modal dialog.
  final List<Widget> actions;

  /// [ScrollPhysics] of modal dialog.
  final ScrollPhysics? physics;

  /// Offset of modal dialog.
  final Offset modalOffset;

  /// Width of modal dialog.
  final double? maxWidth;

  /// Elevation on widget.
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    final theme = context.easyDevTheme;

    return RawModalWidget(
      modalWidget: PhysicalShape(
        clipper: const ShapeBorderClipper(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
        ),
        elevation: 8,
        color: modalColor ??
            theme.colorPalette.greySwatch.backgroundColor ??
            theme.colorPalette.greySwatch.surfaceColor,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: maxWidth ?? MediaQuery.of(context).size.width * 0.5,
          ),
          child: ListView(
            shrinkWrap: true,
            physics: physics ?? const NeverScrollableScrollPhysics(),
            children: actions,
          ),
        ),
      ),
      modalOffset: modalOffset,
      valueChanged: (_) {},
      correctPosition: true,
      child: Icon(
        iconData,
        color: iconColor,
      ),
    );
  }
}
