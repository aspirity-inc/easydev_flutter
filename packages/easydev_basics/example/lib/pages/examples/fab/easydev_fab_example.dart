import 'package:community_material_icon/community_material_icon.dart';
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
      home: const FabExample(),
    );
  }
}

class FabExample extends StatefulWidget {
  const FabExample({super.key});

  @override
  State<FabExample> createState() => _FabExampleState();
}

class _FabExampleState extends State<FabExample> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return EasyDevScaffold(
      appBar: const EasyDevAppBar(
        title: 'Sample Code',
      ),
      body: Center(
        child: Text(
          'You have pressed the button $_count times',
          style: context.easyDevTheme.typography?.subheading2Style,
        ),
      ),
      floatingActionButton: EasyDevFloatingActionButton(
        onTap: () => setState(() {
          _count++;
        }),
        child: const Icon(CommunityMaterialIcons.plus),
      ),
    );
  }
}
