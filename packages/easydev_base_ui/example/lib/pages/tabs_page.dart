import 'package:easydev_base_ui/easydev_base_ui.dart';
import 'package:easydev_basics/easydev_basics.dart';
import 'package:example/widgets/page_appbar.dart';
import 'package:example/widgets/widget_wrapper.dart';
import 'package:flutter/widgets.dart';

class TabBarPage extends StatefulWidget {
  const TabBarPage({super.key});

  @override
  State<TabBarPage> createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage> with TickerProviderStateMixin {
  late final EasyDevTabController _tabController2;
  late final EasyDevTabController _tabController3;
  late final EasyDevTabController _tabController4;
  late final List<Widget> _tabs;

  @override
  void initState() {
    super.initState();
    _tabController2 = EasyDevTabController(length: 2, vsync: this);
    _tabController3 = EasyDevTabController(length: 3, vsync: this);
    _tabController4 = EasyDevTabController(length: 4, vsync: this);
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
    _tabController2.dispose();
    _tabController3.dispose();
    _tabController4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return EasyDevScaffold(
      body: ListView(
        children: [
          WidgetWrapper(
            label: 'TabBar with underline tab indicator with 2 tabs',
            child: EasyDevTabBar.underline(
              controller: _tabController2,
              tabs: _tabs.sublist(0, 2),
            ),
          ),
          WidgetWrapper(
            label: 'TabBar with underline tab indicator with 3 tabs',
            child: EasyDevTabBar.underline(
              controller: _tabController3,
              tabs: _tabs.sublist(0, 3),
            ),
          ),
          WidgetWrapper(
            label: 'TabBar with underline tab indicator with 4 tabs',
            child: EasyDevTabBar.underline(
              controller: _tabController4,
              tabs: _tabs,
            ),
          ),
          WidgetWrapper(
            label: 'TabBar with filled tab indicator color with 2 tabs',
            child: EasyDevTabBar.filled(
              controller: _tabController2,
              tabs: _tabs.sublist(0, 2),
            ),
          ),
          WidgetWrapper(
            label: 'TabBar with filled tab indicator color with 3 tabs',
            child: EasyDevTabBar.filled(
              controller: _tabController3,
              tabs: _tabs.sublist(0, 3),
            ),
          ),
          WidgetWrapper(
            label: 'TabBar with filled tab indicator color with 4 tabs',
            child: EasyDevTabBar.filled(
              controller: _tabController4,
              tabs: _tabs,
            ),
          ),
        ],
      ),
      appBar: const PageAppBar(
        title: 'Tabs page',
      ),
    );
  }
}
