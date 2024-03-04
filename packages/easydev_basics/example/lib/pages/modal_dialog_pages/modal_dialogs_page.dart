import 'package:easydev_base_ui/easydev_base_ui.dart';
import 'package:easydev_basics/easydev_basics.dart';
import 'package:example_basics/pages/modal_dialog_pages/modal_dialog_add_photo.dart';
import 'package:example_basics/pages/modal_dialog_pages/modal_dialog_with_action.dart';
import 'package:example_basics/pages/modal_dialog_pages/modal_dialog_with_checkboxes.dart';
import 'package:example_basics/widgets/page_appbar.dart';
import 'package:example_basics/widgets/widget_wrapper.dart';
import 'package:flutter/widgets.dart';

class ModalDialogsPage extends StatelessWidget {
  const ModalDialogsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyDevScaffold(
      body: ListView(
        children: [
          WidgetWrapper(
            label: 'Default dialog',
            child: EasyDevButton.primary(
              text: 'Show default dialog',
              onTap: () => showEasyDevModalDialog(
                context: context,
                builder: (context) => EasyDevModalDialog(
                  title: 'Title',
                  subtitle: 'Message',
                  height: 80 + MediaQuery.textScalerOf(context).scale(70),
                  width: 250,
                ),
              ),
            ),
          ),
          WidgetWrapper(
            label: 'Dialog with two actions',
            child: EasyDevButton.primary(
              text: 'Show actions dialog',
              onTap: () => showEasyDevModalDialog(
                context: context,
                builder: (context) => const ModalDialogWithActions(),
              ),
            ),
          ),
          WidgetWrapper(
            label: 'Dialog with checkboxes',
            child: EasyDevButton.primary(
              text: 'Show dialog',
              onTap: () => showEasyDevModalDialog(
                context: context,
                builder: (context) => const ModalDialogWithCheckboxes(),
              ),
            ),
          ),
          WidgetWrapper(
            label: 'Dialog add photo',
            child: EasyDevButton.primary(
              text: 'Show dialog',
              onTap: () => showEasyDevModalDialog(
                context: context,
                builder: (context) => const ModalDialogAddPhoto(),
              ),
            ),
          ),
        ],
      ),
      appBar: const PageAppBar(
        title: 'Modal dialogs page',
      ),
    );
  }
}
