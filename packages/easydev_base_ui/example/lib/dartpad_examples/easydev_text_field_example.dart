import 'package:easydev_base_ui/easydev_base_ui.dart';
import 'package:easydev_basics/easydev_basics.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';

/// Flutter code sample for [EasyDevTextField].
void main() => runApp(const EasyDevTextFieldExampleApp());

class EasyDevTextFieldExampleApp extends StatelessWidget {
  const EasyDevTextFieldExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyDevApp(
      darkThemeData: defaultDarkTheme,
      lightThemeData: defaultLightTheme,
      home: const EasyDevScaffold(
        appBar: EasyDevAppBar(title: 'EasyDevTextField Sample'),
        body: EasyDevTextFieldExample(),
      ),
    );
  }
}

class EasyDevTextFieldExample extends StatelessWidget {
  const EasyDevTextFieldExample({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyDevTextField(
      hint: 'Input',
      valueChanged: (value) {
        // Add your valueChanged code here!
      },
    );
  }
}
