import 'package:community_material_icon/community_material_icon.dart';
import 'package:easydev_base_ui/easydev_base_ui.dart';
import 'package:easydev_basics/easydev_basics.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';

/// Flutter code sample for [EasyDevButton].
void main() => runApp(const ElevatedButtonExampleApp());

class ElevatedButtonExampleApp extends StatelessWidget {
  const ElevatedButtonExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyDevApp(
      darkThemeData: defaultDarkTheme,
      lightThemeData: defaultLightTheme,
      home: const EasyDevScaffold(
        appBar: EasyDevAppBar(title: 'EasyDevButton Sample'),
        body: EasyDevButtonExample(),
      ),
    );
  }
}

class EasyDevButtonExample extends StatelessWidget {
  const EasyDevButtonExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        EasyDevButton.primary(
          text: 'Button',
          onTap: () {},
        ),
        EasyDevButton.primary(
          text: 'Button',
          onTap: () {},
          disabled: true,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            EasyDevButton.primarySmall(
              text: 'Button',
              onTap: () {},
              minWidth: 144,
            ),
          ],
        ),
        EasyDevButton(
          text: 'Button',
          icon: CommunityMaterialIcons.arrow_right,
          onTap: () {},
        ),
        EasyDevButton.outlined(
          text: "Button",
          onTap: () {},
        ),
        EasyDevButton.outlined(
          text: "Button",
          onTap: () {},
          disabled: true,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            EasyDevButton.outlinedSmall(
              text: 'Button',
              onTap: () {},
              minWidth: 144,
            ),
          ],
        ),
        EasyDevButton.outlined(
          text: "Button",
          icon: CommunityMaterialIcons.arrow_right,
          onTap: () {},
        ),
        EasyDevButton(
          text: 'Button',
          onTap: () {},
          softButton: true,
        ),
        EasyDevButton(
          text: 'Button',
          onTap: () {},
          softButton: true,
          disabled: true,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            EasyDevButton.primarySmall(
              text: 'Button',
              onTap: () {},
              softButton: true,
              minWidth: 144,
            ),
          ],
        ),
        EasyDevButton(
          text: 'Button',
          onTap: () {},
          icon: CommunityMaterialIcons.arrow_right,
          softButton: true,
        ),
        EasyDevButton.outlined(
          text: 'Button',
          onTap: () {},
          softButton: true,
        ),
        EasyDevButton.outlined(
          text: 'Button',
          onTap: () {},
          disabled: true,
          softButton: true,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            EasyDevButton.outlinedSmall(
              text: 'Button',
              onTap: () {},
              minWidth: 144,
              softButton: true,
            ),
          ],
        ),
        EasyDevButton.outlined(
          text: 'Button',
          onTap: () {},
          icon: CommunityMaterialIcons.arrow_right,
          softButton: true,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            EasyDevButton.text(
              text: "Button",
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}
