import 'package:community_material_icon/community_material_icon.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';

class ModalMenuButton extends StatelessWidget {
  const ModalMenuButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.easyDevTheme;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        child: Row(
          children: [
            Text(
              text,
              style: theme.typography?.body2Style?.copyWith(
                    color: theme.colorPalette.greySwatch.onSurfaceBright ??
                        theme.colorPalette.greySwatch.onSurfaceColor,
                  ) ??
                  const TextStyle(),
            ),
            const Expanded(
              child: SizedBox(),
            ),
            Icon(
              CommunityMaterialIcons.arrow_right,
              color: theme.colorPalette.greySwatch.onSurfaceBright,
            ),
          ],
        ),
      ),
    );
  }
}
