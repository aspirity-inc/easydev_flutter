import 'package:easydev_base_ui/easydev_base_ui.dart';
import 'package:easydev_basics/easydev_basics.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';

/// Flutter code sample for [CircularLoadingIndicator].
void main() => runApp(const CircularLoadingIndicatorExampleApp());

class CircularLoadingIndicatorExampleApp extends StatelessWidget {
  const CircularLoadingIndicatorExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyDevApp(
      darkThemeData: defaultDarkTheme,
      lightThemeData: defaultLightTheme,
      home: const EasyDevScaffold(
        appBar: EasyDevAppBar(title: 'CircularLoadingIndicator Sample'),
        body: CircularLoadingIndicatorExample(),
      ),
    );
  }
}

class CircularLoadingIndicatorExample extends StatelessWidget {
  const CircularLoadingIndicatorExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        CircularLoadingIndicator(
          type: IndicatorType.small,
        ),
        SizedBox(
          height: 16,
        ),
        CircularLoadingIndicator(
          type: IndicatorType.medium,
        ),
        SizedBox(
          height: 16,
        ),
        CircularLoadingIndicator(
          type: IndicatorType.large,
        ),
        SizedBox(
          height: 16,
        ),
        CircularLoadingIndicator(
          stops: [0, 1],
          lineWidth: 18,
          size: 120,
          duration: Duration(
            milliseconds: 1200,
          ),
        ),
      ],
    );
  }
}
