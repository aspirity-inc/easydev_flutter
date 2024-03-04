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
    final theme = context.easyDevTheme;
    return EasyDevScaffold(
      appBar: const EasyDevAppBar(
        title: 'Sample Code',
      ),
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
      floatingActionButton: EasyDevFloatingActionButton(
        onTap: () {},
        child: const Icon(CommunityMaterialIcons.plus),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => EasyDevScaffoldMessenger.of(context).showSnackBar(
              const EasyDevSnackBar(title: 'This is snackbar'),
            ),
            child: Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 24,
              ),
              color: theme.colorPalette.primarySwatch,
              child: const Text(
                'Show toast',
              ),
            ),
          ),
          GestureDetector(
            onTap: () => EasyDevScaffoldMessenger.of(context).showToast(
              const EasyDevToast(title: 'This is toast'),
            ),
            child: Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 24,
              ),
              color: theme.colorPalette.primarySwatch,
              child: const Text(
                'Show snackbar',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
