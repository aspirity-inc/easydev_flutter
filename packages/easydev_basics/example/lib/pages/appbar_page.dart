import 'package:community_material_icon/community_material_icon.dart';
import 'package:easydev_base_ui/easydev_base_ui.dart';
import 'package:easydev_basics/easydev_basics.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:example_basics/widgets/page_appbar.dart';
import 'package:example_basics/widgets/widget_wrapper.dart';
import 'package:flutter/widgets.dart';

class AppBarPage extends StatefulWidget {
  const AppBarPage({super.key});

  @override
  State<AppBarPage> createState() => _AppBarPageState();
}

class _AppBarPageState extends State<AppBarPage> {
  int selectedAction = 0;
  int selectedAction2 = 0;

  @override
  Widget build(BuildContext context) {
    final theme = context.easyDevTheme;

    final multipleActionsAppBar = EasyDevAppBar(
      title: "Title",
      titleAlignment: Alignment.centerLeft,
      toolbarHeight: MediaQuery.textScalerOf(context).scale(64),
      titleStyle: theme.typography?.heading3Style,
      actions: const [
        EasyDevIconButton(CommunityMaterialIcons.archive_outline),
        EasyDevIconButton(CommunityMaterialIcons.bookmark_outline),
        EasyDevIconButton(CommunityMaterialIcons.file_outline),
      ],
    );

    final appBarWithMenu = EasyDevAppBar(
      title: "Title",
      leading: EasyDevIconButton(CommunityMaterialIcons.chevron_left, onTap: () {}),
      actions: [
        EasyDevActionMenu<int>(
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
      ],
    );

    final appBarWithBottom = EasyDevAppBar(
      title: "Title",
      leading: EasyDevIconButton(CommunityMaterialIcons.chevron_left, onTap: () {}),
      actions: [
        EasyDevActionMenu<int>(
          icon: CommunityMaterialIcons.dots_vertical,
          actions: [
            EasyDevActionMenuItem<int>(
              actionName: 'Action 1',
              value: 1,
              selected: selectedAction2 == 1,
            ),
            EasyDevActionMenuItem<int>(
              actionName: 'Action 2',
              value: 2,
              selected: selectedAction2 == 2,
            ),
          ],
          onSelected: (int value) {
            setState(() {
              selectedAction2 = value;
            });
          },
        ),
      ],
      bottom: EasyDevSearch(
        leadingIcon: const EasyDevIconButton(
          CommunityMaterialIcons.magnify,
          size: 24,
        ),
        trailingIcon: const EasyDevIconButton(
          CommunityMaterialIcons.microphone_outline,
          size: 24,
        ),
        decoration: EasyDevInputDecoration(
          iconColor: theme.brightness == Brightness.light
              ? theme.colorPalette.greySwatch.onBackgroundColor
              : null,
          margin: EdgeInsets.zero,
        ),
        hint: 'Search',
        options: [
          EasyDevSearchOption(value: 'First', onTap: (value) {}),
          EasyDevSearchOption(value: 'Second', onTap: (value) {}),
          EasyDevSearchOption(value: 'Third', onTap: (value) {}),
          EasyDevSearchOption(value: 'Fourth', onTap: (value) {}),
        ],
      ),
    );

    final appBarWithCustomLeading = EasyDevAppBar(
      titleStyle: theme.typography?.subheading2Style,
      title: "Jojo1819",
      titleAlignment: Alignment.centerLeft,
      leading: Container(
        height: 32,
        width: 32,
        decoration: BoxDecoration(
          color: theme.brightness.onSurfaceColor,
          image: const DecorationImage(image: AssetImage("assets/avatar_sample.jpg")),
          border: Border.all(width: 1.5, color: const Color(0xFFC66AFF)),
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),
      ),
      actions: const [
        EasyDevIconButton(CommunityMaterialIcons.magnify),
        EasyDevIconButton(CommunityMaterialIcons.archive_outline),
        EasyDevIconButton(CommunityMaterialIcons.bookmark_outline),
      ],
    );

    final cancelAppBar = EasyDevAppBar(
      toolbarHeight: MediaQuery.textScalerOf(context).scale(54),
      actions: [
        Text(
          'Cancel',
          style: theme.typography?.subheading1Style?.copyWith(
            color: theme.colorPalette.secondarySwatch?[200],
          ),
        ),
      ],
    );

    return EasyDevScaffold(
      backgroundColor: theme.colorPalette.greySwatch.disabledColor,
      appBar: const PageAppBar(
        title: 'App bars page',
      ),
      body: ListView(
        children: [
          WidgetWrapper(
            label: 'AppBar with menu',
            child: SizedBox(
              height: appBarWithMenu.preferredSize.height,
              child: appBarWithMenu,
            ),
          ),
          const SizedBox(height: 16),
          WidgetWrapper(
            label: 'Multiple actions AppBar',
            child: SizedBox(
              height: multipleActionsAppBar.preferredSize.height,
              child: multipleActionsAppBar,
            ),
          ),
          const SizedBox(height: 16),
          WidgetWrapper(
            label: 'AppBar with bottom widget',
            child: SizedBox(
              height: appBarWithBottom.preferredSize.height,
              child: appBarWithBottom,
            ),
          ),
          const SizedBox(height: 16),
          WidgetWrapper(
            label: 'AppBar with custom leading',
            child: SizedBox(
              height: appBarWithCustomLeading.preferredSize.height,
              child: appBarWithCustomLeading,
            ),
          ),
          const SizedBox(height: 16),
          WidgetWrapper(
            label: 'Cancel appbar',
            child: SizedBox(
              height: cancelAppBar.preferredSize.height,
              child: cancelAppBar,
            ),
          ),
        ],
      ),
    );
  }
}
