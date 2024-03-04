import 'package:community_material_icon/community_material_icon.dart';
import 'package:easydev_basics/easydev_basics.dart';
import 'package:example_basics/widgets/page_appbar.dart';
import 'package:example_basics/widgets/widget_wrapper.dart';
import 'package:flutter/widgets.dart';
import 'package:easydev_theme/easydev_theme.dart';

class BottomNavigationBarPage extends StatefulWidget {
  const BottomNavigationBarPage({super.key});

  @override
  State<BottomNavigationBarPage> createState() => _BottomNavigationBarPageState();
}

class _BottomNavigationBarPageState extends State<BottomNavigationBarPage> {
  int? selectedIndex1;
  int? selectedIndex2;
  int? selectedIndex3;
  int? selectedIndex4;

  @override
  Widget build(BuildContext context) {
    return EasyDevScaffold(
      body: ListView(
        children: [
          WidgetWrapper(
            label: 'Bottom navigation bar',
            child: EasyDevBottomNavigationBar(
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
              currentIndex: selectedIndex1,
              onItemTap: (value) => setState(() {
                selectedIndex1 = value;
              }),
            ),
          ),
          WidgetWrapper(
            label: 'Bottom navigation bar with labels when selected',
            child: EasyDevBottomNavigationBar(
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
              currentIndex: selectedIndex2,
              onItemTap: (value) => setState(() {
                selectedIndex2 = value;
              }),
              showLabel: ShowLabel.selected,
            ),
          ),
          WidgetWrapper(
            label: 'Bottom navigation bar with labels when unselected',
            child: EasyDevBottomNavigationBar(
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
              currentIndex: selectedIndex3,
              onItemTap: (value) => setState(() {
                selectedIndex3 = value;
              }),
              showLabel: ShowLabel.unselected,
            ),
          ),
          WidgetWrapper(
            label: 'Bottom navigation bar with different alignment',
            child: EasyDevBottomNavigationBar(
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
              currentIndex: selectedIndex4,
              onItemTap: (value) => setState(() {
                selectedIndex4 = value;
              }),
              showLabel: ShowLabel.selected,
              alignment: BottomNavigationBarItemAlignment.spaceEvenly,
            ),
          ),
        ],
      ),
      appBar: const PageAppBar(
        title: 'Bottom navigation bar page',
      ),
    );
  }
}
