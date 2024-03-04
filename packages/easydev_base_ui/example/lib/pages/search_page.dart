import 'package:community_material_icon/community_material_icon.dart';
import 'package:easydev_base_ui/easydev_base_ui.dart';
import 'package:easydev_basics/easydev_basics.dart';
import 'package:example/widgets/page_appbar.dart';
import 'package:example/widgets/widget_wrapper.dart';
import 'package:flutter/widgets.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyDevScaffold(
      body: ListView(
        children: [
          WidgetWrapper(
            label: 'Simple search',
            child: EasyDevSearch(
              hint: 'Search',
              leadingIcon: const EasyDevIconButton(CommunityMaterialIcons.magnify, size: 24),
              trailingIcon: const EasyDevIconButton(CommunityMaterialIcons.microphone, size: 24),
              options: [
                EasyDevSearchOption(value: 'First', onTap: (value) {}),
                EasyDevSearchOption(value: 'Second', onTap: (value) {}),
                EasyDevSearchOption(value: 'Third', onTap: (value) {}),
                EasyDevSearchOption(value: 'Fourth', onTap: (value) {}),
              ],
            ),
          ),
          WidgetWrapper(
            label: 'Customized search',
            child: EasyDevSearch(
              hint: 'Search',
              leadingIcon: const EasyDevIconButton(CommunityMaterialIcons.car),
              trailingIcon: const EasyDevIconButton(CommunityMaterialIcons.abacus),
              options: [
                EasyDevSearchOption(value: 'First', onTap: (value) {}),
                EasyDevSearchOption(value: 'Second', onTap: (value) {}),
                EasyDevSearchOption(value: 'Third', onTap: (value) {}),
                EasyDevSearchOption(value: 'Fourth', onTap: (value) {}),
                EasyDevSearchOption(value: 'Fifth', onTap: (value) {}),
                EasyDevSearchOption(value: 'Sixth', onTap: (value) {}),
                EasyDevSearchOption(value: 'Seventh', onTap: (value) {}),
              ],
            ),
          ),
        ],
      ),
      appBar: const PageAppBar(
        title: 'Search page',
      ),
    );
  }
}
