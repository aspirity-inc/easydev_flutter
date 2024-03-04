import 'package:community_material_icon/community_material_icon.dart';
import 'package:easydev_basics/easydev_basics.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:example_basics/widgets/page_appbar.dart';
import 'package:example_basics/widgets/widget_wrapper.dart';
import 'package:flutter/widgets.dart';

class FabPage extends StatelessWidget {
  const FabPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = EasyDevTheme.of(context);

    return EasyDevScaffold(
      appBar: const PageAppBar(
        title: 'Floating action buttons page',
      ),
      body: ListView(
        children: [
          WidgetWrapper(
            label: 'Large FAB',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EasyDevFloatingActionButton(
                  onTap: () {},
                  child: const Icon(
                    CommunityMaterialIcons.plus,
                  ),
                ),
              ],
            ),
          ),
          WidgetWrapper(
            label: 'Small FAB',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EasyDevFloatingActionButton(
                  onTap: () {},
                  isLarge: false,
                  child: const Icon(
                    CommunityMaterialIcons.plus,
                  ),
                ),
              ],
            ),
          ),
          WidgetWrapper(
            label: 'Disabled FAB',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EasyDevFloatingActionButton(
                  onTap: () {},
                  disabled: true,
                  child: const Icon(CommunityMaterialIcons.plus),
                ),
              ],
            ),
          ),
          WidgetWrapper(
            label: 'Disabled small FAB',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EasyDevFloatingActionButton(
                  onTap: () {},
                  disabled: true,
                  isLarge: false,
                  child: const Icon(CommunityMaterialIcons.plus),
                ),
              ],
            ),
          ),
          WidgetWrapper(
            label: 'FAB with custom color and shape',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EasyDevFloatingActionButton(
                  onTap: () {},
                  color: theme.colorPalette.primarySwatch[600],
                  tapColor: theme.colorPalette.linksSwatch?[400],
                  radius: 28,
                  elevation: 8,
                  tapElevation: 32,
                  child: const Icon(
                    CommunityMaterialIcons.star,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
