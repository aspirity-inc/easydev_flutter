import 'package:community_material_icon/community_material_icon.dart';
import 'package:easydev_base_ui/easydev_base_ui.dart';
import 'package:easydev_basics/easydev_basics.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';

/// Flutter code sample for [RawModalWidget].
void main() => runApp(const RawModalWidgetExampleApp());

class RawModalWidgetExampleApp extends StatelessWidget {
  const RawModalWidgetExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyDevApp(
      darkThemeData: defaultDarkTheme,
      lightThemeData: defaultLightTheme,
      home: const EasyDevScaffold(
        appBar: EasyDevAppBar(title: 'RawModalWidget Sample'),
        body: RawModalWidgetExample(),
      ),
    );
  }
}

class RawModalWidgetExample extends StatelessWidget {
  const RawModalWidgetExample({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.easyDevTheme;
    return Center(
      child: RawModalWidget(
        modalWidget: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.5,
          ),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              GestureDetector(
                onTap: Navigator.of(context).pop,
                child: Container(
                  height: 30,
                  width: 50,
                  margin: const EdgeInsets.only(bottom: 5),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    color: theme.colorPalette.greySwatch.onSurfaceColor,
                  ),
                  child: const Center(
                    child: Text('Action 1'),
                  ),
                ),
              ),
              GestureDetector(
                onTap: Navigator.of(context).pop,
                child: Container(
                  height: 30,
                  width: 50,
                  margin: const EdgeInsets.only(bottom: 5),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    color: theme.colorPalette.greySwatch.onSurfaceColor,
                  ),
                  child: const Center(
                    child: Text('Action 2'),
                  ),
                ),
              ),
              GestureDetector(
                onTap: Navigator.of(context).pop,
                child: Container(
                  height: 30,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    color: theme.colorPalette.greySwatch.onSurfaceColor,
                  ),
                  child: const Center(
                    child: Text('Action 3'),
                  ),
                ),
              ),
            ],
          ),
        ),
        valueChanged: (_) {},
        correctPosition: true,
        child: const Icon(
          CommunityMaterialIcons.dots_vertical,
        ),
      ),
    );
  }
}
