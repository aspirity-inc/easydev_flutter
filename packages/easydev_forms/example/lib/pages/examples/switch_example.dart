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
  bool switchSelected1 = false;
  bool switchSelected2 = false;

  @override
  Widget build(BuildContext context) {
    return EasyDevScaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            EasyDevSwitch(
              value: switchSelected1,
              onSelect: (_) {
                setState(() {
                  switchSelected1 = !switchSelected1;
                });
              },
            ),
            const SizedBox(
              height: 16,
            ),
            EasyDevLabelWithSwitch(
              label: 'Switch',
              value: switchSelected2,
              onSelect: (_) {
                setState(() {
                  switchSelected2 = !switchSelected2;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
