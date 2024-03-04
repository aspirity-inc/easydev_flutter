import 'package:easydev_base_ui/easydev_base_ui.dart';
import 'package:easydev_basics/easydev_basics.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';

/// Flutter code sample for [SpinningLoadingIndicator].
void main() => runApp(const SpinningLoadingIndicatorExampleApp());

class SpinningLoadingIndicatorExampleApp extends StatelessWidget {
  const SpinningLoadingIndicatorExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyDevApp(
      darkThemeData: defaultDarkTheme,
      lightThemeData: defaultLightTheme,
      home: const EasyDevScaffold(
        appBar: EasyDevAppBar(title: 'SpinningLoadingIndicator Sample'),
        body: SpinningLoadingIndicatorExample(),
      ),
    );
  }
}

class SpinningLoadingIndicatorExample extends StatelessWidget {
  const SpinningLoadingIndicatorExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SpinningLoadingIndicator(),
    );
  }
}
