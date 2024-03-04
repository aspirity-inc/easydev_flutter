
import 'package:easydev_story_view/src/view/components/content/story_content.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/scheduler.dart';

/// Image story content.
class ImageContent extends ManagedContent {
  /// Creates an image content.
  ///
  /// - 'url': media source url.
  /// - 'duration': skip duration of the content.
  /// - 'requestHeaders': headers to use when getting the media file.
  /// - 'cacheKey': Key to use when caching media file. Useful if the url has
  /// parameters like timestamp, token etc.
  /// footer provided to [Story]. If this is null, [Story] footer is used.
  /// - 'timeout': Time limit to prepare this content.
  /// - 'errorBuilder': Builder to create error view to show when media couldn't
  /// loaded in [timeout].
  const ImageContent({
    required super.url,
    this.duration = const Duration(seconds: 10),
    super.requestHeaders,
    super.cacheKey,
    super.timeout,
    super.errorBuilder,
    this.imageFit = BoxFit.cover,
    this.backgroundColor,
    super.key,
  });

  /// Skip duration of the content.
  final Duration duration;

  /// How image should be inscribed into content view.
  ///
  /// Default value is ' BoxFit.cover'.
  final BoxFit imageFit;

  /// Background color behind the image.
  ///
  /// Default value is 'surfaceColor'.
  final Color? backgroundColor;

  @override
  StoryContentState<ImageContent> createState() => _ImageContentState();
}

/// State class for image content.
class _ImageContentState extends StoryContentState<ImageContent> {
  ImageProvider? _imageProvider;
  bool _hasError = false;

  @override
  Future<void> initContent() async {
    if (widget.timeout != null) setTimeout(widget.timeout!);

    final file = await loadFile(
      url: widget.url,
      cacheKey: widget.cacheKey,
      requestHeaders: widget.requestHeaders,
    );
    final imageProvider = FileImage(file);

    if (!mounted) return;
    await precacheImage(imageProvider, context);

    if (!mounted) return;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      markReady(duration: widget.duration);
    });
    setState(() {
      _imageProvider = imageProvider;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.easyDevTheme;
    Color backColor =
        widget.backgroundColor ?? theme.colorPalette.greySwatch.surfaceColor;

    if (_hasError && widget.errorBuilder != null) {
      return widget.errorBuilder!.call();
    }

    if (_imageProvider != null) {
      return Container(
        color: backColor,
        constraints: const BoxConstraints.expand(),
        child: Image(
          fit: widget.imageFit,
          image: _imageProvider!,
          frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
            return wasSynchronouslyLoaded
                ? child
                : AnimatedOpacity(
              opacity: frame != null ? 1 : 0,
              duration: const Duration(milliseconds: 300),
            );
          },
          gaplessPlayback: true,
        ),
      );
    }

    return loadingScreen;
  }

  @override
  void onTimeout() {
    setState(() {
      _hasError = true;
    });
  }
}
