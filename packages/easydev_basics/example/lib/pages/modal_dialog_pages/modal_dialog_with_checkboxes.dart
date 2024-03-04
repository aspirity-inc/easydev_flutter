import 'package:easydev_base_ui/easydev_base_ui.dart';
import 'package:easydev_basics/easydev_basics.dart';
import 'package:easydev_forms/easydev_forms.dart';
import 'package:flutter/widgets.dart';

class ModalDialogWithCheckboxes extends StatefulWidget {
  const ModalDialogWithCheckboxes({super.key});

  @override
  State<ModalDialogWithCheckboxes> createState() => _ModalDialogWithCheckboxesState();
}

class _ModalDialogWithCheckboxesState extends State<ModalDialogWithCheckboxes> {
  List<int> selectedCheckboxValues = [];

  @override
  Widget build(BuildContext context) {
    return EasyDevModalDialog(
      title: 'Title',
      subtitle: 'Message',
      height: 350 + MediaQuery.textScalerOf(context).scale(42),
      width: 340,
      child: Column(
        children: [
          EasyDevLabelWithCheckbox(
            label: 'Label',
            selected: selectedCheckboxValues.contains(1),
            onSelect: (value) => setState(() {
              if (selectedCheckboxValues.contains(value)) {
                selectedCheckboxValues.remove(value);
              } else {
                selectedCheckboxValues.add(value);
              }
            }),
            value: 1,
            expanded: true,
          ),
          const SizedBox(
            height: 8,
          ),
          EasyDevLabelWithCheckbox(
            label: 'Label',
            selected: selectedCheckboxValues.contains(2),
            onSelect: (value) => setState(() {
              if (selectedCheckboxValues.contains(value)) {
                selectedCheckboxValues.remove(value);
              } else {
                selectedCheckboxValues.add(value);
              }
            }),
            value: 2,
            expanded: true,
          ),
          const SizedBox(
            height: 8,
          ),
          EasyDevLabelWithCheckbox(
            label: 'Label',
            selected: selectedCheckboxValues.contains(3),
            onSelect: (value) => setState(() {
              if (selectedCheckboxValues.contains(value)) {
                selectedCheckboxValues.remove(value);
              } else {
                selectedCheckboxValues.add(value);
              }
            }),
            value: 3,
            expanded: true,
          ),
          const SizedBox(
            height: 32,
          ),
          Row(
            children: [
              Expanded(
                child: EasyDevButton.primary(
                  text: 'Accept',
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
        ],
      ),
    );
  }
}
