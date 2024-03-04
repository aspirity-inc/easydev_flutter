import 'package:easydev_base_ui/easydev_base_ui.dart';
import 'package:easydev_basics/easydev_basics.dart';
import 'package:flutter/widgets.dart';

class ModalDialogWithActions extends StatelessWidget {
  const ModalDialogWithActions({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyDevModalDialog(
      title: 'Title',
      subtitle: 'Message',
      height: 200 + MediaQuery.textScalerOf(context).scale(50),
      width: 340,
      child: Row(
        children: [
          Expanded(
            child: EasyDevButton.primary(
              text: 'Next',
              onTap: () => Navigator.pop(context),
              margin: EdgeInsets.zero,
            ),
          ),
          const SizedBox(
            width: 24,
          ),
          Expanded(
            child: EasyDevButton.outlined(
              text: 'Cancel',
              onTap: () => Navigator.pop(context),
              margin: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }
}
