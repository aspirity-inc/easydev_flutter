import 'package:community_material_icon/community_material_icon.dart';
import 'package:easydev_base_ui/easydev_base_ui.dart';
import 'package:easydev_basics/easydev_basics.dart';
import 'package:example/widgets/page_appbar.dart';
import 'package:example/widgets/widget_wrapper.dart';
import 'package:flutter/widgets.dart';

class ButtonsPage extends StatelessWidget {
  const ButtonsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyDevScaffold(
      body: ListView(
        children: [
          WidgetWrapper(
            label: 'Primary button',
            child: EasyDevButton.primary(
              text: 'Button',
              onTap: () {},
            ),
          ),
          WidgetWrapper(
            label: 'Primary disabled button',
            child: EasyDevButton.primary(
              text: 'Button',
              onTap: () {},
              disabled: true,
            ),
          ),
          WidgetWrapper(
            label: 'Primary small button',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EasyDevButton.primarySmall(
                  text: 'Button',
                  onTap: () {},
                  minWidth: 144,
                ),
              ],
            ),
          ),
          WidgetWrapper(
            label: 'Primary button with icon',
            child: EasyDevButton(
              text: 'Button',
              icon: CommunityMaterialIcons.arrow_right,
              onTap: () {},
            ),
          ),
          WidgetWrapper(
            label: 'Outlined button',
            child: EasyDevButton.outlined(
              text: "Button",
              onTap: () {},
            ),
          ),
          WidgetWrapper(
            label: 'Outlined disabled button',
            child: EasyDevButton.outlined(
              text: "Button",
              onTap: () {},
              disabled: true,
            ),
          ),
          WidgetWrapper(
            label: 'Outlined small',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EasyDevButton.outlinedSmall(
                  text: 'Button',
                  onTap: () {},
                  minWidth: 144,
                ),
              ],
            ),
          ),
          WidgetWrapper(
            label: 'Outlined button with icon',
            child: EasyDevButton.outlined(
              text: "Button",
              icon: CommunityMaterialIcons.arrow_right,
              onTap: () {},
            ),
          ),
          WidgetWrapper(
            label: 'Soft button',
            child: EasyDevButton(
              text: 'Button',
              onTap: () {},
              softButton: true,
            ),
          ),
          WidgetWrapper(
            label: 'Soft disabled button',
            child: EasyDevButton(
              text: 'Button',
              onTap: () {},
              softButton: true,
              disabled: true,
            ),
          ),
          WidgetWrapper(
            label: 'Soft small button',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EasyDevButton.primarySmall(
                  text: 'Button',
                  onTap: () {},
                  softButton: true,
                  minWidth: 144,
                ),
              ],
            ),
          ),
          WidgetWrapper(
            label: 'Soft button with icon',
            child: EasyDevButton(
              text: 'Button',
              onTap: () {},
              icon: CommunityMaterialIcons.arrow_right,
              softButton: true,
            ),
          ),
          WidgetWrapper(
            label: 'Outlined soft button',
            child: EasyDevButton.outlined(
              text: 'Button',
              onTap: () {},
              softButton: true,
            ),
          ),
          WidgetWrapper(
            label: 'Outlined soft disabled button',
            child: EasyDevButton.outlined(
              text: 'Button',
              onTap: () {},
              disabled: true,
              softButton: true,
            ),
          ),
          WidgetWrapper(
            label: 'Outlined soft small button',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EasyDevButton.outlinedSmall(
                  text: 'Button',
                  onTap: () {},
                  minWidth: 144,
                  softButton: true,
                ),
              ],
            ),
          ),
          WidgetWrapper(
            label: 'Outlined soft button with icon',
            child: EasyDevButton.outlined(
              text: 'Button',
              onTap: () {},
              icon: CommunityMaterialIcons.arrow_right,
              softButton: true,
            ),
          ),
          WidgetWrapper(
            label: 'text button',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EasyDevButton.text(
                  text: "Button",
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
      appBar: const PageAppBar(
        title: 'Buttons page',
      ),
    );
  }
}
