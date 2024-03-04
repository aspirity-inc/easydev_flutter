import 'package:easydev_basics/easydev_basics.dart';
import 'package:easydev_forms/easydev_forms.dart';
import 'package:example_forms/pages/home_page/routes_adapter.dart';
import 'package:example_forms/widgets/brightness_notifier.dart';
import 'package:flutter/widgets.dart';
import 'package:easydev_theme/easydev_theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final brightnessNotifier = context.dependOnInheritedWidgetOfExactType<BrightnessNotifier>();
    return EasyDevScaffold(
      appBar: EasyDevAppBar(
        toolbarHeight: MediaQuery.textScalerOf(context).scale(58),
        title: 'EasyDev Forms',
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
          'Sliders': '/sliders',
          'Selectables': '/selectables',
          'Date Picker': '/datePicker',
          'Date range picker': '/dateRangePicker',
          'Input code': '/inputCode',
          'Input number': '/inputNumber',
          'Select + Multiselect': '/select',
        },
      ),
    );
  }
}
