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
      home: const BottomSheetExample(),
      title: 'BottomSheet example',
    );
  }
}

class BottomSheetExample extends StatelessWidget {
  const BottomSheetExample({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.easyDevTheme;
    return EasyDevScaffold(
      appBar: const EasyDevAppBar(
        title: 'EasyDevBottomSheet',
      ),
      body: Center(
        child: GestureDetector(
          onTap: () => _showBottomSheet(context),
          child: Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(24),
            color: theme.colorPalette.primarySwatch,
            child: const Text(
              'Show bottom sheet',
            ),
          ),
        ),
      ),
    );
  }

  _showBottomSheet(BuildContext context) {
    final theme = context.easyDevTheme;

    showEasyDevBottomSheet(
      context: context,
      builder: (context) => EasyDevBottomSheet(
        backgroundColor: theme.colorPalette.greySwatch.tappedSurfaceColor?.withOpacity(0.5),
        maxHeight: MediaQuery.of(context).size.height * 0.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.all(24),
                color: theme.colorPalette.primarySwatch,
                child: const Text(
                  'Close bottom sheet',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
