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
    return const EasyDevScaffold(
      appBar: EasyDevAppBar(
        title: 'EasyDevBottomSheet',
      ),
      body: EasyDevBottomSheet(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Center(
              child: Text('Persistent bottom sheet'),
            ),
          ],
        ),
      ),
    );
  }
}
