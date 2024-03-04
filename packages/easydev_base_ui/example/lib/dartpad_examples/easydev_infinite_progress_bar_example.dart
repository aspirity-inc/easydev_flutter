import 'package:easydev_base_ui/easydev_base_ui.dart';
import 'package:easydev_basics/easydev_basics.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';

/// Flutter code sample for [EasyDevInfiniteProgressBar].
void main() => runApp(const EasyDevInfiniteProgressBarExampleApp());

class EasyDevInfiniteProgressBarExampleApp extends StatelessWidget {
  const EasyDevInfiniteProgressBarExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyDevApp(
      darkThemeData: defaultDarkTheme,
      lightThemeData: defaultLightTheme,
      home: const EasyDevScaffold(
        appBar: EasyDevAppBar(title: 'EasyDevInfiniteProgressBar Sample'),
        body: EasyDevInfiniteProgressBarExample(),
      ),
    );
  }
}

class EasyDevInfiniteProgressBarExample extends StatelessWidget {
  const EasyDevInfiniteProgressBarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: EasyDevInfiniteProgressBar(
        width: 202,
      ),
    );
  }
}
