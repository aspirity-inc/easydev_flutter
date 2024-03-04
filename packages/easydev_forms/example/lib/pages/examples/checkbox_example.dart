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
  bool selected1 = false;
  bool selected2 = false;
  bool selected3 = true;

  @override
  Widget build(BuildContext context) {
    return EasyDevScaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          EasyDevCheckbox(
            selected: selected2,
            onSelect: (_) => setState(
              () {
                selected2 = !selected2;
              },
            ),
            value: selected2,
          ),
          EasyDevCheckbox(
            selected: selected1,
            onSelect: (_) => setState(
              () {
                selected1 = !selected1;
              },
            ),
            value: selected1,
          ),
          EasyDevLabelWithCheckbox(
            label: 'Checkbox with label',
            selected: selected3,
            onSelect: (_) => setState(
              () {
                selected3 = !selected3;
              },
            ),
            value: selected3,
          ),
        ],
      ),
    );
  }
}
