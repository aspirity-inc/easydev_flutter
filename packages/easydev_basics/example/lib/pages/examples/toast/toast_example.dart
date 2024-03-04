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
      home: const BottomSheetExample(),
      title: 'BottomSheet example',
    );
  }
}

class BottomSheetExample extends StatelessWidget {
  const BottomSheetExample({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.easyDevTheme;
    return EasyDevScaffold(
      appBar: const EasyDevAppBar(
        title: 'EasyDevToast',
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
                'Show info toast',
              ),
            ),
          ),
          GestureDetector(
            onTap: () => EasyDevScaffoldMessenger.of(context).showToast(
              const EasyDevToast(
                title: 'This is error toast',
                state: ToastState.error,
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 24,
              ),
              color: theme.colorPalette.primarySwatch,
              child: const Text(
                'Show error toast',
              ),
            ),
          ),
          GestureDetector(
            onTap: () => EasyDevScaffoldMessenger.of(context).showToast(
              const EasyDevToast(
                title: 'This is warning toast',
                state: ToastState.warning,
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 24,
              ),
              color: theme.colorPalette.primarySwatch,
              child: const Text(
                'Show warning toast',
              ),
            ),
          ),
          GestureDetector(
            onTap: () => EasyDevScaffoldMessenger.of(context).showToast(
              const EasyDevToast(
                title: 'This is success toast',
                state: ToastState.success,
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 24,
              ),
              color: theme.colorPalette.primarySwatch,
              child: const Text(
                'Show success toast',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
