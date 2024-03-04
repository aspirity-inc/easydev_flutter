import 'package:easydev_basics/easydev_basics.dart';
import 'package:easydev_forms/easydev_forms.dart';
import 'package:example_forms/widgets/page_appbar.dart';
import 'package:example_forms/widgets/widget_wrapper.dart';
import 'package:flutter/widgets.dart';
import 'package:easydev_theme/easydev_theme.dart';

class SelectablesPage extends StatefulWidget {
  const SelectablesPage({super.key});

  final int radio1Value = 1;
  final int radio2Value = 2;

  final int checkbox1Value = 1;
  final int checkbox2Value = 2;
  final int checkbox3Value = 3;

  @override
  State<SelectablesPage> createState() => _SelectablesPageState();
}

class _SelectablesPageState extends State<SelectablesPage> {
  int? selectedRadioValue;
  late List<int> selectedCheckboxValues;
  late List<bool> switchValues;
  late bool isRadioWithLabelSelected;

  @override
  void initState() {
    super.initState();

    selectedCheckboxValues = [];
    isRadioWithLabelSelected = false;
    switchValues = List.generate(9, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return EasyDevScaffold(
      body: ListView(
        children: [
          WidgetWrapper(
            label: 'Radio buttons',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EasyDevRadioButton(
                  selected: selectedRadioValue == widget.radio1Value,
                  radioType: RadioType.classic,
                  onSelect: (value) => setState(
                      () => selectedRadioValue = selectedRadioValue == value ? null : value),
                  value: widget.radio1Value,
                ),
                const SizedBox(width: 16),
                EasyDevRadioButton(
                  selected: selectedRadioValue == widget.radio2Value,
                  radioType: RadioType.modern,
                  onSelect: (value) => setState(
                      () => selectedRadioValue = selectedRadioValue == value ? null : value),
                  value: widget.radio2Value,
                ),
              ],
            ),
          ),
          WidgetWrapper(
            label: 'Disabled radio buttons',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EasyDevRadioButton(
                  selected: true,
                  radioType: RadioType.classic,
                  onSelect: (_) {},
                  value: null,
                  disabled: true,
                ),
                const SizedBox(width: 16),
                EasyDevRadioButton(
                  selected: false,
                  radioType: RadioType.classic,
                  onSelect: (_) {},
                  value: null,
                  disabled: true,
                ),
                const SizedBox(width: 32),
                EasyDevRadioButton(
                  selected: true,
                  radioType: RadioType.modern,
                  onSelect: (_) {},
                  value: null,
                  disabled: true,
                ),
                const SizedBox(width: 16),
                EasyDevRadioButton(
                  selected: false,
                  radioType: RadioType.modern,
                  onSelect: (_) {},
                  value: null,
                  disabled: true,
                ),
              ],
            ),
          ),
          WidgetWrapper(
            label: 'Radio button with label',
            child: EasyDevLabelWithRadioButton(
              label: "Radio",
              selected: isRadioWithLabelSelected,
              onSelect: (value) => setState(() {
                isRadioWithLabelSelected = !isRadioWithLabelSelected;
              }),
              value: true,
              spacing: 12,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              expanded: true,
            ),
          ),
          WidgetWrapper(
            label: 'Checkboxes',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EasyDevCheckbox(
                  selected: selectedCheckboxValues.contains(widget.checkbox1Value),
                  onSelect: (value) {
                    setState(() {
                      if (selectedCheckboxValues.contains(value)) {
                        selectedCheckboxValues.remove(value);
                      } else {
                        selectedCheckboxValues.add(value);
                      }
                    });
                  },
                  value: widget.checkbox1Value,
                ),
                const SizedBox(width: 16),
                EasyDevCheckbox(
                  outlined: true,
                  selected: selectedCheckboxValues.contains(widget.checkbox2Value),
                  onSelect: (value) {
                    setState(() {
                      if (selectedCheckboxValues.contains(value)) {
                        selectedCheckboxValues.remove(value);
                      } else {
                        selectedCheckboxValues.add(value);
                      }
                    });
                  },
                  value: widget.checkbox2Value,
                ),
              ],
            ),
          ),
          WidgetWrapper(
            label: 'Disabled checkboxes',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EasyDevCheckbox(
                  selected: true,
                  onSelect: (_) {},
                  value: null,
                  disabled: true,
                ),
                const SizedBox(width: 16),
                EasyDevCheckbox(
                  selected: false,
                  onSelect: (_) {},
                  value: null,
                  disabled: true,
                ),
                const SizedBox(width: 32),
                EasyDevCheckbox(
                  outlined: true,
                  selected: true,
                  onSelect: (_) {},
                  value: null,
                  disabled: true,
                ),
                const SizedBox(width: 16),
                EasyDevCheckbox(
                  outlined: true,
                  selected: false,
                  onSelect: (_) {},
                  value: null,
                  disabled: true,
                ),
              ],
            ),
          ),
          WidgetWrapper(
            label: 'Checkbox with label',
            child: EasyDevLabelWithCheckbox(
              label: "Checkbox",
              selected: selectedCheckboxValues.contains(widget.checkbox3Value),
              onSelect: (value) {
                setState(() {
                  if (selectedCheckboxValues.contains(widget.checkbox3Value)) {
                    selectedCheckboxValues.remove(widget.checkbox3Value);
                  } else {
                    selectedCheckboxValues.add(widget.checkbox3Value);
                  }
                });
              },
              value: true,
              spacing: 12,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              expanded: true,
            ),
          ),
          WidgetWrapper(
            label: 'Switch',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EasyDevSwitch(
                  value: switchValues[0],
                  onSelect: (value) {
                    setState(() {
                      switchValues[0] = !value;
                    });
                  },
                ),
                const SizedBox(width: 16),
                EasyDevSwitch(
                  outlined: true,
                  value: switchValues[1],
                  onSelect: (value) {
                    setState(() {
                      switchValues[1] = !value;
                    });
                  },
                ),
              ],
            ),
          ),
          WidgetWrapper(
            label: 'Disabled switch',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EasyDevSwitch(
                  value: true,
                  onSelect: (_) {},
                  disabled: true,
                ),
                const SizedBox(width: 16),
                EasyDevSwitch(
                  value: false,
                  onSelect: (_) {},
                  disabled: true,
                ),
                const SizedBox(width: 32),
                EasyDevSwitch(
                  outlined: true,
                  value: true,
                  onSelect: (_) {},
                  disabled: true,
                ),
                const SizedBox(width: 16),
                EasyDevSwitch(
                  outlined: true,
                  value: false,
                  onSelect: (_) {},
                  disabled: true,
                ),
              ],
            ),
          ),
          WidgetWrapper(
            label: 'Android styled switch',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EasyDevSwitch(
                  pinType: PinType.android,
                  value: switchValues[2],
                  onSelect: (value) {
                    setState(() {
                      switchValues[2] = !value;
                    });
                  },
                ),
                const SizedBox(width: 16),
                EasyDevSwitch(
                  outlined: true,
                  pinType: PinType.android,
                  value: switchValues[3],
                  onSelect: (value) {
                    setState(() {
                      switchValues[3] = !value;
                    });
                  },
                ),
              ],
            ),
          ),
          WidgetWrapper(
            label: 'Disabled Android styled switch',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EasyDevSwitch(
                  pinType: PinType.android,
                  value: true,
                  onSelect: (_) {},
                  disabled: true,
                ),
                const SizedBox(width: 16),
                EasyDevSwitch(
                  pinType: PinType.android,
                  value: false,
                  onSelect: (_) {},
                  disabled: true,
                ),
                const SizedBox(width: 32),
                EasyDevSwitch(
                  pinType: PinType.android,
                  outlined: true,
                  value: true,
                  onSelect: (_) {},
                  disabled: true,
                ),
                const SizedBox(width: 16),
                EasyDevSwitch(
                  pinType: PinType.android,
                  outlined: true,
                  value: false,
                  onSelect: (_) {},
                  disabled: true,
                ),
              ],
            ),
          ),
          WidgetWrapper(
            label: 'Ios styled switch',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EasyDevSwitch(
                  pinType: PinType.ios,
                  value: switchValues[4],
                  onSelect: (value) {
                    setState(() {
                      switchValues[4] = !value;
                    });
                  },
                ),
                const SizedBox(width: 16),
                EasyDevSwitch(
                  outlined: true,
                  pinType: PinType.ios,
                  value: switchValues[5],
                  onSelect: (value) {
                    setState(() {
                      switchValues[5] = !value;
                    });
                  },
                ),
              ],
            ),
          ),
          WidgetWrapper(
            label: 'Disabled Ios styled switch',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EasyDevSwitch(
                  pinType: PinType.ios,
                  value: true,
                  onSelect: (_) {},
                  disabled: true,
                ),
                const SizedBox(width: 16),
                EasyDevSwitch(
                  pinType: PinType.ios,
                  value: false,
                  onSelect: (_) {},
                  disabled: true,
                ),
                const SizedBox(width: 32),
                EasyDevSwitch(
                  pinType: PinType.ios,
                  outlined: true,
                  value: true,
                  onSelect: (_) {},
                  disabled: true,
                ),
                const SizedBox(width: 16),
                EasyDevSwitch(
                  pinType: PinType.ios,
                  outlined: true,
                  value: false,
                  onSelect: (_) {},
                  disabled: true,
                ),
              ],
            ),
          ),
          WidgetWrapper(
            label: 'Adaptive switch',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EasyDevSwitch.adaptive(
                  value: switchValues[6],
                  onSelect: (value) {
                    setState(() {
                      switchValues[6] = !value;
                    });
                  },
                ),
              ],
            ),
          ),
          WidgetWrapper(
            label: 'Disabled adaptive switch',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EasyDevSwitch.adaptive(
                  value: true,
                  onSelect: (_) {},
                  disabled: true,
                ),
                const SizedBox(width: 16),
                EasyDevSwitch.adaptive(
                  value: false,
                  onSelect: (_) {},
                  disabled: true,
                ),
              ],
            ),
          ),
          WidgetWrapper(
            label: 'Switch with label',
            child: EasyDevLabelWithSwitch(
              label: "Switch",
              value: switchValues[7],
              onSelect: (value) {
                setState(() {
                  switchValues[7] = !value;
                });
              },
              switchHeight: 18,
              expanded: true,
              padding: const EdgeInsets.symmetric(horizontal: 16),
            ),
          ),
          WidgetWrapper(
            label: 'Adaptive switch with label',
            child: EasyDevLabelWithSwitch.adaptive(
              label: "Switch adaptive",
              value: switchValues[8],
              onSelect: (value) {
                setState(() {
                  switchValues[8] = !value;
                });
              },
              switchHeight: null,
              expanded: true,
              padding: const EdgeInsets.symmetric(horizontal: 16),
            ),
          ),
        ],
      ),
      appBar: const PageAppBar(
        title: 'Selectables page',
      ),
    );
  }
}
