import 'package:easydev_story_view/src/view/components/shadow_decorator.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:easydev_base_ui/easydev_base_ui.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';

/// Default class for story footer.
///
/// Has two named constructors:
/// - [StoryFooter.large] - create a large footer where the main button
/// will appear on top of the rest of the footer elements
///
/// - [StoryFooter.small] - create a small footer where the main button
/// will appear on the same line as the rest of the footer elements
class StoryFooter extends StatefulWidget {
  /// Default constructor of [StoryFooter].
  const StoryFooter({
    super.key,
    required this.mainButtonLabel,
    required this.onMainButton,
    required this.onButtonLikeTap,
    required this.onButtonShareTap,
    required this.onButtonBookmarkTap,
    this.bookmarkInitState = false,
    this.likeInitState = false,
    this.largeFooter = true,
  });

  /// Create a large footer where the main button
  /// will appear on top of the rest of the footer elements
  const StoryFooter.large({
    super.key,
    required this.mainButtonLabel,
    required this.onMainButton,
    required this.onButtonLikeTap,
    required this.onButtonShareTap,
    required this.onButtonBookmarkTap,
    this.bookmarkInitState = false,
    this.likeInitState = false,
  }) : largeFooter = true;

  /// Create a small footer where the main button
  /// will appear on the same line as the rest of the footer elements
  const StoryFooter.small({
    super.key,
    required this.mainButtonLabel,
    required this.onMainButton,
    required this.onButtonLikeTap,
    required this.onButtonShareTap,
    required this.onButtonBookmarkTap,
    this.bookmarkInitState = false,
    this.likeInitState = false,
  }) : largeFooter = false;

  /// If true, the main button will appear on top of the rest of the footer
  /// elements, otherwise appear on the same line as the rest of the footer
  /// elements.
  final bool largeFooter;

  /// Label of the main button in bottom section.
  final String mainButtonLabel;

  /// Callback function.
  ///
  /// Call when user click on the main button in bottom section.
  final void Function() onMainButton;

  /// Callback function.
  ///
  /// Call when user click on the Like button in bottom section.
  final void Function(bool state) onButtonLikeTap;

  /// Callback function.
  ///
  /// Call when user click on the Share button in bottom section.
  final void Function() onButtonShareTap;

  /// Callback function.
  ///
  /// Call when user click on the Bookmark button in bottom section.
  final void Function(bool state) onButtonBookmarkTap;

  /// Initial state of bookmark icon button.
  ///
  /// Default value is 'false'
  final bool bookmarkInitState;

  /// Initial state of like icon button.
  ///
  /// Default value is 'false'
  final bool likeInitState;

  @override
  State<StoryFooter> createState() => _StoryFooterState();
}

class _StoryFooterState extends State<StoryFooter> {
  bool like = false;
  bool bookmark = false;

  void _onLikeChanged() => setState(() {
        like = !like;
        widget.onButtonLikeTap.call(like);
      });

  void _onBookmarkChanged() => setState(() {
        bookmark = !bookmark;
        widget.onButtonBookmarkTap.call(bookmark);
      });

  @override
  void initState() {
    like = widget.likeInitState;
    bookmark = widget.bookmarkInitState;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = EasyDevTheme.of(context);

    final Color fabBackgroundColor = theme.colorPalette.greySwatch.surfaceColor;

    final Color iconColor = (theme.brightness == Brightness.light
        ? (theme.colorPalette.secondarySwatch?[400]) ??
            theme.colorPalette.secondarySwatch ??
            darkThemeViolet400
        : (theme.colorPalette.primarySwatch[400]) ?? theme.colorPalette.primarySwatch);

    final Color shadowColor = (theme.brightness == Brightness.light
            ? ((theme.colorPalette.secondarySwatch?[400]) ?? lightThemeViolet100).withOpacity(.08)
            : (theme.colorPalette.secondarySwatch ?? darkThemeViolet500))
        .withOpacity(.2);

    final double blurRadius = theme.brightness == Brightness.light ? 8 : 5;

    final Offset offset =
        theme.brightness == Brightness.light ? const Offset(0, 2) : const Offset(0, 2);

    const Radius radius = Radius.circular(8);

    Widget mainButton = EasyDevButton(
      text: widget.mainButtonLabel,
      onTap: widget.onMainButton,
      height: 50 + MediaQuery.textScalerOf(context).scale(6),
      margin:
          widget.largeFooter ? const EdgeInsets.symmetric(horizontal: 6) : const EdgeInsets.all(0),
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      expanded: widget.largeFooter,
    );

    return widget.largeFooter
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              mainButton,
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShadowDecorator(
                    shadowColor: shadowColor,
                    blurRadius: blurRadius,
                    offset: offset,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: _onLikeChanged,
                          child: SizedBox(
                            width: 56,
                            height: 56,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.horizontal(left: radius),
                                color: fabBackgroundColor,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Icon(
                                  like
                                      ? CommunityMaterialIcons.heart
                                      : CommunityMaterialIcons.heart_outline,
                                  color: iconColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: _onBookmarkChanged,
                          child: SizedBox(
                            width: 56,
                            height: 56,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.horizontal(right: radius),
                                color: fabBackgroundColor,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Icon(
                                  bookmark
                                      ? CommunityMaterialIcons.bookmark
                                      : CommunityMaterialIcons.bookmark_outline,
                                  color: iconColor,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  ShadowDecorator(
                    shadowColor: shadowColor,
                    blurRadius: blurRadius,
                    offset: offset,
                    child: GestureDetector(
                      onTap: widget.onButtonShareTap,
                      child: SizedBox(
                        width: 56,
                        height: 56,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(radius),
                            color: fabBackgroundColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Icon(
                              CommunityMaterialIcons.share_outline,
                              color: iconColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          )
        : Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: mainButton,
                ),
                ShadowDecorator(
                  shadowColor: shadowColor,
                  blurRadius: blurRadius,
                  offset: offset,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: _onLikeChanged,
                        child: SizedBox(
                          width: 56,
                          height: 56,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.horizontal(left: radius),
                              color: fabBackgroundColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Icon(
                                like
                                    ? CommunityMaterialIcons.heart
                                    : CommunityMaterialIcons.heart_outline,
                                color: iconColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: _onBookmarkChanged,
                        child: SizedBox(
                          width: 56,
                          height: 56,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.zero),
                              color: fabBackgroundColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Icon(
                                bookmark
                                    ? CommunityMaterialIcons.bookmark
                                    : CommunityMaterialIcons.bookmark_outline,
                                color: iconColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: widget.onButtonShareTap,
                        child: SizedBox(
                          width: 56,
                          height: 56,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.horizontal(right: radius),
                              color: fabBackgroundColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Icon(
                                CommunityMaterialIcons.share_outline,
                                color: iconColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
