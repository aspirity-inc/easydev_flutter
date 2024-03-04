import 'package:easydev_base_ui/src/widgets/easydev_button/easydev_button.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';

class EasyDevTextFieldContextMenu extends StatelessWidget {
  const EasyDevTextFieldContextMenu({
    super.key,
    required this.anchor,
    this.height = 32,
    required this.buttonItems,
    this.backgroundColor,
    this.buttonsTextColor,
    this.buttonsTextStyle,
  });

  final Offset anchor;
  final double height;
  final List<ContextMenuButtonItem> buttonItems;
  final Color? backgroundColor;
  final Color? buttonsTextColor;
  final TextStyle? buttonsTextStyle;

  Color? _getBackgroundColor(BuildContext context) {
    if (backgroundColor != null) return backgroundColor;
    final theme = context.easyDevTheme;
    return theme.colorPalette.greySwatch.surfaceColor;
  }

  @override
  Widget build(BuildContext context) {
    const borderRadius = BorderRadius.all(Radius.circular(8));

    if (buttonItems.isEmpty) {
      return const SizedBox();
    }
    return Stack(
      children: <Widget>[
        Positioned(
          top: anchor.dy - height - 4,
          left: anchor.dx,
          child: PhysicalModel(
            borderRadius: borderRadius,
            elevation: 8,
            color: const Color(0x00000000),
            child: Container(
              height: height,
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                color: _getBackgroundColor(context),
              ),
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: buttonItems.length,
                itemBuilder: (context, index) => EasyDevTextFieldContextMenuButton(
                  buttonItem: buttonItems[index],
                  textColor: buttonsTextColor,
                  textStyle: buttonsTextStyle,
                ),
                separatorBuilder: (context, index) => const SizedBox(width: 8),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class EasyDevTextFieldContextMenuButton extends StatelessWidget {
  const EasyDevTextFieldContextMenuButton({
    super.key,
    required this.buttonItem,
    this.textColor,
    this.textStyle,
  });

  final ContextMenuButtonItem buttonItem;

  final Color? textColor;
  final TextStyle? textStyle;

  String? _getButtonText() {
    return buttonItem.label ??
        switch (buttonItem.type) {
          ContextMenuButtonType.cut => 'Cut',
          ContextMenuButtonType.copy => 'Copy',
          ContextMenuButtonType.paste => 'Paste',
          ContextMenuButtonType.selectAll => 'Select all',
          ContextMenuButtonType.delete => 'Delete',
          ContextMenuButtonType.lookUp => 'Look up',
          ContextMenuButtonType.searchWeb => 'Search web',
          ContextMenuButtonType.share => 'Share',
          ContextMenuButtonType.liveTextInput => 'Live Text input',
          ContextMenuButtonType.custom => null,
        };
  }

  Color? _getTextColor(BuildContext context) {
    if (textColor != null) return textColor;
    final theme = context.easyDevTheme;
    return theme.colorPalette.greySwatch.onSurfaceColor;
  }

  @override
  Widget build(BuildContext context) {
    return EasyDevButton.text(
      text: _getButtonText(),
      onTap: buttonItem.onPressed ?? () {},
      textStyle: textStyle ?? captionStyle,
      textColor: _getTextColor(context),
      uppercase: false,
    );
  }
}
