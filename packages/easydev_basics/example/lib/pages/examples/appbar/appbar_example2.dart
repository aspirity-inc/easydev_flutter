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
      home: const AppBarExample(),
      title: 'AppBar example',
    );
  }
}

class AppBarExample extends StatelessWidget {
  const AppBarExample({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.easyDevTheme;

    return EasyDevScaffold(
      appBar: EasyDevAppBar(
        addBackButton: true,
        actions: [
          GestureDetector(
            onTap: () {
              EasyDevScaffoldMessenger.of(context).showToast(
                const EasyDevToast(title: 'Toast,'),
              );
            },
            child: const Icon(
              CommunityMaterialIcons.toaster,
            ),
          ),
          GestureDetector(
            onTap: () {
              EasyDevScaffoldMessenger.of(context).showSnackBar(
                const EasyDevSnackBar(title: 'Snackbar'),
              );
            },
            child: const Icon(
              CommunityMaterialIcons.message,
            ),
          ),
        ],
        title: 'EasyDevAppBar',
        titleAlignment: Alignment.centerRight,
        titleStyle: theme.typography?.heading1Style?.copyWith(
          fontSize: 24,
        ),
      ),
      body: const Center(
        child: Text('Example'),
      ),
    );
  }
}
