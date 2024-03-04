import 'package:community_material_icon/community_material_icon.dart';
import 'package:easydev_base_ui/easydev_base_ui.dart';
import 'package:easydev_basics/easydev_basics.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:example/widgets/modal_menu_button.dart';
import 'package:example/widgets/page_appbar.dart';
import 'package:example/widgets/widget_wrapper.dart';
import 'package:flutter/widgets.dart';

class ModalWidgetsPage extends StatefulWidget {
  const ModalWidgetsPage({super.key});

  @override
  State<ModalWidgetsPage> createState() => _ModalWidgetsPageState();
}

class _ModalWidgetsPageState extends State<ModalWidgetsPage> {
  int selectedAction = 0;

  @override
  Widget build(BuildContext context) {
    final theme = context.easyDevTheme;

    return EasyDevScaffold(
      body: ListView(
        children: [
          WidgetWrapper(
            label: 'Action sheet',
            child: EasyDevActionSheet(
              showCancelButton: false,
              actions: [
                EasyDevActionSheetItem(
                  onTap: () {},
                  text: 'Action',
                ),
                EasyDevActionSheetItem(
                  onTap: () {},
                  text: 'Action',
                ),
                EasyDevActionSheetItem(
                  onTap: () {},
                  text: 'Action',
                )
              ],
              title: 'Title',
            ),
          ),
          WidgetWrapper(
            label: 'Action sheet with cancel button',
            child: EasyDevActionSheet(
              actions: [
                EasyDevActionSheetItem(
                  onTap: () {},
                  text: 'Action',
                ),
                EasyDevActionSheetItem(
                  onTap: () {},
                  text: 'Action',
                ),
                EasyDevActionSheetItem(
                  onTap: () {},
                  text: 'Action',
                )
              ],
              title: 'Title',
            ),
          ),
          WidgetWrapper(
            label: 'Action sheet with icons',
            child: EasyDevActionSheet(
              showCancelButton: false,
              actions: [
                EasyDevActionSheetItem(
                  onTap: () {},
                  text: 'Action',
                  icon: CommunityMaterialIcons.book_edit,
                ),
                EasyDevActionSheetItem(
                  onTap: () {},
                  text: 'Action',
                  icon: CommunityMaterialIcons.book_edit,
                ),
                EasyDevActionSheetItem(
                  onTap: () {},
                  text: 'Action',
                  icon: CommunityMaterialIcons.book_edit,
                )
              ],
              title: 'Title',
            ),
          ),
          WidgetWrapper(
            label: 'Action sheet with icons and cancel button',
            child: EasyDevActionSheet(
              cancelIcon: CommunityMaterialIcons.close,
              showCancelButton: true,
              actions: [
                EasyDevActionSheetItem(
                  onTap: () {},
                  text: 'Action',
                  icon: CommunityMaterialIcons.book_edit,
                ),
                EasyDevActionSheetItem(
                  onTap: () {},
                  text: 'Action',
                  icon: CommunityMaterialIcons.book_edit,
                ),
                EasyDevActionSheetItem(
                  onTap: () {},
                  text: 'Action',
                  icon: CommunityMaterialIcons.book_edit,
                )
              ],
              title: 'Title',
            ),
          ),
          WidgetWrapper(
            label: 'Modal button',
            child: DropdownMenuIconButton(
              iconData: CommunityMaterialIcons.dots_vertical,
              actions: [
                ModalMenuButton(
                  text: 'Settings',
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                ModalMenuButton(
                  text: 'Profile',
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                ModalMenuButton(
                  text: 'Log out',
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
          WidgetWrapper(
            label: 'Action menu',
            child: EasyDevActionMenu<int>(
              icon: CommunityMaterialIcons.dots_vertical,
              actions: [
                EasyDevActionMenuItem<int>(
                  actionName: 'Action 1',
                  value: 1,
                  selected: selectedAction == 1,
                ),
                EasyDevActionMenuItem<int>(
                  actionName: 'Action 2',
                  value: 2,
                  selected: selectedAction == 2,
                ),
              ],
              onSelected: (int value) {
                setState(() {
                  selectedAction = value;
                });
              },
            ),
          ),
          WidgetWrapper(
            label: 'Raw modal widget',
            child: RawModalWidget(
              centered: true,
              correctPosition: true,
              modalWidget: Container(
                constraints: const BoxConstraints(
                  maxHeight: 200,
                  maxWidth: 300,
                ),
                color: theme.colorPalette.secondarySwatch,
              ),
              valueChanged: (value) {},
              child: EasyDevButton(
                text: 'Button',
                onTap: () {},
              ),
            ),
          ),
        ],
      ),
      appBar: const PageAppBar(
        title: 'Modal widgets page',
      ),
    );
  }
}
