import 'package:easydev_basics/easydev_basics.dart';
import 'package:easydev_forms/easydev_forms.dart';
import 'package:example/pages/home_page/routes_adapter.dart';
import 'package:example/widgets/brightness_notifier.dart';
import 'package:flutter/widgets.dart';
import 'package:easydev_theme/easydev_theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final brightnessNotifier = context.dependOnInheritedWidgetOfExactType<BrightnessNotifier>();
    return EasyDevScaffold(
      appBar: EasyDevAppBar(
        title: 'EasyDev Base UI',
        toolbarHeight: MediaQuery.textScalerOf(context).scale(58),
        titleAlignment: Alignment.centerLeft,
        actions: [
          if (brightnessNotifier == null)
            const SizedBox()
          else
            ValueListenableBuilder(
              valueListenable: brightnessNotifier.valueNotifier,
              builder: (context, value, _) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      value == Brightness.dark ? 'Dark theme' : 'Light theme',
                      style: context.easyDevTheme.typography?.heading4Style,
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
      ),
      body: const RoutesAdapter(
        routes: {
          'Buttons': '/buttons',
          'Inputs': '/input',
          'Carousel': '/carousel',
          'Loading indicators': '/loadingIndicators',
          'Social Media': '/socialMediaButton',
          'Tabs': '/tabs',
          'Modal widgets': '/modalWidgets',
          'Onboarding': '/onboarding',
          'Search with autocomplete': '/search',
        },
      ),
    );
  }
}
