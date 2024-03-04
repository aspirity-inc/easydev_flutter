import 'package:easydev_base_ui/easydev_base_ui.dart';
import 'package:easydev_basics/easydev_basics.dart';
import 'package:example/widgets/page_appbar.dart';
import 'package:example/widgets/widget_wrapper.dart';
import 'package:flutter/widgets.dart';

class SocialMediaButtonPage extends StatelessWidget {
  const SocialMediaButtonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyDevScaffold(
      body: ListView(
        children: [
          WidgetWrapper(
            label: 'Large buttons without background',
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
              ],
            ),
          ),
          WidgetWrapper(
            label: 'Small buttons without background',
            child: Column(
              children: [
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
              ],
            ),
          ),
          WidgetWrapper(
            label: 'Large buttons with background',
            child: Column(
              children: [
                EasyDevSocialMediaButton.google(
                  onTap: () {},
                  type: EasyDevSocialMediaButtonType.withBackground,
                ),
                const SizedBox(height: 16),
                EasyDevSocialMediaButton.facebook(
                  onTap: () {},
                  type: EasyDevSocialMediaButtonType.withBackground,
                ),
                const SizedBox(height: 16),
                EasyDevSocialMediaButton.apple(
                  onTap: () {},
                  type: EasyDevSocialMediaButtonType.withBackground,
                ),
                const SizedBox(height: 16),
                EasyDevSocialMediaButton.vk(
                  onTap: () {},
                  type: EasyDevSocialMediaButtonType.withBackground,
                ),
                const SizedBox(height: 16),
                EasyDevSocialMediaButton.x(
                  onTap: () {},
                  type: EasyDevSocialMediaButtonType.withBackground,
                ),
              ],
            ),
          ),
          WidgetWrapper(
            label: 'Small buttons with background',
            child: Column(
              children: [
                EasyDevSocialMediaButton.google(
                  onTap: () {},
                  type: EasyDevSocialMediaButtonType.withBackground,
                  size: EasyDevSocialMediaButtonSize.small,
                ),
                const SizedBox(height: 16),
                EasyDevSocialMediaButton.facebook(
                  onTap: () {},
                  type: EasyDevSocialMediaButtonType.withBackground,
                  size: EasyDevSocialMediaButtonSize.small,
                ),
                const SizedBox(height: 16),
                EasyDevSocialMediaButton.apple(
                  onTap: () {},
                  type: EasyDevSocialMediaButtonType.withBackground,
                  size: EasyDevSocialMediaButtonSize.small,
                ),
                const SizedBox(height: 16),
                EasyDevSocialMediaButton.vk(
                  onTap: () {},
                  type: EasyDevSocialMediaButtonType.withBackground,
                  size: EasyDevSocialMediaButtonSize.small,
                ),
                const SizedBox(height: 16),
                EasyDevSocialMediaButton.x(
                  onTap: () {},
                  type: EasyDevSocialMediaButtonType.withBackground,
                  size: EasyDevSocialMediaButtonSize.small,
                ),
              ],
            ),
          ),
          WidgetWrapper(
            label: 'Large colorful buttons',
            child: Column(
              children: [
                EasyDevSocialMediaButton.google(
                  onTap: () {},
                  type: EasyDevSocialMediaButtonType.colorful,
                ),
                const SizedBox(height: 16),
                EasyDevSocialMediaButton.facebook(
                  onTap: () {},
                  type: EasyDevSocialMediaButtonType.colorful,
                ),
                const SizedBox(height: 16),
                EasyDevSocialMediaButton.apple(
                  onTap: () {},
                  type: EasyDevSocialMediaButtonType.colorful,
                ),
                const SizedBox(height: 16),
                EasyDevSocialMediaButton.vk(
                  onTap: () {},
                  type: EasyDevSocialMediaButtonType.colorful,
                ),
                const SizedBox(height: 16),
                EasyDevSocialMediaButton.x(
                  onTap: () {},
                  type: EasyDevSocialMediaButtonType.colorful,
                ),
              ],
            ),
          ),
          WidgetWrapper(
            label: 'Small colorful buttons',
            child: Column(
              children: [
                EasyDevSocialMediaButton.google(
                  onTap: () {},
                  type: EasyDevSocialMediaButtonType.colorful,
                  size: EasyDevSocialMediaButtonSize.small,
                ),
                const SizedBox(height: 16),
                EasyDevSocialMediaButton.facebook(
                  onTap: () {},
                  type: EasyDevSocialMediaButtonType.colorful,
                  size: EasyDevSocialMediaButtonSize.small,
                ),
                const SizedBox(height: 16),
                EasyDevSocialMediaButton.apple(
                  onTap: () {},
                  type: EasyDevSocialMediaButtonType.colorful,
                  size: EasyDevSocialMediaButtonSize.small,
                ),
                const SizedBox(height: 16),
                EasyDevSocialMediaButton.vk(
                  onTap: () {},
                  type: EasyDevSocialMediaButtonType.colorful,
                  size: EasyDevSocialMediaButtonSize.small,
                ),
                const SizedBox(height: 16),
                EasyDevSocialMediaButton.x(
                  onTap: () {},
                  type: EasyDevSocialMediaButtonType.colorful,
                  size: EasyDevSocialMediaButtonSize.small,
                ),
              ],
            ),
          ),
          WidgetWrapper(
            label: 'Large monochrome buttons',
            child: Column(
              children: [
                EasyDevSocialMediaButton.google(
                  onTap: () {},
                  type: EasyDevSocialMediaButtonType.monochrome,
                ),
                const SizedBox(height: 16),
                EasyDevSocialMediaButton.facebook(
                  onTap: () {},
                  type: EasyDevSocialMediaButtonType.monochrome,
                ),
                const SizedBox(height: 16),
                EasyDevSocialMediaButton.apple(
                  onTap: () {},
                  type: EasyDevSocialMediaButtonType.monochrome,
                ),
                const SizedBox(height: 16),
                EasyDevSocialMediaButton.vk(
                  onTap: () {},
                  type: EasyDevSocialMediaButtonType.monochrome,
                ),
                const SizedBox(height: 16),
                EasyDevSocialMediaButton.x(
                  onTap: () {},
                  type: EasyDevSocialMediaButtonType.monochrome,
                ),
              ],
            ),
          ),
          WidgetWrapper(
            label: 'Small monochrome buttons',
            child: Column(
              children: [
                EasyDevSocialMediaButton.google(
                  onTap: () {},
                  type: EasyDevSocialMediaButtonType.monochrome,
                  size: EasyDevSocialMediaButtonSize.small,
                ),
                const SizedBox(height: 16),
                EasyDevSocialMediaButton.facebook(
                  onTap: () {},
                  type: EasyDevSocialMediaButtonType.monochrome,
                  size: EasyDevSocialMediaButtonSize.small,
                ),
                const SizedBox(height: 16),
                EasyDevSocialMediaButton.apple(
                  onTap: () {},
                  type: EasyDevSocialMediaButtonType.monochrome,
                  size: EasyDevSocialMediaButtonSize.small,
                ),
                const SizedBox(height: 16),
                EasyDevSocialMediaButton.vk(
                  onTap: () {},
                  type: EasyDevSocialMediaButtonType.monochrome,
                  size: EasyDevSocialMediaButtonSize.small,
                ),
                const SizedBox(height: 16),
                EasyDevSocialMediaButton.x(
                  onTap: () {},
                  type: EasyDevSocialMediaButtonType.monochrome,
                  size: EasyDevSocialMediaButtonSize.small,
                ),
              ],
            ),
          ),
          WidgetWrapper(
            label: 'Icon buttons without background',
            child: Row(
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
          ),
          WidgetWrapper(
            label: 'Icon buttons with background',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EasyDevSocialMediaButton.google(
                  onTap: () {},
                  type: EasyDevSocialMediaButtonType.withBackground,
                  size: EasyDevSocialMediaButtonSize.iconOnly,
                ),
                const SizedBox(width: 16),
                EasyDevSocialMediaButton.facebook(
                  onTap: () {},
                  type: EasyDevSocialMediaButtonType.withBackground,
                  size: EasyDevSocialMediaButtonSize.iconOnly,
                ),
                const SizedBox(width: 16),
                EasyDevSocialMediaButton.apple(
                  onTap: () {},
                  type: EasyDevSocialMediaButtonType.withBackground,
                  size: EasyDevSocialMediaButtonSize.iconOnly,
                ),
                const SizedBox(width: 16),
                EasyDevSocialMediaButton.vk(
                  onTap: () {},
                  type: EasyDevSocialMediaButtonType.withBackground,
                  size: EasyDevSocialMediaButtonSize.iconOnly,
                ),
                const SizedBox(width: 16),
                EasyDevSocialMediaButton.x(
                  onTap: () {},
                  type: EasyDevSocialMediaButtonType.withBackground,
                  size: EasyDevSocialMediaButtonSize.iconOnly,
                ),
              ],
            ),
          ),
          WidgetWrapper(
            label: 'Colorful icon buttons',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EasyDevSocialMediaButton.google(
                  onTap: () {},
                  type: EasyDevSocialMediaButtonType.colorful,
                  size: EasyDevSocialMediaButtonSize.iconOnly,
                ),
                const SizedBox(width: 16),
                EasyDevSocialMediaButton.facebook(
                  onTap: () {},
                  type: EasyDevSocialMediaButtonType.colorful,
                  size: EasyDevSocialMediaButtonSize.iconOnly,
                ),
                const SizedBox(width: 16),
                EasyDevSocialMediaButton.apple(
                  onTap: () {},
                  type: EasyDevSocialMediaButtonType.colorful,
                  size: EasyDevSocialMediaButtonSize.iconOnly,
                ),
                const SizedBox(width: 16),
                EasyDevSocialMediaButton.vk(
                  onTap: () {},
                  type: EasyDevSocialMediaButtonType.colorful,
                  size: EasyDevSocialMediaButtonSize.iconOnly,
                ),
                const SizedBox(width: 16),
                EasyDevSocialMediaButton.x(
                  onTap: () {},
                  type: EasyDevSocialMediaButtonType.colorful,
                  size: EasyDevSocialMediaButtonSize.iconOnly,
                ),
              ],
            ),
          ),
          WidgetWrapper(
            label: 'Monochrome icon buttons',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EasyDevSocialMediaButton.google(
                  onTap: () {},
                  type: EasyDevSocialMediaButtonType.monochrome,
                  size: EasyDevSocialMediaButtonSize.iconOnly,
                ),
                const SizedBox(width: 16),
                EasyDevSocialMediaButton.facebook(
                  onTap: () {},
                  type: EasyDevSocialMediaButtonType.monochrome,
                  size: EasyDevSocialMediaButtonSize.iconOnly,
                ),
                const SizedBox(width: 16),
                EasyDevSocialMediaButton.apple(
                  onTap: () {},
                  type: EasyDevSocialMediaButtonType.monochrome,
                  size: EasyDevSocialMediaButtonSize.iconOnly,
                ),
                const SizedBox(width: 16),
                EasyDevSocialMediaButton.vk(
                  onTap: () {},
                  type: EasyDevSocialMediaButtonType.monochrome,
                  size: EasyDevSocialMediaButtonSize.iconOnly,
                ),
                const SizedBox(width: 16),
                EasyDevSocialMediaButton.x(
                  onTap: () {},
                  type: EasyDevSocialMediaButtonType.monochrome,
                  size: EasyDevSocialMediaButtonSize.iconOnly,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 48,
          ),
        ],
      ),
      appBar: const PageAppBar(
        title: 'Social media buttons page',
      ),
    );
  }
}
