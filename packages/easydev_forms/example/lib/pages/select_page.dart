import 'package:easydev_basics/easydev_basics.dart';
import 'package:easydev_forms/easydev_forms.dart';
import 'package:example_forms/widgets/page_appbar.dart';
import 'package:example_forms/widgets/widget_wrapper.dart';
import 'package:flutter/widgets.dart';

class SelectPage extends StatefulWidget {
  const SelectPage({super.key});

  @override
  State<SelectPage> createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {
  int? value1;
  int? value2;

  List<int> selectedValues1 = [];
  List<int> selectedValues2 = [];

  @override
  Widget build(BuildContext context) {
    return EasyDevScaffold(
      body: ListView(
        children: [
          WidgetWrapper(
            label: 'Multiselect with overlay',
            child: EasyDevMultiSelect<int>(
              maxHeight: 400,
              selectedValues: selectedValues1,
              items: List.generate(
                20,
                (index) => EasyDevMultiselectItem(
                  value: index,
                  name: 'Option ${index + 1}',
                  enabled: index < 15,
                ),
              ),
              valuesChanged: (newValue) {
                setState(() {
                  selectedValues1 = newValue;
                });
              },
              hint: 'Select option',
            ),
          ),
          WidgetWrapper(
            label: 'Multiselect with bottom sheet',
            child: EasyDevMultiSelect<int>(
              selectedValues: selectedValues2,
              items: List.generate(
                20,
                (index) => EasyDevMultiselectItem(
                  value: index,
                  name: 'Option ${index + 1}',
                  enabled: index < 15,
                ),
              ),
              valuesChanged: (newValue) {
                setState(() {
                  selectedValues2 = newValue;
                });
              },
              withBottomSheet: true,
              hint: 'Select option',
            ),
          ),
          WidgetWrapper(
            label: 'Select with overlay',
            child: EasyDevSelect<int>(
              maxHeight: 400,
              selectedValue: value1,
              values: List.generate(
                20,
                (index) => EasyDevSelectItem(
                  value: index,
                  name: 'Option ${index + 1}',
                  enabled: index < 15,
                ),
              ),
              onSelected: (newValue) {
                setState(() {
                  value1 = newValue;
                });
              },
              hint: 'Select option',
            ),
          ),
          WidgetWrapper(
            label: 'Select with bottom sheet',
            child: EasyDevSelect<int>(
              withBottomSheet: true,
              selectedValue: value2,
              values: List.generate(
                20,
                (index) => EasyDevSelectItem(
                  value: index,
                  name: 'Option ${index + 1}',
                  enabled: index < 15,
                ),
              ),
              onSelected: (newValue) {
                setState(() {
                  value2 = newValue;
                });
              },
              hint: 'Select option',
            ),
          ),
          WidgetWrapper(
            label: 'Disabled select',
            child: EasyDevSelect<int>(
              maxHeight: 400,
              enabled: false,
              selectedValue: value1,
              values: List.generate(
                20,
                (index) => EasyDevSelectItem(
                  value: index,
                  name: 'Option ${index + 1}',
                ),
              ),
              onSelected: (newValue) {
                setState(() {
                  value1 = newValue;
                });
              },
              hint: 'Select option',
            ),
          ),
          WidgetWrapper(
            label: 'Disabled select with value',
            child: EasyDevSelect<int>(
              maxHeight: 400,
              enabled: false,
              selectedValue: 0,
              values: List.generate(
                1,
                (index) => EasyDevSelectItem(
                  value: index,
                  name: 'Option ${index + 1}',
                ),
              ),
              onSelected: (newValue) {
                setState(() {
                  value1 = newValue;
                });
              },
              hint: 'Select option',
            ),
          ),
          WidgetWrapper(
            label: 'Disabled multiselect with value',
            child: EasyDevMultiSelect<int>(
              enabled: false,
              selectedValues: const [0],
              items: List.generate(
                1,
                (index) => EasyDevMultiselectItem(
                  value: index,
                  name: 'Option ${index + 1}',
                  enabled: false,
                ),
              ),
              valuesChanged: (newValue) {},
              hint: 'Select option',
            ),
          ),
          WidgetWrapper(
            label: 'Disabled multiselect without value',
            child: EasyDevMultiSelect<int>(
              enabled: false,
              selectedValues: const [],
              items: List.generate(
                1,
                (index) => EasyDevMultiselectItem(
                  value: index,
                  name: 'Option ${index + 1}',
                ),
              ),
              valuesChanged: (newValue) {},
              hint: 'Select option',
            ),
          ),
        ],
      ),
      appBar: const PageAppBar(
        title: 'Select and Multiselect page',
      ),
    );
  }
}
