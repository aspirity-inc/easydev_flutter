import 'package:easydev_base_ui/easydev_base_ui.dart';
import 'package:easydev_basics/easydev_basics.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';

/// Flutter code sample for [EasyDevSocialMediaButton].
void main() => runApp(const EasyDevSocialMediaButtonExampleApp());

class EasyDevSocialMediaButtonExampleApp extends StatelessWidget {
  const EasyDevSocialMediaButtonExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyDevApp(
      darkThemeData: defaultDarkTheme,
      lightThemeData: defaultLightTheme,
      home: const EasyDevScaffold(
        appBar: EasyDevAppBar(title: 'EasyDevSocialMediaButton Sample'),
        body: EasyDevSocialMediaButtonExample(),
      ),
    );
  }
}

class EasyDevSocialMediaButtonExample extends StatelessWidget {
  const EasyDevSocialMediaButtonExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              EasyDevSocialMediaButton.google(
                onTap: () {},
                type: EasyDevSocialMediaButtonType.noBackground,
              ),
              const SizedBox(height: 16),
              EasyDevSocialMediaButton.facebook(
                onTap: () {},
                type: EasyDevSocialMediaButtonType.noBackground,
              ),
              const SizedBox(height: 16),
              EasyDevSocialMediaButton.apple(
                onTap: () {},
                type: EasyDevSocialMediaButtonType.noBackground,
              ),
              const SizedBox(height: 16),
              EasyDevSocialMediaButton.vk(
                onTap: () {},
                type: EasyDevSocialMediaButtonType.noBackground,
              ),
              const SizedBox(height: 16),
              EasyDevSocialMediaButton.x(
                onTap: () {},
                type: EasyDevSocialMediaButtonType.noBackground,
              ),
              const SizedBox(height: 16),
              EasyDevSocialMediaButton.google(
                onTap: () {},
                type: EasyDevSocialMediaButtonType.noBackground,
                size: EasyDevSocialMediaButtonSize.small,
              ),
              const SizedBox(height: 16),
              EasyDevSocialMediaButton.facebook(
                onTap: () {},
                type: EasyDevSocialMediaButtonType.noBackground,
                size: EasyDevSocialMediaButtonSize.small,
              ),
              const SizedBox(height: 16),
              EasyDevSocialMediaButton.apple(
                onTap: () {},
                type: EasyDevSocialMediaButtonType.noBackground,
                size: EasyDevSocialMediaButtonSize.small,
              ),
              const SizedBox(height: 16),
              EasyDevSocialMediaButton.vk(
                onTap: () {},
                type: EasyDevSocialMediaButtonType.noBackground,
                size: EasyDevSocialMediaButtonSize.small,
              ),
              const SizedBox(height: 16),
              EasyDevSocialMediaButton.x(
                onTap: () {},
                type: EasyDevSocialMediaButtonType.noBackground,
                size: EasyDevSocialMediaButtonSize.small,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  EasyDevSocialMediaButton.google(
                    onTap: () {},
                    type: EasyDevSocialMediaButtonType.noBackground,
                    size: EasyDevSocialMediaButtonSize.iconOnly,
                  ),
                  const SizedBox(width: 16),
                  EasyDevSocialMediaButton.facebook(
                    onTap: () {},
                    type: EasyDevSocialMediaButtonType.noBackground,
                    size: EasyDevSocialMediaButtonSize.iconOnly,
                  ),
                  const SizedBox(width: 16),
                  EasyDevSocialMediaButton.apple(
                    onTap: () {},
                    type: EasyDevSocialMediaButtonType.noBackground,
                    size: EasyDevSocialMediaButtonSize.iconOnly,
                  ),
                  const SizedBox(width: 16),
                  EasyDevSocialMediaButton.vk(
                    onTap: () {},
                    type: EasyDevSocialMediaButtonType.noBackground,
                    size: EasyDevSocialMediaButtonSize.iconOnly,
                  ),
                  const SizedBox(width: 16),
                  EasyDevSocialMediaButton.x(
                    onTap: () {},
                    type: EasyDevSocialMediaButtonType.noBackground,
                    size: EasyDevSocialMediaButtonSize.iconOnly,
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 48,
        ),
      ],
    );
  }
}
