import 'package:community_material_icon/community_material_icon.dart';
import 'package:easydev_forms/easydev_forms.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';

/// Code input button is button that can be created for providing initial state for
/// [EnterCodeWithKeyboard] and [CodeWidget].
class CodeInputButton extends StatelessWidget {
  const CodeInputButton({
    super.key,
    required this.onTap,
    required this.text,
    this.icon,
    this.enabled = true,
  });

  /// Callback on button tap, does not called when button is disabled
  final VoidCallback onTap;

  /// State of button, initially enabled.
  final bool enabled;

  /// Leading icon in code input.
  final IconData? icon;

  /// Text in button
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = context.easyDevTheme;
    return GestureDetector(
      onTap: () {
        if (enabled) {
          onTap();
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon ?? CommunityMaterialIcons.wallet,
              color: _getIconColor(theme),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              text,
              style: theme.typography?.body2Style?.copyWith(
                color: _getTextColor(theme),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color? _getIconColor(EasyDevThemeData theme) {
    if (enabled) {
      return theme.colorPalette.secondarySwatch?[300] ??
          theme.colorPalette.secondarySwatch ??
          theme.colorPalette.primarySwatch;
    }

    if (theme.brightness == Brightness.light) {
      return theme.colorPalette.greySwatch.greyColor;
    }
    return theme.colorPalette.greySwatch.tappedSurfaceColor ??
        theme.colorPalette.greySwatch.disabledColor ??
        theme.colorPalette.greySwatch.greyColor;
  }

  Color? _getTextColor(EasyDevThemeData theme) {
    if (enabled) {
      if (theme.brightness == Brightness.light) {
        return theme.colorPalette.greySwatch.onSurfaceColor;
      }
      return theme.colorPalette.greySwatch.greyColor;
    }

    return theme.colorPalette.greySwatch.unselectedColor ?? theme.colorPalette.greySwatch.greyColor;
  }
}
