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
  int? selectedValue;

  @override
  Widget build(BuildContext context) {
    return EasyDevScaffold(
      body: Center(
        child: EasyDevSelect<int>(
          maxHeight: 400,
          selectedValue: selectedValue,
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
              selectedValue = newValue;
            });
          },
          hint: 'Select option',
        ),
      ),
    );
  }
}
