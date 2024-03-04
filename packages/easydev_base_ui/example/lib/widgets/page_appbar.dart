import 'package:easydev_basics/easydev_basics.dart';
import 'package:easydev_forms/easydev_forms.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:example/widgets/brightness_notifier.dart';
import 'package:flutter/widgets.dart';

class PageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PageAppBar({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    final brightnessNotifier = context.dependOnInheritedWidgetOfExactType<BrightnessNotifier>();
    return EasyDevAppBar(
      toolbarHeight: MediaQuery.textScalerOf(context).scale(58),
      addBackButton: true,
      title: title,
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(64);
}
