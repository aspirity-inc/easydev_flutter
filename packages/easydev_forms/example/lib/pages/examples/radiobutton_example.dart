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
  int? selectedRadioButton;

  @override
  Widget build(BuildContext context) {
    return EasyDevScaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            EasyDevRadioButton(
              selected: selectedRadioButton == 1,
              onSelect: (value) {
                setState(() {
                  selectedRadioButton = value;
                });
              },
              value: 1,
            ),
            const SizedBox(
              height: 16,
            ),
            EasyDevRadioButton(
              selected: selectedRadioButton == 2,
              onSelect: (value) {
                setState(() {
                  selectedRadioButton = value;
                });
              },
              value: 2,
            ),
            const SizedBox(
              height: 16,
            ),
            EasyDevLabelWithRadioButton(
              label: 'Radiobutton',
              selected: selectedRadioButton == 3,
              onSelect: (value) {
                setState(() {
                  selectedRadioButton = value;
                });
              },
              value: 3,
            ),
          ],
        ),
      ),
    );
  }
}
