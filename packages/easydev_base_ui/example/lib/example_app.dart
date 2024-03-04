import 'package:easydev_basics/easydev_basics.dart';
import 'package:example/router.dart';
import 'package:example/widgets/brightness_notifier.dart';
import 'package:flutter/widgets.dart';
import 'package:easydev_theme/easydev_theme.dart';

class ExampleApp extends StatefulWidget {
  const ExampleApp({super.key});

  @override
  State<ExampleApp> createState() => _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> {
  late ValueNotifier<Brightness> valueNotifier;

  @override
  void initState() {
    valueNotifier = ValueNotifier(Brightness.dark);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final router = AppRouter();
    return BrightnessNotifier(
      valueNotifier: valueNotifier,
      child: Builder(builder: (context) {
        return ValueListenableBuilder(
          valueListenable:
              context.dependOnInheritedWidgetOfExactType<BrightnessNotifier>()!.valueNotifier,
          builder: (context, value, _) {
            return EasyDevApp(
              initialRoute: '/',
              onGenerateRoute: router.generate,
              pageRouteBuilder: router.routeBuilder,
              onUnknownRoute: router.onUnknownRoute,
              debugShowCheckedModeBanner: false,
              darkThemeData: defaultDarkTheme,
              lightThemeData: defaultLightTheme,
              brightness: value,
            );
          },
        );
      }),
    );
  }
}
