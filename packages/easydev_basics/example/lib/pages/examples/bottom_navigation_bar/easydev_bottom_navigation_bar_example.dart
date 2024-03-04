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
      home: const BottomNavBarExample(),
    );
  }
}

class BottomNavBarExample extends StatefulWidget {
  const BottomNavBarExample({super.key});

  @override
  State<BottomNavBarExample> createState() => _BottomNavBarExampleState();
}

class _BottomNavBarExampleState extends State<BottomNavBarExample> {
  int? _currentIndex;

  @override
  Widget build(BuildContext context) {
    return EasyDevScaffold(
      bottomNavigationBar: EasyDevBottomNavigationBar(
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
            needIndicator: true,
          )
        ],
        currentIndex: _currentIndex,
        onItemTap: (value) => setState(() {
          _currentIndex = value;
        }),
        showLabel: ShowLabel.unselected,
      ),
    );
  }
}
