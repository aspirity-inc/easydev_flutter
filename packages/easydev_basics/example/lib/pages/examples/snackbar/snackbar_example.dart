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
      home: const EasyDevSnackbarExample(),
    );
  }
}

class EasyDevSnackbarExample extends StatelessWidget {
  const EasyDevSnackbarExample({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.easyDevTheme;
    return EasyDevScaffold(
      appBar: const EasyDevAppBar(
        title: 'EasyDevSnackbar',
      ),
      body: Center(
        child: GestureDetector(
          onTap: () => EasyDevScaffoldMessenger.of(context).showSnackBar(
            const EasyDevSnackBar(title: 'This is snackbar'),
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(24),
            color: theme.colorPalette.primarySwatch,
            child: const Text(
              'Show snackbar',
            ),
          ),
        ),
      ),
    );
  }
}
