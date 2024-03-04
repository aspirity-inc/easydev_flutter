import 'package:community_material_icon/community_material_icon.dart';
import 'package:easydev_base_ui/easydev_base_ui.dart';
import 'package:easydev_basics/easydev_basics.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';

/// Flutter code sample for [EasyDevSearch].
void main() => runApp(const EasyDevSearchExampleApp());

class EasyDevSearchExampleApp extends StatelessWidget {
  const EasyDevSearchExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyDevApp(
      darkThemeData: defaultDarkTheme,
      lightThemeData: defaultLightTheme,
      home: const EasyDevScaffold(
        appBar: EasyDevAppBar(title: 'EasyDevSearch Sample'),
        body: EasyDevSearchExample(),
      ),
    );
  }
}

class EasyDevSearchExample extends StatelessWidget {
  const EasyDevSearchExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EasyDevSearch(
          leadingIcon: const EasyDevIconButton(CommunityMaterialIcons.magnify, size: 24),
          trailingIcon: const EasyDevIconButton(CommunityMaterialIcons.microphone, size: 24),
          options: [
            EasyDevSearchOption(value: 'First', onTap: (value) {}),
            EasyDevSearchOption(value: 'Second', onTap: (value) {}),
            EasyDevSearchOption(value: 'Third', onTap: (value) {}),
            EasyDevSearchOption(value: 'Fourth', onTap: (value) {}),
          ],
        ),
      ],
    );
  }
}
