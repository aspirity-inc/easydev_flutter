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
  String value = '';

  @override
  Widget build(BuildContext context) {
    return EasyDevScaffold(
      body: Center(
        child: EnterCodeWithKeyboard(
          value: value,
          title: 'Enter code from message',
          valueChanged: (newValue) {
            setState(() {
              value = newValue;
            });
          },
          state: EnterCodeState.enabled,
        ),
      ),
    );
  }
}
