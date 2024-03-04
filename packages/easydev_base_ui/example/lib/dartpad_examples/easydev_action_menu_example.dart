import 'package:community_material_icon/community_material_icon.dart';
import 'package:easydev_base_ui/easydev_base_ui.dart';
import 'package:easydev_basics/easydev_basics.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';

/// Flutter code sample for [EasyDevActionMenu].
void main() => runApp(const EasyDevActionMenuExampleApp());

class EasyDevActionMenuExampleApp extends StatelessWidget {
  const EasyDevActionMenuExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyDevApp(
      darkThemeData: defaultDarkTheme,
      lightThemeData: defaultLightTheme,
      brightness: Brightness.dark,
      home: const EasyDevScaffold(
        appBar: EasyDevAppBar(title: 'EasyDevActionMenu Sample'),
        body: EasyDevActionMenuExample(),
      ),
    );
  }
}

class EasyDevActionMenuExample extends StatefulWidget {
  const EasyDevActionMenuExample({super.key});

  @override
  State<EasyDevActionMenuExample> createState() => _EasyDevActionMenuExampleState();
}

class _EasyDevActionMenuExampleState extends State<EasyDevActionMenuExample> {
  int selectedAction = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: EasyDevActionMenu<int>(
        icon: CommunityMaterialIcons.dots_vertical,
        actions: [
          EasyDevActionMenuItem<int>(
            actionName: 'Action 1',
            value: 1,
            selected: selectedAction == 1,
          ),
          EasyDevActionMenuItem<int>(
            actionName: 'Action 2',
            value: 2,
            selected: selectedAction == 2,
          ),
        ],
        onSelected: (int value) {
          setState(() {
            selectedAction = value;
          });
        },
      ),
    );
  }
}
