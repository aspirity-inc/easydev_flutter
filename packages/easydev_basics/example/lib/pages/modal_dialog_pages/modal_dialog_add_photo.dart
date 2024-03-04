import 'package:easydev_base_ui/easydev_base_ui.dart';
import 'package:easydev_basics/easydev_basics.dart';
import 'package:flutter/widgets.dart';
import 'package:easydev_theme/easydev_theme.dart';

class ModalDialogAddPhoto extends StatelessWidget {
  const ModalDialogAddPhoto({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = EasyDevTheme.of(context);

    final dividerColor = theme.brightness == Brightness.light
        ? (theme.colorPalette.secondarySwatch?[100])
        : theme.colorPalette.secondarySwatch?[600];

    return EasyDevModalDialog(
      padding: const EdgeInsets.only(
        top: 40,
        bottom: 40,
      ),
      title: 'Add your photo',
      subtitle: 'Please, choose a way',
      height: 100 + MediaQuery.textScalerOf(context).scale(206),
      width: 340,
      child: Column(
        children: [
          Container(
            height: 1,
            color: dividerColor,
          ),
          const SizedBox(
            height: 16,
          ),
          EasyDevButton.text(
            text: 'Gallery',
            onTap: () => Navigator.pop(context),
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            height: 1,
            color: dividerColor,
          ),
          const SizedBox(
            height: 16,
          ),
          EasyDevButton.text(
            text: 'Photo / Video',
            onTap: () => Navigator.pop(context),
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            height: 1,
            color: dividerColor,
          ),
        ],
      ),
    );
  }
}
