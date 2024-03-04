import 'package:easydev_base_ui/easydev_base_ui.dart';
import 'package:easydev_basics/easydev_basics.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';

/// Flutter code sample for [EasyDevActionSheet].
void main() => runApp(const EasyDevActionSheetExampleApp());

class EasyDevActionSheetExampleApp extends StatelessWidget {
  const EasyDevActionSheetExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyDevApp(
      darkThemeData: defaultDarkTheme,
      lightThemeData: defaultLightTheme,
      home: const EasyDevScaffold(
        appBar: EasyDevAppBar(title: 'EasyDevActionSheet Sample'),
        body: EasyDevActionSheetExample(),
      ),
    );
  }
}

class EasyDevActionSheetExample extends StatelessWidget {
  const EasyDevActionSheetExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EasyDevActionSheet(
          actions: [
            EasyDevActionSheetItem(
              onTap: () {},
              text: 'Action',
            ),
            EasyDevActionSheetItem(
              onTap: () {},
              text: 'Action',
            ),
            EasyDevActionSheetItem(
              onTap: () {},
              text: 'Action',
            )
          ],
          title: 'Title',
        ),
      ],
    );
  }
}
