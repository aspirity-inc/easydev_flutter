import 'package:easydev_basics/easydev_basics.dart';
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
      home: const AppBarExample(),
      title: 'AppBar example',
    );
  }
}

class AppBarExample extends StatelessWidget {
  const AppBarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const EasyDevScaffold(
      appBar: EasyDevAppBar(
        title: 'EasyDevAppBar',
      ),
      body: Center(
        child: Text('Example'),
      ),
    );
  }
}
