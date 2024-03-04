import 'package:community_material_icon/community_material_icon.dart';
import 'package:easydev_base_ui/easydev_base_ui.dart';
import 'package:easydev_basics/easydev_basics.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';

/// Flutter code sample for [EasyDevIconButton].
void main() => runApp(const EasyDevIconButtonExampleApp());

class EasyDevIconButtonExampleApp extends StatelessWidget {
  const EasyDevIconButtonExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyDevApp(
      darkThemeData: defaultDarkTheme,
      lightThemeData: defaultLightTheme,
      home: const EasyDevScaffold(
        appBar: EasyDevAppBar(title: 'EasyDevIconButton Sample'),
        body: EasyDevIconButtonExample(),
      ),
    );
  }
}

class EasyDevIconButtonExample extends StatelessWidget {
  const EasyDevIconButtonExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          EasyDevIconButton(
            CommunityMaterialIcons.close,
            color: context.easyDevTheme.colorPalette.secondarySwatch?[300],
            onTap: () {},
          ),
          EasyDevIconButton(
            CommunityMaterialIcons.settings_helper,
            color: context.easyDevTheme.colorPalette.secondarySwatch?[300],
            onTap: () {},
          ),
          EasyDevIconButton(
            CommunityMaterialIcons.camera,
            color: context.easyDevTheme.colorPalette.secondarySwatch?[300],
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
