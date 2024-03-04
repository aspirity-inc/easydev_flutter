import 'package:easydev_base_ui/easydev_base_ui.dart';
import 'package:easydev_basics/easydev_basics.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';

/// Flutter code sample for [EasyDevProgressBar].
void main() => runApp(const EasyDevProgressBarExampleApp());

class EasyDevProgressBarExampleApp extends StatelessWidget {
  const EasyDevProgressBarExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyDevApp(
      darkThemeData: defaultDarkTheme,
      lightThemeData: defaultLightTheme,
      home: const EasyDevScaffold(
        appBar: EasyDevAppBar(title: 'EasyDevProgressBar Sample'),
        body: EasyDevProgressBarExample(),
      ),
    );
  }
}

class EasyDevProgressBarExample extends StatelessWidget {
  const EasyDevProgressBarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: EasyDevProgressBar(
        percentage: 0.5,
      ),
    );
  }
}
