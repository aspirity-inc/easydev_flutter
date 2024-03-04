import 'package:flutter/widgets.dart';
import 'easydev_onboarding.dart';

/// Toolbar for [EasyDevOnboarding].
class EasyDevOnboardingToolbar extends StatelessWidget {
  const EasyDevOnboardingToolbar({
    super.key,
    this.leading,
    this.trailing,
  });

  /// Leading widget of the toolbar.
  /// Typically a text or icon button.
  final Widget? leading;

  /// Trailing widget of the toolbar.
  /// Typically a text or icon button.
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final isNoActions = leading == null && trailing == null;
    final isOnlyLeading = leading != null && trailing == null;
    final isOnlyTrailing = leading == null && trailing != null;

    if (isNoActions) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.all(32),
      child: Row(
        mainAxisAlignment: isOnlyLeading
            ? MainAxisAlignment.start
            : isOnlyTrailing
                ? MainAxisAlignment.end
                : MainAxisAlignment.spaceBetween,
        children: [
          if (leading != null) leading!,
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
