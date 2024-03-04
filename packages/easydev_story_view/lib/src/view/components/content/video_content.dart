import 'dart:async';

import 'package:easydev_story_view/src/view/components/content/story_content.dart';
import 'package:easydev_theme/easydev_theme.dart';
import 'package:video_player/video_player.dart';

import 'package:flutter/widgets.dart';

/// View for video contents.
class VideoContent extends ManagedContent {
  /// Creates a video view. Video content skip duration is video duration by
  /// default and cannot be changed.
  /// If you want to create a video story with different duration, you can
  /// create a custom content class by extending [StoryContent].
  ///
  /// - 'url': Media source url.
  /// - 'requestHeaders': Headers to use when getting the media file.
  /// - 'cacheKey': Key to use when caching media file.
  /// - 'timeout': Time limit to prepare this content.
  /// - 'errorBuilder': Builder to create error view to show when media couldn't
  /// loaded in [timeout].
  const VideoContent({
    required super.url,
    super.requestHeaders,
    super.cacheKey,
    super.timeout,
    super.errorBuilder,
    this.backgroundColor,
    super.key,
  });

  /// Background color behind the video.
  ///
  /// Default value is 'surfaceColor'.
  final Color? backgroundColor;

  @override
  StoryContentState<VideoContent> createState() => _VideoContentState();
}

/// State class for video content.
class _VideoContentState extends StoryContentState<VideoContent> {
  VideoPlayerController? _videoController;
  bool _hasError = false;

  @override
  Future<void> initContent() async {
    if (widget.timeout != null) setTimeout(widget.timeout!);

    final file = await loadFile(
      url: widget.url,
      cacheKey: widget.cacheKey,
      requestHeaders: widget.requestHeaders,
    );

    if (!mounted) return;
    final controller = VideoPlayerController.file(file);
    await controller.initialize();

    if (!mounted) return;
    setState(() {
      _videoController = controller;
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      markReady(duration: controller.value.duration);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.easyDevTheme;
    Color backColor = widget.backgroundColor ?? theme.colorPalette.greySwatch.surfaceColor;

    if (_hasError && widget.errorBuilder != null) {
      return widget.errorBuilder!.call();
    }

    if (_videoController?.value.isInitialized == true) {
      return ColoredBox(
        color: backColor,
        child: Center(
          child: AspectRatio(
            aspectRatio: _videoController!.value.aspectRatio,
            child: VideoPlayer(_videoController!),
          ),
        ),
      );
    }

    return loadingScreen;
  }

  @override
  void onStart() {
    _videoController?.play();
  }

  @override
  onResume() {
    _videoController?.play();
  }

  @override
  void onPause() {
    _videoController?.pause();
  }

  @override
  void onStop() {
    _videoController?.pause();
    _videoController?.seekTo(Duration.zero);
  }

  @override
  void onTimeout() {
    if (!mounted) {
      _videoController?.dispose();
      return;
    }
    setState(() {
      _hasError = true;
    });
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }
}
