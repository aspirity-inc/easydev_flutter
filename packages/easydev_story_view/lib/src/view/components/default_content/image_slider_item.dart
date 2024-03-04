import 'package:community_material_icon/community_material_icon.dart';
import 'package:easydev_base_ui/easydev_base_ui.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';

/// A customizable story image slider item.
class ImageNetworkSlideItem extends StatefulWidget {
  const ImageNetworkSlideItem({
    required this.url,
    required this.width,
    required this.height,
    this.loadingScreen = const CircularLoadingIndicator(type: IndicatorType.small),
    this.errorScreen,
    this.imageFit = BoxFit.cover,
    super.key,
  });

  /// Image url that shown as slider item.
  final String url;

  /// [ImageNetworkSlideItem] width.
  final double width;

  /// [ImageNetworkSlideItem] height.
  final double height;

  /// The loading screen that is displayed during image loading.
  ///
  /// Default value is 'CircularLoadingIndicator.small()'.
  final Widget loadingScreen;

  /// The error screen that is displayed if something went wrong
  /// during image loading.
  ///
  /// Default behavior is onSurfaceColor
  /// 'CommunityMaterialIcons.alert_circle_outline' on a surfaceColor
  /// background.
  final Widget? errorScreen;

  /// How image should be inscribed into slider item.
  ///
  /// Default value is ' BoxFit.cover'.
  final BoxFit imageFit;

  @override
  State<ImageNetworkSlideItem> createState() => _ImageNetworkSlideItemState();
}

class _ImageNetworkSlideItemState extends State<ImageNetworkSlideItem> {
  @override
  Widget build(BuildContext context) {
    final theme = context.easyDevTheme;
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Image.network(
        widget.url,
        width: widget.width,
        height: widget.height,
        fit: BoxFit.fill,
        frameBuilder: (context, child, frame, _) {
          return frame != null
              ? TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: .1, end: 1),
                  curve: Curves.ease,
                  duration: const Duration(milliseconds: 300),
                  builder: (BuildContext context, double opacity, _) {
                    return Opacity(
                      opacity: opacity,
                      child: child,
                    );
                  },
                )
              : widget.loadingScreen;
        },
        errorBuilder: (_, __, ___) {
          return widget.errorScreen ??
              Container(
                color: theme.colorPalette.greySwatch.surfaceColor,
                width: widget.width,
                height: widget.height,
                alignment: Alignment.center,
                child: Icon(
                  CommunityMaterialIcons.alert_circle_outline,
                  color: theme.colorPalette.greySwatch.onSurfaceColor,
                ),
              );
        },
      ),
    );
  }
}
