import 'package:community_material_icon/community_material_icon.dart';
import 'package:easydev_base_ui/easydev_base_ui.dart';
import 'package:flutter/widgets.dart';

class RoutesAdapter extends StatelessWidget {
  const RoutesAdapter({
    super.key,
    required this.routes,
  });

  final Map<String, String> routes;

  @override
  Widget build(BuildContext context) {
    final routesList = routes.entries.toList();

    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 32),
      physics: const BouncingScrollPhysics(),
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemCount: routesList.length,
      itemBuilder: (context, index) {
        final entry = routesList[index];
        final title = entry.key;
        final routeName = entry.value;
        return EasyDevButton(
          text: title,
          onTap: () => Navigator.of(context).pushNamed(routeName),
          icon: CommunityMaterialIcons.arrow_right,
        );
      },
    );
  }
}
