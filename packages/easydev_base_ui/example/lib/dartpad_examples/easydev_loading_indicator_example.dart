import 'package:easydev_base_ui/easydev_base_ui.dart';
import 'package:easydev_basics/easydev_basics.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';

/// Flutter code sample for [EasyDevLoadingIndicator].
void main() => runApp(const EasyDevLoadingIndicatorExampleApp());

class EasyDevLoadingIndicatorExampleApp extends StatelessWidget {
  const EasyDevLoadingIndicatorExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyDevApp(
      darkThemeData: defaultDarkTheme,
      lightThemeData: defaultLightTheme,
      home: const EasyDevScaffold(
        appBar: EasyDevAppBar(title: 'EasyDevLoadingIndicator Sample'),
        body: EasyDevLoadingIndicatorExample(),
      ),
    );
  }
}

class EasyDevLoadingIndicatorExample extends StatelessWidget {
  const EasyDevLoadingIndicatorExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: EasyDevLoadingIndicator(),
    );
  }
}
