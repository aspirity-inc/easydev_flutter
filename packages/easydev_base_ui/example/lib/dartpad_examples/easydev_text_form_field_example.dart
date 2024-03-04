import 'package:easydev_base_ui/easydev_base_ui.dart';
import 'package:easydev_basics/easydev_basics.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';

/// Flutter code sample for [EasyDevTextFormField].
void main() => runApp(const EasyDevTextFormFieldExampleApp());

class EasyDevTextFormFieldExampleApp extends StatelessWidget {
  const EasyDevTextFormFieldExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyDevApp(
      darkThemeData: defaultDarkTheme,
      lightThemeData: defaultLightTheme,
      home: const EasyDevScaffold(
        appBar: EasyDevAppBar(title: 'EasyDevTextFormField Sample'),
        body: EasyDevTextFormFieldExample(),
      ),
    );
  }
}

class EasyDevTextFormFieldExample extends StatelessWidget {
  const EasyDevTextFormFieldExample({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyDevTextFormField(
      hint: 'Input',
      value: 'Initial text',
      valueChanged: (value) {
        // Add your valueChanged code here!
      },
    );
  }
}
