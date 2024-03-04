import 'package:easydev_base_ui/src/widgets/easydev_button/easydev_button.dart';
import 'package:flutter/widgets.dart';
import 'package:easydev_base_ui/src/widgets/easydev_onboarding/easydev_onboarding.dart';

/// Data class for [EasyDevOnboarding.pages] field.
///
/// Pages must have [title] and [body] and can have [primaryButton] and [secondaryButton].
class EasyDevOnboardingPageData {
  const EasyDevOnboardingPageData({
    required this.title,
    required this.body,
    this.picture,
    this.primaryButton,
    this.secondaryButton,
    this.backgroundColor,
    this.backgroundImage,
    this.cardMargin,
    this.cardBorderRadius,
    this.cardBackgroundColor,
    this.titleStyle,
    this.bodyStyle,
    this.isPictureOnTop,
  });

  /// Title of the page.
  final String title;

  /// Body of the page.
  final String body;

  /// Picture to show on page with [title] and [body].
  final Widget? picture;

  /// Primary button of the page.
  final EasyDevButton? primaryButton;

  /// Secondary button of the page.
  final EasyDevButton? secondaryButton;

  /// Background color of the page.
  final Color? backgroundColor;

  /// Image used as background of the page.
  final ImageProvider? backgroundImage;

  /// Margin around the page's card.
  final EdgeInsetsGeometry? cardMargin;

  /// Border radius of the page's card.
  final BorderRadius? cardBorderRadius;

  /// Color of the page's card.
  final Color? cardBackgroundColor;

  /// Style of the title is all pages.
  /// Overrides [EasyDevOnboarding.titleStyle] if both are not null.
  final TextStyle? titleStyle;

  /// Style of the body is all pages.
  /// Overrides [EasyDevOnboarding.bodyStyle] if both are not null.
  final TextStyle? bodyStyle;

  /// Whether the [picture] should be on top of [title] and [body].
  final bool? isPictureOnTop;
}
