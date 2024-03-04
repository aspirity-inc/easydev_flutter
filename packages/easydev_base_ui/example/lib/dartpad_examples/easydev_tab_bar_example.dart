import 'package:easydev_base_ui/easydev_base_ui.dart';
import 'package:easydev_basics/easydev_basics.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';

/// Flutter code sample for [EasyDevTabBar].
void main() => runApp(const EasyDevTabBarExampleApp());

class EasyDevTabBarExampleApp extends StatelessWidget {
  const EasyDevTabBarExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyDevApp(
      darkThemeData: defaultDarkTheme,
      lightThemeData: defaultLightTheme,
      home: const EasyDevScaffold(
        appBar: EasyDevAppBar(title: 'EasyDevTabBar Sample'),
        body: EasyDevTabBarExample(),
      ),
    );
  }
}

class EasyDevTabBarExample extends StatefulWidget {
  const EasyDevTabBarExample({super.key});

  @override
  State<EasyDevTabBarExample> createState() => _EasyDevTabBarExampleState();
}

class _EasyDevTabBarExampleState extends State<EasyDevTabBarExample> with TickerProviderStateMixin {
  late final EasyDevTabController _tabController;
  late final List<Widget> _tabs;

  @override
  void initState() {
    super.initState();
    _tabController = EasyDevTabController(length: 4, vsync: this);
    _tabs = [
      const EasyDevTab(
        text: "Label",
      ),
      const EasyDevTab(
        text: "Label",
      ),
      const EasyDevTab(
        text: "Label",
      ),
      const EasyDevTab(
        text: "Label",
      ),
    ];
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return EasyDevScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            EasyDevTabBar.underline(
              controller: _tabController,
              tabs: _tabs,
            ),
            const SizedBox(
              height: 32,
            ),
            EasyDevTabBar.filled(
              controller: _tabController,
              tabs: _tabs,
            ),
          ],
        ),
      ),
    );
  }
}
