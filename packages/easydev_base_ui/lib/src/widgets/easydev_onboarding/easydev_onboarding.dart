import 'package:easydev_base_ui/easydev_base_ui.dart';
import 'package:easydev_base_ui/src/widgets/easydev_carousel/carousel_indicator.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';

/// Onboarding widget. It simplifies creation of any kind of multi-paged introductions
/// or instructions with optional actions. [EasyDevOnboarding] must have [pageController]
/// and a list of [EasyDevOnboardingPageData], which represent pages of the onboarding.
///
/// Each page's content ([EasyDevOnboardingPageData.title],
/// [EasyDevOnboardingPageData.body] and [EasyDevOnboardingPageData.picture])
/// can be wrapped in a card.
///
/// Optional [EasyDevOnboardingToolbar] can be provided through [toolbar].
/// Other fields can be used to change appearence of [EasyDevOnboarding].
///
///
/// Example of using [EasyDevOnboarding].
/// ```dart
/// ...
/// final PageController controller = PageController();
/// ...
/// EasyDevOnboarding(
///   toolbar: EasyDevOnboardingToolbar(
///     trailing: EasyDevIconButton(
///       CommunityMaterialIcons.close,
///     ),
///   ),
///   controller: controller,
///   pages: [
///     EasyDevOnboardingPageData(
///       title: 'Title 1',
///       body: 'Body 1',
///       picture: SvgPicture.asset('...'),
///     ),
///     EasyDevOnboardingPageData(
///       title: 'Title 1',
///       body: 'Body 1',
///       picture: SvgPicture.asset('...'),
///     ),
///     EasyDevOnboardingPageData(
///       title: 'Title 1',
///       body: 'Body 1',
///       picture: SvgPicture.asset('...'),
///       primaryButton: EasyDevButton(
///         text: 'Enable notifications',
///         onTap: () {},
///       ),
///       secondaryButton: EasyDevButton.outlined(
///         text: 'Maybe later',
///         onTap: () {},
///       ),
///     ),
///   ],
///   cardMargin: const EdgeInsets.all(8),
///   cardBorderRadius: const BorderRadius.all(Radius.circular(8)),
/// ),
/// ```
///
///
/// This sample produces variant of EasyDevOnboarding.
///
/// See code in easydev_base_ui/example/lib/dartpad_examples/easydev_onboarding_example.dart
class EasyDevOnboarding extends StatefulWidget {
  /// Create an onboarding widget.
  ///
  /// To customize page's card appearance use [cardMargin], [cardBorderRadius],
  /// and [cardBackgroundColor] fields.
  const EasyDevOnboarding({
    super.key,
    required this.pageController,
    required this.pages,
    this.toolbar = const EasyDevOnboardingToolbar(),
    this.titleStyle,
    this.bodyStyle,
    this.isPagePictureOnTop = true,
    this.backgroundColor,
    this.backgroundImage,
    this.cardMargin = const EdgeInsets.all(16),
    this.cardBorderRadius = const BorderRadius.all(Radius.circular(8)),
    this.cardBackgroundColor,
    this.pageIndicatorColor,
    this.selectedPageIndicatorColor,
    this.indicatorType = PageIndicatorType.colored,
  });

  /// Page controller to control navigation through onboarding.
  final PageController pageController;

  /// List of info about each page.
  final List<EasyDevOnboardingPageData> pages;

  /// Optional toolbar to show above the pages.
  final EasyDevOnboardingToolbar toolbar;

  /// Style of the title in all pages.
  /// To customize title in a particular page, use [EasyDevOnboardingPageData.titleStyle].
  final TextStyle? titleStyle;

  /// Style of the body in all pages.
  /// To customize body in a particular page, use [EasyDevOnboardingPageData.bodyStyle].
  final TextStyle? bodyStyle;

  /// Specifies if page's picture should be above title and body. Default is [true].
  /// To customize picture's position in a particular page,
  /// use [EasyDevOnboardingPageData.isPictureOnTop].
  final bool isPagePictureOnTop;

  /// Color of each page's background.
  /// To customize it in a particular page, use [EasyDevOnboardingPageData.backgroundColor].
  final Color? backgroundColor;

  /// Background image of each page's background.
  /// To customize it in a particular page, use [EasyDevOnboardingPageData.backgroundImage].
  final ImageProvider? backgroundImage;

  /// Margin of each page's card.
  /// To customize it in a particular page, use [EasyDevOnboardingPageData.cardMargin].
  final EdgeInsetsGeometry cardMargin;

  /// Border radius of each page's card.
  /// To customize it in a particular page, use [EasyDevOnboardingPageData.cardBorderRadius].
  final BorderRadius? cardBorderRadius;

  /// Color of each page's card.
  /// To customize it in a particular page, use [EasyDevOnboardingPageData.cardBackgroundColor].
  final Color? cardBackgroundColor;

  /// Color of page indicator.
  final Color? pageIndicatorColor;

  /// Color of selected page indicator.
  final Color? selectedPageIndicatorColor;

  /// Type of [CarouselIndicator]
  final PageIndicatorType indicatorType;

  @override
  State<EasyDevOnboarding> createState() => _EasyDevOnboardingState();
}

class _EasyDevOnboardingState extends State<EasyDevOnboarding> {
  int currentPage = 0;

  TextStyle? _getTitleStyle(EasyDevThemeData theme) {
    return widget.titleStyle ?? theme.typography?.heading2Style;
  }

  TextStyle? _getBodyStyle(EasyDevThemeData theme) {
    return widget.bodyStyle ?? theme.typography?.body1Style;
  }

  Color _getBackgroundColor(EasyDevThemeData theme) {
    return widget.backgroundColor ??
        theme.colorPalette.greySwatch.backgroundColor ??
        theme.brightness.surfaceColor;
  }

  Color _getPageIndicatorColor(EasyDevThemeData theme) {
    return widget.pageIndicatorColor ??
        theme.colorPalette.greySwatch.tappedSurfaceColor ??
        theme.brightness.onSurfaceColor;
  }

  Color _getSelectedPageIndicatorColor(EasyDevThemeData theme) {
    return widget.selectedPageIndicatorColor ??
        theme.colorPalette.tertiarySwatch?[100] ??
        theme.brightness.onSurfaceColor;
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.easyDevTheme;

    return Stack(
      children: [
        PageView.builder(
          controller: widget.pageController,
          itemCount: widget.pages.length,
          itemBuilder: (context, index) {
            final page = widget.pages[index];
            return _OnboardingPage(
              title: page.title,
              body: page.body,
              picture: page.picture,
              primaryButton: page.primaryButton,
              secondaryButton: page.secondaryButton,
              backgroundImage: page.backgroundImage ?? widget.backgroundImage,
              backgroundColor: page.backgroundColor ?? _getBackgroundColor(theme),
              titleStyle: page.titleStyle ?? _getTitleStyle(theme),
              bodyStyle: page.bodyStyle ?? _getBodyStyle(theme),
              isPictureOnTop: page.isPictureOnTop ?? widget.isPagePictureOnTop,
              cardMargin: page.cardMargin ?? widget.cardMargin,
              cardBorderRadius: page.cardBorderRadius ?? widget.cardBorderRadius,
              cardBackgroundColor: page.cardBackgroundColor ?? widget.cardBackgroundColor,
            );
          },
          onPageChanged: (value) {
            setState(() => currentPage = value);
          },
        ),
        SafeArea(child: widget.toolbar),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CarouselIndicator(
              pageCount: widget.pages.length,
              indicatorAnimationDuration: const Duration(milliseconds: 100),
              unselectedIndicatorColor: _getPageIndicatorColor(theme),
              selectedIndicatorColor: _getSelectedPageIndicatorColor(theme),
              selectedPage: currentPage,
              indicatorType: widget.indicatorType,
            ),
            const SizedBox(height: 160),
          ],
        ),
      ],
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  const _OnboardingPage({
    required this.title,
    required this.body,
    required this.isPictureOnTop,
    required this.cardMargin,
    this.picture,
    this.primaryButton,
    this.secondaryButton,
    this.titleStyle,
    this.bodyStyle,
    this.cardBackgroundColor,
    this.cardBorderRadius,
    this.backgroundColor,
    this.backgroundImage,
  });

  final String title;

  final String body;

  final Widget? picture;

  final EasyDevButton? primaryButton;

  final EasyDevButton? secondaryButton;

  final Color? backgroundColor;

  final ImageProvider? backgroundImage;

  final EdgeInsetsGeometry cardMargin;

  final BorderRadius? cardBorderRadius;

  final Color? cardBackgroundColor;

  final TextStyle? titleStyle;

  final TextStyle? bodyStyle;

  final bool isPictureOnTop;

  DecorationImage? _getBackgroundImage() {
    return backgroundImage == null
        ? null
        : DecorationImage(image: backgroundImage!, fit: BoxFit.cover);
  }

  Gradient? _getBackgroundGradient() {
    return backgroundImage == null
        ? null
        : const LinearGradient(
            colors: [Color(0x00000000), Color(0xFF000000)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          );
  }

  Widget _getCardContents() {
    return picture != null ? _getCardContentsWithPicture() : _getCardContentsWithoutPicture();
  }

  Widget _getCardContentsWithPicture() {
    return Column(
      children: [
        if (isPictureOnTop)
          Container(
            padding: const EdgeInsets.only(bottom: 40),
            alignment: Alignment.topCenter,
            child: picture!,
          ),
        Text(title, style: titleStyle),
        const SizedBox(height: 16),
        SizedBox(
          height: 105,
          child: Text(
            body,
            style: bodyStyle,
          ),
        ),
        if (!isPictureOnTop)
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 40),
              alignment: Alignment.bottomCenter,
              child: picture!,
            ),
          ),
      ],
    );
  }

  Widget _getCardContentsWithoutPicture() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(title, style: titleStyle),
        const SizedBox(height: 16),
        SizedBox(
          height: 105,
          child: Text(body, style: bodyStyle),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isNoButtons = primaryButton == null && secondaryButton == null;
    final isOnlyOneButton = (primaryButton == null && secondaryButton != null) ||
        (primaryButton != null && secondaryButton == null);

    return DecoratedBox(
      decoration: BoxDecoration(
        image: _getBackgroundImage(),
        color: backgroundColor,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: _getBackgroundGradient(),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: cardMargin,
                  child: Container(
                    padding: const EdgeInsets.only(
                      left: 32,
                      right: 32,
                      top: 64,
                    ),
                    decoration: BoxDecoration(
                      color: cardBackgroundColor,
                      borderRadius: cardBorderRadius,
                    ),
                    child: _getCardContents(),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              if (isNoButtons) const SizedBox(height: 144),
              if (isOnlyOneButton) const SizedBox(height: 72),
              if (primaryButton != null) primaryButton!,
              if (secondaryButton != null) secondaryButton!,
            ],
          ),
        ),
      ),
    );
  }
}
