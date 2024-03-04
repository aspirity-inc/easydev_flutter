import 'package:easydev_basics/easydev_basics.dart';
import 'package:easydev_forms/easydev_forms.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyDevApp(
      lightThemeData: defaultLightTheme,
      home: const ExamplePage(),
    );
  }
}

class ExamplePage extends StatefulWidget {
  const ExamplePage({super.key});

  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  List<int> selectedValues = [];

  @override
  Widget build(BuildContext context) {
    return EasyDevScaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            EasyDevMultiSelect<int>(
              selectedValues: selectedValues,
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
                  selectedValues = newValue;
                });
              },
              withBottomSheet: true,
              hint: 'Select option',
            ),
            const SizedBox(
              height: 16,
            ),
            EasyDevMultiSelect<int>(
              selectedValues: selectedValues,
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
                  selectedValues = newValue;
                });
              },
              hint: 'Select option',
            ),
          ],
        ),
      ),
    );
  }
}
