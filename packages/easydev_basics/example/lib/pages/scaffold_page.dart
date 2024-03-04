import 'package:community_material_icon/community_material_icon.dart';
import 'package:easydev_base_ui/easydev_base_ui.dart';
import 'package:easydev_basics/easydev_basics.dart';
import 'package:easydev_forms/easydev_forms.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:example_basics/widgets/brightness_notifier.dart';
import 'package:flutter/widgets.dart';

class ScaffoldPage extends StatefulWidget {
  const ScaffoldPage({super.key});

  @override
  State<ScaffoldPage> createState() => _ScaffoldPageState();
}

class _ScaffoldPageState extends State<ScaffoldPage> with TickerProviderStateMixin {
  int index = 0;
  int _appbarColorIndex = 0;
  int _bottomNavBarColorIndex = 0;
  late List<Color?> _colors;
  late List<Color?> _titleColors;
  late List<Color?> _iconColors;
  late List<Color?> _selectedIconColors;
  late final EasyDevTabController _tabController;
  late final EasyDevTabController _tabController2;
  bool showBottomNavigationBar = true;
  bool showFloatingActionButton = true;
  bool showAppBar = true;
  bool addSafeArea = false;

  @override
  void initState() {
    _tabController = EasyDevTabController(length: 3, vsync: this);
    _tabController2 = EasyDevTabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final theme = context.easyDevTheme;
    final colorPalette = theme.colorPalette;
    _colors = [
      null,
      colorPalette.greySwatch.onBackgroundColor ?? colorPalette.greySwatch.onSurfaceColor,
      colorPalette.primarySwatch,
    ];
    _titleColors = [
      null,
      colorPalette.greySwatch.backgroundColor,
      colorPalette.greySwatch.backgroundColor,
    ];
    _iconColors = [
      colorPalette.secondarySwatch?[300],
      colorPalette.greySwatch.backgroundColor,
      colorPalette.greySwatch.backgroundColor,
    ];
    _selectedIconColors = [
      null,
      theme.brightness == Brightness.light
          ? (colorPalette.secondarySwatch?[300])
          : colorPalette.secondarySwatch?[600],
      theme.brightness == Brightness.light
          ? (colorPalette.tertiarySwatch?[800])
          : colorPalette.secondarySwatch?[600],
    ];
  }

  @override
  Widget build(BuildContext context) {
    final brightnessNotifier = context.dependOnInheritedWidgetOfExactType<BrightnessNotifier>();

    final theme = context.easyDevTheme;
    return EasyDevScaffold(
      extendBody: true,
      addBodySafeArea: addSafeArea,
      appBar: showAppBar
          ? EasyDevAppBar(
              addBackButton: true,
              leadingIconTheme: IconThemeData(
                color: _iconColors[_appbarColorIndex],
              ),
              title: 'EasyDev UI-kit',
              backgroundColor: _colors[_appbarColorIndex],
              titleStyle: theme.typography?.heading4Style?.copyWith(
                color: _titleColors[_appbarColorIndex],
              ),
              titleAlignment: Alignment.centerLeft,
              actions: [
                if (brightnessNotifier != null)
                  ValueListenableBuilder(
                    valueListenable: brightnessNotifier.valueNotifier,
                    builder: (context, value, _) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            value == Brightness.dark ? 'Dark theme' : 'Light theme',
                            style: context.easyDevTheme.typography?.heading4Style?.copyWith(
                              color: _titleColors[_appbarColorIndex],
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          EasyDevSwitch.adaptive(
                            value: value == Brightness.dark,
                            onSelect: (_) {
                              brightnessNotifier.updateBrightness();
                            },
                          ),
                        ],
                      );
                    },
                  ),
              ],
            )
          : null,
      bottomNavigationBar: showBottomNavigationBar
          ? EasyDevBottomNavigationBar(
              backgroundColor: _colors[_bottomNavBarColorIndex],
              unselectedIconColor: _iconColors[_bottomNavBarColorIndex],
              selectedIconColor: _selectedIconColors[_bottomNavBarColorIndex],
              selectedLabelColor: _selectedIconColors[_bottomNavBarColorIndex],
              items: [
                EasyDevBottomNavigationBarItem(
                  icon: CommunityMaterialIcons.search_web,
                  label: 'Search',
                  needIndicator: true,
                ),
                EasyDevBottomNavigationBarItem(
                  icon: CommunityMaterialIcons.hamburger,
                  label: 'Hamburger',
                ),
                EasyDevBottomNavigationBarItem(
                  icon: CommunityMaterialIcons.rabbit,
                  label: 'Rabbit',
                ),
                EasyDevBottomNavigationBarItem(
                  icon: CommunityMaterialIcons.sass,
                  label: 'Sass',
                )
              ],
              currentIndex: index,
              onItemTap: (value) {
                setState(() {
                  index = value;
                });
              },
              showLabel: ShowLabel.selected,
            )
          : null,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Appbar color',
            style: theme.typography?.subheading2Style,
          ),
          EasyDevTabBar.filled(
            controller: _tabController,
            padding: const EdgeInsets.symmetric(vertical: 16),
            onTap: (value) {
              setState(() {
                _appbarColorIndex = value;
              });
            },
            tabs: const [
              EasyDevTab(
                text: 'no color',
              ),
              EasyDevTab(
                text: 'negative ',
              ),
              EasyDevTab(
                text: 'primary ',
              ),
            ],
          ),
          Text(
            'Bottom navigation bar color',
            style: theme.typography?.subheading2Style,
          ),
          EasyDevTabBar.filled(
            controller: _tabController2,
            padding: const EdgeInsets.symmetric(vertical: 16),
            onTap: (value) {
              setState(() {
                _bottomNavBarColorIndex = value;
              });
            },
            tabs: const [
              EasyDevTab(
                text: 'no color',
              ),
              EasyDevTab(
                text: 'negative ',
              ),
              EasyDevTab(
                text: 'primary ',
              ),
            ],
          ),
          EasyDevButton(
            text: 'Show snackbar',
            onTap: () => EasyDevScaffoldMessenger.of(context).showSnackBar(
              const EasyDevSnackBar(
                title: 'Snackbar',
              ),
            ),
          ),
          EasyDevButton(
            text: 'Show toast',
            onTap: () {
              EasyDevScaffoldMessenger.of(context)
                ..removeCurrentToast()
                ..showToast(
                  const EasyDevToast(
                    title: 'Toast',
                  ),
                );
            },
          ),
          EasyDevLabelWithSwitch(
            label: 'Show bottom bar',
            value: showBottomNavigationBar,
            onSelect: (_) => setState(() {
              showBottomNavigationBar = !showBottomNavigationBar;
            }),
            expanded: true,
            padding: const EdgeInsets.symmetric(vertical: 8),
            switchHeight: 28,
          ),
          EasyDevLabelWithSwitch(
            label: 'Show app bar',
            value: showAppBar,
            onSelect: (_) => setState(() {
              showAppBar = !showAppBar;
            }),
            expanded: true,
            padding: const EdgeInsets.symmetric(vertical: 8),
            switchHeight: 28,
          ),
          EasyDevLabelWithSwitch(
            label: 'Show FAB',
            value: showFloatingActionButton,
            onSelect: (_) => setState(() {
              showFloatingActionButton = !showFloatingActionButton;
            }),
            expanded: true,
            padding: const EdgeInsets.symmetric(vertical: 8),
            switchHeight: 28,
          ),
          EasyDevLabelWithSwitch(
            label: 'Add safe area',
            value: addSafeArea,
            onSelect: (_) => setState(() {
              addSafeArea = !addSafeArea;
            }),
            expanded: true,
            padding: const EdgeInsets.symmetric(vertical: 8),
            switchHeight: 28,
          ),
          Container(
            color: const Color(0xFFFFFF00),
            height: 500,
          ),
        ],
      ),
      floatingActionButton: showFloatingActionButton
          ? EasyDevFloatingActionButton(
              onTap: () {},
              child: const Icon(CommunityMaterialIcons.plus),
            )
          : null,
    );
  }
}
